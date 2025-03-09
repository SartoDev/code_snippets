import 'dart:io';

import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:code_snippets/home_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  runApp(const MyApp());
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    windowManager.setTitle("Code Snippets");
    windowManager.setSize(Size(400, 800));
    windowManager.setMinimumSize(Size(400, 800));
    windowManager.setMaximumSize(Size(500, 1080));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Snippets',
      home: const HomeScreen(),
      theme: ThemeData(
        colorScheme: ColorSchemes.darkZinc(),
        radius: 0.5,
      ),
    );
  }
}