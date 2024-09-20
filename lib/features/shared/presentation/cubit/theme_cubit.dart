import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/themes/theme.dart';

part 'theme_state.dart';

@singleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(brightness: Brightness.dark));

  void initBrightnessSystem() {
    emit(
      ThemeState(
        brightness: PlatformDispatcher.instance.platformBrightness,
      ),
    );
  }

  void setBrightness(Brightness brightness) {
    emit(
      ThemeState(
        brightness: brightness,
      ),
    );
  }

  void toggleTheme() {
    final brightness = state.isDarkMode ? Brightness.light : Brightness.dark;

    emit(
      ThemeState(
        brightness: brightness,
      ),
    );
  }
}
