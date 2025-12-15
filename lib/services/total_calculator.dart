class CartTotals {
  final double subtotal;
  final double serviceCharge;
  final double pbi;
  final double total;

  const CartTotals({
    required this.subtotal,
    required this.serviceCharge,
    required this.pbi,
    required this.total,
  });
}

class TotalCalculator {
  static const double _serviceRate = 0.075; // 7.5%
  static const double _pbiRate = 0.10; // 10% after service charge

  static CartTotals calculate(double subtotal) {
    final serviceCharge = subtotal * _serviceRate;
    final pbi = (subtotal + serviceCharge) * _pbiRate;
    final total = subtotal + serviceCharge + pbi;

    return CartTotals(
      subtotal: subtotal,
      serviceCharge: serviceCharge,
      pbi: pbi,
      total: total,
    );
  }
}
