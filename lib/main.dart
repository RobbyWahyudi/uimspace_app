import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/navigation/bottom_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: SpaceColors.surface,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const UIMSpaceApp());
}

/// UIMSpace - Learning Management System
/// Aplikasi LMS dengan tema Space Learning
class UIMSpaceApp extends StatelessWidget {
  const UIMSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UIMSpace',
      debugShowCheckedModeBanner: false,

      // Apply Space Dark Theme
      theme: SpaceDarkTheme.theme,
      darkTheme: SpaceDarkTheme.theme,
      themeMode: ThemeMode.dark,

      // Main navigation with bottom navigation bar
      home: const MainNavigationShell(),
    );
  }
}
