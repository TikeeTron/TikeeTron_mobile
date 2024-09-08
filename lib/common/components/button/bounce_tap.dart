import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common.dart';
import '../splash/wave_splash.dart';

class BounceTap extends StatefulWidget {
  // This will get the data from the pages
  // Makes sure child won't be passed as null
  const BounceTap({
    Key? key,
    this.duration,
    this.useInkWell,
    this.borderRadiusInkWell,
    this.disabled,
    this.scale,
    this.onLongPress,
    this.useSplash,
    this.onTap,
    required this.child,
    this.onTapDown,
    this.useMediumHaptic = false,
    this.useHeavyHaptic = false,
    this.useLightHaptic = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Widget child;
  final Duration? duration;
  final bool? useInkWell;
  final bool? useSplash;
  final BorderRadius? borderRadiusInkWell;
  final bool? disabled;
  final int? scale;
  final void Function()? onLongPress;
  final void Function()? onTapDown;
  final bool useMediumHaptic;
  final bool useHeavyHaptic;
  final bool useLightHaptic;

  @override
  BounceTapState createState() => BounceTapState();
}

class BounceTapState extends State<BounceTap> with SingleTickerProviderStateMixin {
  late double _scale;

  // This controller is responsible for the animation
  late AnimationController _animate;

  //Getting the VoidCallack onPressed passed by the user
  VoidCallback? get onTap => widget.onTap;

  VoidCallback? get onTapDown => widget.onTapDown;

  // This is a user defined duration, which will be responsible for
  // what kind of BounceTap he/she wants
  Duration get userDuration => widget.duration ?? const Duration(milliseconds: 50);

  bool useInkWell = false;

  @override
  void initState() {
    super.initState();

    //defining the controller
    _animate = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ), //This is an inital controller duration
      lowerBound: 0.0,
      upperBound: 0.02,
    )..addListener(() {
        setState(() {});
      }); // Can do something in the listener, but not required

    useInkWell = widget.useInkWell ?? false;
  }

  @override
  void dispose() {
    // To dispose the contorller when not required
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value * (widget.scale ?? 1);

    if (useInkWell == true) {
      return Material(
        color: Colors.transparent,
        child: Theme(
          data: Theme.of(context).copyWith(
            highlightColor: widget.useSplash == true ? context.theme.colors.primary.withOpacity(0.01) : Colors.transparent,
            splashColor: widget.useSplash == true ? context.theme.colors.primary.withOpacity(0.1) : Colors.transparent,
            hoverColor: widget.useSplash == true ? context.theme.colors.primary.withOpacity(0.1) : Colors.transparent,
            splashFactory: NoSplash.splashFactory,
          ),
          child: InkWell(
            onTap: _onTap,
            onTapDown: _onTapDown,
            borderRadius: widget.borderRadiusInkWell,
            splashColor: widget.useSplash == true ? context.theme.colors.primary.withOpacity(0.1) : Colors.transparent,
            splashFactory: widget.useSplash == true ? WaveSplash.splashFactory : NoSplash.splashFactory,
            child: Transform.scale(
              scale: _scale,
              child: widget.child,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _onTap,
      onTapDown: (details) => _onTapDown,
      onLongPress: widget.onLongPress,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  //This is where the animation works out for us
  // Both the animation happens in the same method,
  // but in a duration of time, and our callback is called here as well
  void _onTap() {
    if (widget.disabled != true) {
      if (widget.useLightHaptic) {
        HapticFeedback.lightImpact();
      } else if (widget.useMediumHaptic) {
        HapticFeedback.mediumImpact();
      } else if (widget.useHeavyHaptic) {
        HapticFeedback.heavyImpact();
      }
      //Firing the animation right away
      _animate.forward();

      //Now reversing the animation after the user defined duration
      Future.delayed(userDuration, () {
        if (mounted) {
          _animate.reverse();
        }

        //Calling the callback
        if (widget.onTap != null) {
          onTap!();
        }
      });
    }
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.disabled != true) {
      HapticFeedback.lightImpact();
      //Firing the animation right away
      _animate.forward();

      //Now reversing the animation after the user defined duration
      Future.delayed(userDuration, () {
        _animate.reverse();

        //Calling the callback
        if (widget.onTapDown != null) {
          onTapDown!();
        }
      });
    }
  }
}
