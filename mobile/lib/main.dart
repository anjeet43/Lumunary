import 'package:flutter/material.dart';
import 'app/theme.dart';
import 'features/home_shell.dart';

void main() => runApp(const LuminaryApp());

class LuminaryApp extends StatelessWidget {
  const LuminaryApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Luminary',
        debugShowCheckedModeBanner: false,
        theme: LuminaryTheme.light,
        home: const HomeShell(),
      );
}
