import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/investment_data.dart';
import '../utils/interest_calculator.dart';

// ResultsScreen widget to display the results of the investment comparison
class ResultsScreen extends StatelessWidget {
  final InvestmentData investment1;
  final InvestmentData investment2;
  final int months;

  ResultsScreen({
    required this.investment1,
    required this.investment2,
    required this.months,
  });

  // Builds the UI for the results screen, including summary cards, a line chart, and a progression table
  @override
  Widget build(BuildContext context) {
    SimulationResult result1 = InterestCalculator.calculate(investment1, months);
    SimulationResult result2 = InterestCalculator.calculate(investment2, months);

    int graphLimit = months > 12 ? 12 : months;
    List<double> ev1Limited = result1.monthlyEvolution.sublist(0, graphLimit);
    List<double> ev2Limited = result2.monthlyEvolution.sublist(0, graphLimit);

    return Scaffold(
      appBar: AppBar(title: Text('Resultados da Comparação')),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Solves horizontal overflow by using Expanded
              Row(
                children: [
                  Expanded(child: _buildSummaryCard('Investimento 1', result1, Colors.blue)),
                  SizedBox(width: 8),
                  Expanded(child: _buildSummaryCard('Investimento 2', result2, Colors.red)),
                ],
              ),
              SizedBox(height: 20),

              // Chart Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Investimento 1', Colors.blue),
                  SizedBox(width: 20),
                  _buildLegendItem('Investimento 2', Colors.red),
                ],
              ),
              SizedBox(height: 10),

              // Chart
              Text(
                'Evolução (Primeiros $graphLimit meses)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                height: 180,
                padding: EdgeInsets.only(right: 16),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true, drawVerticalLine: false),
                    titlesData: FlTitlesData(
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
                    lineBarsData: [
                      LineChartBarData(
                        spots: ev1Limited.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                        color: Colors.blue,
                        isCurved: true,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      ),
                      LineChartBarData(
                        spots: ev2Limited.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                        color: Colors.red,
                        isCurved: true,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Progression Table Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Mês', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Inv 1 (R\$)', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Inv 2 (R\$)', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Divider(),

              // Progression Table List
              Expanded(
                child: ListView.builder(
                  itemCount: months,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      margin: EdgeInsets.symmetric(vertical: 4),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(result1.monthlyEvolution[index].toStringAsFixed(2), style: TextStyle(color: Colors.blue.shade700)),
                            Text(result2.monthlyEvolution[index].toStringAsFixed(2), style: TextStyle(color: Colors.red.shade700)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                onPressed: () => Navigator.pop(context),
                child: Text('Nova Simulação', style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Builds a summary card for each investment, displaying the final amount and total yield
  Widget _buildSummaryCard(String title, SimulationResult result, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
            SizedBox(height: 8),
            Text('Final:', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            Text('R\$ ${result.finalAmount.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('Rendimento:', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            Text('R\$ ${result.totalYield.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade700)),
          ],
        ),
      ),
    );
  }

  // Builds a legend item for the chart, showing the color and label for each investment
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}