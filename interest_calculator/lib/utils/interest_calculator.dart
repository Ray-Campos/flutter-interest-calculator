import '../models/investment_data.dart';

// InterestCalculator class to perform the investment calculations
class InterestCalculator {
  static SimulationResult calculate(InvestmentData data, int months) {
    double currentBalance = data.initialCapital;
    List<double> evolution = [];
    double totalInvested = data.initialCapital + (data.monthlyApplication * months);

    for (int i = 0; i < months; i++) {
      currentBalance = currentBalance * (1 + (data.monthlyInterestRate / 100));
      currentBalance += data.monthlyApplication;
      evolution.add(currentBalance);
    }

    double totalYield = currentBalance - totalInvested;

    return SimulationResult(
      finalAmount: currentBalance,
      totalYield: totalYield,
      monthlyEvolution: evolution,
    );
  }
}