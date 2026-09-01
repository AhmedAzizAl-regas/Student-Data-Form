import 'package:flutter/material.dart';
import 'screens/student_form_screen.dart';

void main() {
  runApp(const StudentFormApp());
}

class StudentFormApp extends StatelessWidget {
  const StudentFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نموذج بيانات الطالب',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5), // Indigo / Ocean Blue
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto', // Default fallback font
        cardTheme: const CardThemeData(
          surfaceTintColor: Colors.white,
        ),
      ),
      home: const StudentFormScreen(),
    );
  }
}
