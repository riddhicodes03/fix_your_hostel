// import 'package:client/screens/home.dart';
import 'package:client/screens/auth_wrapper.dart';
import 'package:client/theme/app_theme.dart';

import 'package:flutter/material.dart';

//seed colors

// final kDarkColorScheme = ColorScheme.fromSeed(
//   brightness: Brightness.dark,
//   seedColor:AppColors.bgDark,
// );

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: buildDarkTheme(),
      theme: buildLightTheme(),
      themeMode: ThemeMode.system,
      title: 'Fix hostel',
      home: AuthWrapper(),
    );
  }
}
