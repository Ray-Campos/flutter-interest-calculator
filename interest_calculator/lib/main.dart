import 'package:flutter/material.dart';
import 'screens/input_screen.dart';

void main() {
  runApp(InvestmentSimulatorApp());
}

// InvestmentSimulatorApp is the main application widget
class InvestmentSimulatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulador de Investimentos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InputScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}