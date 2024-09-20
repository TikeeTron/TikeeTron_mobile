part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({
    required this.brightness,
  });

  final Brightness brightness;

  bool get isDarkMode => brightness == Brightness.dark;

  ThemeData get materialThemeData =>
      isDarkMode ? UITheme.material.dark : UITheme.material.light;
  CupertinoThemeData get cupertinoThemeData =>
      isDarkMode ? UITheme.cupertino.dark : UITheme.cupertino.light;

  @override
  List<Object> get props => [
        brightness,
      ];
}
