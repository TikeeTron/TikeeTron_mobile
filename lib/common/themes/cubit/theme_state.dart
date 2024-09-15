part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.brightness,
  });

  final Brightness brightness;

  bool get isDarkMode => brightness == Brightness.dark;

  ThemeData get materialThemeData => UITheme.material.dark;
  CupertinoThemeData get cupertinoThemeData => UITheme.cupertino.dark;

  @override
  List<Object> get props => [
        brightness,
      ];
}
