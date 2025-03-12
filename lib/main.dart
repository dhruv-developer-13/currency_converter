import 'package:flutter/material.dart';
import 'package:currency_converter/currency_converter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const  MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00394C), // Deep Blue
        scaffoldBackgroundColor: const Color(0xFFF4F7FA), // Light Grey
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6500), // Orange Button
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      title: "Currency Converter", // App title
      home: CurrencyConverterPage(),
    );
  }
}
