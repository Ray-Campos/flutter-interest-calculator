// InvestmentData class to hold the investment parameters
class InvestmentData {
  final double initialCapital;
  final double monthlyApplication;
  final double monthlyInterestRate;

  InvestmentData({
    required this.initialCapital,
    required this.monthlyApplication,
    required this.monthlyInterestRate,
  });
}

// SimulationResult class to hold the results of the investment simulation
class SimulationResult {
  final double finalAmount;
  final double totalYield;
  final List<double> monthlyEvolution;

  SimulationResult({
    required this.finalAmount,
    required this.totalYield,
    required this.monthlyEvolution,
  });
}