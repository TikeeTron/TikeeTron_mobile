import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:vibration/vibration.dart';

import '../../../common/common.dart';
import '../../../common/components/button/bounce_tap.dart';
import '../../../common/components/button/button_text_ui.dart';
import '../../../common/components/cliprrect/smooth_cliprrect.dart';
import '../../../common/components/container/rounded_container.dart';
import '../../../common/config/padding_config.dart';
import '../../../common/constants/duration_constant.dart';
import '../../../common/utils/helpers/local_auth_helper.dart';
import '../../../common/utils/helpers/logger_helper.dart';
import '../../../core/injector/injector.dart';
import '../../wallet/data/repositories/source/local/account_local_repository.dart';
import 'cubit/pin/pin_cubit.dart';
import 'widget/animation_shake_widget.dart';

class PinPage extends StatefulWidget {
  const PinPage({
    super.key,
    this.passedData,
    required this.noCancel,
    this.isSetBiometric,
    this.initShowBiometric,
  });

  final dynamic passedData;
  final bool noCancel;
  final bool? isSetBiometric;
  final bool? initShowBiometric;

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  List<int> value = [];
  List<int> confirmPin = [];
  List<int> changePin = [];
  List<int> confirmChangePin = [];
  bool isCorrectOldPin = false;
  String title = "Input PIN";
  String subTitle = "Add a pin number to make your wallet more secure.";
  bool showSubtitle = false;
  bool useConfirm = false;

  @override
  void initState() {
    if (locator<AccountLocalRepository>().getUserPin().isEmpty) {
      setState(() {
        useConfirm = true;
        title = 'Setup Pin Code';
        showSubtitle = true;
      });
    }

    if (widget.initShowBiometric == true) {
      _handleUseFingerPrint();
    }

    super.initState();
  }

  bool hasError = false;
  final GlobalKey<CustomShakeWidgetState> _confirmKey = GlobalKey();

  void _addNumber(int v) {
    if (value.length < 6) {
      setState(() {
        value.add(v);
      });
      if (value.length == 6) {
        if (widget.passedData == 'change-pin-apps') {
          _handleChangePin();
        } else {
          _handleConfirm();
        }
      }
    }
  }

  void _removeNumber() {
    if (value.isNotEmpty) {
      setState(() {
        value.removeAt(value.length - 1);
        hasError = false;
      });
    }
  }

  void _handleChangePin() async {
    Function eq = const ListEquality().equals;
    if (!isCorrectOldPin) {
      if (eq(value, locator<AccountLocalRepository>().getUserPin())) {
        setState(() {
          isCorrectOldPin = true;
        });
        setState(() {
          value.clear();
          title = "Change PIN";
          showSubtitle = true;
          subTitle = "Make sure to remember your PIN because we dont store anywhere else except your local storage otherwise you cannot access your wallet";
        });
      } else {
        setState(() {
          hasError = true;
        });
        Future.delayed(DurationConstant.d300, () {
          if (mounted) {
            setState(() {
              value.clear();
              hasError = false;
            });
          }
        });
        Vibration.vibrate(duration: 300);
        _confirmKey.currentState?.shake();
      }
    } else {
      if (changePin.isEmpty) {
        setState(() {
          changePin.addAll([...value]);
          value.clear();
          title = "Confirm Change PIN";
        });
      } else {
        Function eq = const ListEquality().equals;
        if (eq(value, changePin)) {
          locator<AccountLocalRepository>().setUserPin(value);

          BlocProvider.of<PinCubit>(context).pinCreated(
            pin: value.join(''),
            passedData: widget.passedData,
          );
          toastHelper.showInformation('your pin has been changed successfully');
        } else {
          setState(() {
            hasError = true;
          });

          Vibration.vibrate(duration: 300);
          _confirmKey.currentState?.shake();
        }
      }
    }
  }

  void _handleConfirm() async {
    setState(() {
      hasError = false;
    });
    if (useConfirm) {
      await Future.delayed(DurationConstant.d200);
      if (confirmPin.isEmpty) {
        setState(() {
          confirmPin.addAll([...value]);
          value.clear();
          title = "Confirm PIN";
        });
      } else {
        Function eq = const ListEquality().equals;
        if (eq(value, confirmPin)) {
          locator<AccountLocalRepository>().setUserPin(value);

          BlocProvider.of<PinCubit>(context).pinCreated(
            pin: value.join(''),
            passedData: widget.passedData,
          );
        } else {
          setState(() {
            hasError = true;
          });

          Vibration.vibrate(duration: 300);
          _confirmKey.currentState?.shake();
        }
      }
    } else {
      Function eq = const ListEquality().equals;
      if (eq(value, locator<AccountLocalRepository>().getUserPin())) {
        Future.delayed(DurationConstant.d200, () {
          BlocProvider.of<PinCubit>(context).correctPin(
            pin: value.join(''),
            passedData: widget.passedData,
          );
        });
      } else {
        setState(() {
          hasError = true;
        });
        Future.delayed(DurationConstant.d300, () {
          if (mounted) {
            setState(() {
              value.clear();
              hasError = false;
            });
          }
        });
        Vibration.vibrate(duration: 300);
        _confirmKey.currentState?.shake();
      }
    }
  }

  void _handleUseFingerPrint() async {
    final isAuth = await LocalAuth.authenticate(errorMessage: false);

    if (isAuth) {
      if (widget.passedData == 'change-pin-apps') {
        setState(() {
          isCorrectOldPin = true;
        });
        setState(() {
          value.clear();
          title = "Change PIN";
          showSubtitle = true;
          subTitle = "Make sure to remember your PIN because we dont store anywhere else except your local storage otherwise you cannot access your wallet";
        });
      } else {
        BlocProvider.of<PinCubit>(context).correctPin(
          pin: value.join(''),
          passedData: widget.passedData,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomShakeWidget(
        key: _confirmKey,
        duration: const Duration(milliseconds: 300),
        shakeCount: 12,
        shakeOffset: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const SizedBox(
              height: 20,
            ),
            ShowUpAnimation(
              animationDuration: DurationConstant.d500,
              offset: 1,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: UITypographies.subtitleLarge(context, fontSize: 24.sp),
              ),
            ),
            if (showSubtitle) ...[
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: 320,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      ShowUpAnimation(
                        animationDuration: DurationConstant.d500,
                        offset: 1,
                        child: Text(
                          subTitle,
                          textAlign: TextAlign.center,
                          style: UITypographies.bodyLarge(
                            context,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 315,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...List.generate(
                            6,
                            (index) {
                              return RoundedContainer(
                                width: 22,
                                height: 22,
                                shape: BoxShape.circle,
                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                useBorder: true,
                                borderColor: hasError == true ? UIColors.red500 : UIColors.white50,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 315,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ...List.generate(
                            value.length,
                            (index) {
                              return RoundedContainer(
                                width: 22,
                                height: 22,
                                shape: BoxShape.circle,
                                margin: EdgeInsets.symmetric(horizontal: 14.w),
                                useBorder: true,
                                borderColor: hasError == true ? UIColors.red500 : UIColors.white50,
                                color: hasError == true ? UIColors.red500 : UIColors.white50,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .9,
              ),
              child: Padding(
                padding: Paddings.defaultPaddingH,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        numberTap(1),
                        numberTap(2),
                        numberTap(3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        numberTap(4),
                        numberTap(5),
                        numberTap(6),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        numberTap(7),
                        numberTap(8),
                        numberTap(9),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        fingerPrint(),
                        numberTap(0),
                        backSpace(),
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (!widget.noCancel && widget.isSetBiometric != true && !useConfirm) ...[
              const SizedBox(
                height: 20,
              ),
              ButtonTextUI(
                text: 'Cancel',
                onTap: () {
                  context.read<PinCubit>().hidePin();
                },
              ),
            ],
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget fingerPrint() {
    Logger.info('IS Set Biometric ${widget.isSetBiometric}, Use Confirm $useConfirm, and no cancel ${widget.noCancel}');
    if ((widget.isSetBiometric == true || useConfirm) && !widget.noCancel) {
      return SizedBox(
        height: 100,
        child: Center(
          child: SmoothClipRRect(
            radius: 99999,
            child: BounceTap(
              onTap: () => context.read<PinCubit>().hidePin(),
              useInkWell: true,
              useSplash: false,
              child: RoundedContainer(
                width: 65,
                height: 65,
                child: Center(
                  child: Icon(
                    Icons.fingerprint,
                    size: 18.w,
                    color: UIColors.white50,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (widget.isSetBiometric == true) {
      return SizedBox(
        height: 100,
        child: Center(
          child: SmoothClipRRect(
            radius: 99999,
            child: BounceTap(
              onTap: _handleUseFingerPrint,
              useInkWell: true,
              useSplash: false,
              child: RoundedContainer(
                width: 65,
                height: 65,
                child: Center(
                  child: Icon(
                    Icons.fingerprint,
                    size: 18.w,
                    color: UIColors.white50,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox(
      height: 100,
      child: Center(
        child: RoundedContainer(
          width: 65,
          height: 65,
        ),
      ),
    );
  }

  Widget backSpace() {
    return SizedBox(
      height: 100,
      child: Center(
        child: SmoothClipRRect(
          radius: 99999,
          child: BounceTap(
            onTap: () {
              _removeNumber();
            },
            useInkWell: true,
            useSplash: false,
            child: RoundedContainer(
              width: 65,
              height: 65,
              child: Center(
                child: Icon(
                  Icons.backspace_outlined,
                  size: 18.w,
                  color: UIColors.white50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget numberTap(int number) {
    return SizedBox(
      height: 100,
      child: Center(
        child: SmoothClipRRect(
          radius: 80,
          child: BounceTap(
            onTap: () {},
            onTapDown: () {
              _addNumber(number);
            },
            useInkWell: true,
            useSplash: false,
            child: RoundedContainer(
              width: 65,
              height: 65,
              child: Center(
                child: Text(
                  '$number',
                  style: UITypographies.subtitleLarge(context, fontSize: 30.sp),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
