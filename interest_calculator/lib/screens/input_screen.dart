import 'package:flutter/material.dart';
import '../models/investment_data.dart';
import 'results_screen.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

// The state class for the InputScreen widget.
class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  int _months = 0;

  final _inv1Initial = TextEditingController();
  final _inv1Monthly = TextEditingController();
  final _inv1Rate = TextEditingController();

  final _inv2Initial = TextEditingController();
  final _inv2Monthly = TextEditingController();
  final _inv2Rate = TextEditingController();

  // Method to simulate the investment based on user input and navigate to the results screen.
  void _simulate() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        InvestmentData inv1 = InvestmentData(
          initialCapital: double.parse(_inv1Initial.text),
          monthlyApplication: double.parse(_inv1Monthly.text),
          monthlyInterestRate: double.parse(_inv1Rate.text),
        );

        InvestmentData inv2 = InvestmentData(
          initialCapital: double.parse(_inv2Initial.text),
          monthlyApplication: double.parse(_inv2Monthly.text),
          monthlyInterestRate: double.parse(_inv2Rate.text),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(
              investment1: inv1,
              investment2: inv2,
              months: _months,
            ),
          ),
        );
      });
    }
  }

  // Helper method to build the input fields for each investment.
  Widget _buildInvestmentFields(String title, TextEditingController initial, TextEditingController monthly, TextEditingController rate) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.blueAccent)
            ),
            Divider(),
            TextFormField(
              controller: initial,
              decoration: InputDecoration(labelText: 'Capital Inicial (R\$)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: monthly,
              decoration: InputDecoration(labelText: 'Aplicação Mensal (R\$)'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: rate,
              decoration: InputDecoration(labelText: 'Taxa de Juros Mensal (%)'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }

  // The build method constructs the UI of the InputScreen widget.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulador de Investimentos'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Período Total em Meses',
                        icon: Icon(Icons.calendar_today)
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => _months = int.tryParse(val) ?? 0,
                  ),
                ),
              ),
              SizedBox(height: 8),
              _buildInvestmentFields('Investimento 1', _inv1Initial, _inv1Monthly, _inv1Rate),
              _buildInvestmentFields('Investimento 2', _inv2Initial, _inv2Monthly, _inv2Rate),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18)
                ),
                onPressed: _simulate,
                child: Text('Simular e Comparar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}