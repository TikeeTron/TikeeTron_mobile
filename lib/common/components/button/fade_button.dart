import 'dart:async';

import 'package:flutter/widgets.dart';
import '../../constants/animation_const.dart';

class UIFadeButton extends StatefulWidget {
  const UIFadeButton({
    super.key,
    required this.child,
    this.onTap,
    this.begin = 1.0,
    this.end = 0.7,
    this.beginDuration = const Duration(milliseconds: 30),
    this.endDuration = const Duration(milliseconds: 120),
    this.longTapRepeatDuration = const Duration(milliseconds: 100),
    this.beginCurve = AnimationsConst.curveComponent,
    this.endCurve = AnimationsConst.curveComponent,
    this.onLongTap,
    this.enableLongTapRepeatEvent = false,
    this.behavior = HitTestBehavior.deferToChild,
  });

  final Widget child;
  final double begin, end;
  final Duration beginDuration, endDuration, longTapRepeatDuration;
  final Function()? onTap, onLongTap;
  final bool enableLongTapRepeatEvent;
  final Curve beginCurve, endCurve;
  final HitTestBehavior behavior;

  @override
  State<UIFadeButton> createState() => _UIFadeButtonState();
}

class _UIFadeButtonState extends State<UIFadeButton>
    with SingleTickerProviderStateMixin<UIFadeButton> {
  AnimationController? _controller;
  late Animation<double> _animation;

  bool _isOnTap = true;

  Future<void> _onLongPress() async {
    await _controller?.forward();

    await widget.onLongTap?.call();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.endDuration,
      value: 1.0,
      reverseDuration: widget.beginDuration,
    );

    _animation = Tween(
      begin: widget.end,
      end: widget.begin,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: widget.beginCurve,
        reverseCurve: widget.endCurve,
      ),
    );

    _controller?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior,
      onTap: widget.onTap,
      onLongPress: widget.onLongTap != null && !widget.enableLongTapRepeatEvent
          ? _onLongPress
          : null,
      child: Listener(
        behavior: widget.behavior,
        onPointerDown: (c) async {
          _isOnTap = true;

          _controller?.reverse();

          if (widget.enableLongTapRepeatEvent) {
            await Future.delayed(widget.longTapRepeatDuration);

            while (_isOnTap)
              await Future.delayed(widget.longTapRepeatDuration, () async {
                await (widget.onLongTap ?? widget.onTap)?.call();
              });
          }
        },
        onPointerUp: (c) async {
          _isOnTap = false;

          await _controller?.forward();
        },
        child: FadeTransition(
          opacity: _animation,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller
      ?..stop()
      ..dispose();
    _controller = null;

    super.dispose();
  }
}
