import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language Stories',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF007AFF), // Color azul de iOS
        scaffoldBackgroundColor: const Color(0xFFF2F2F7), // Fondo gris claro de iOS
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFF007AFF)),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF007AFF),
          secondary: Colors.grey[300]!,
          surface: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
