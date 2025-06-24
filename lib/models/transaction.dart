class Transaction {
  final int id;
  final int fuelCardId;
  final String stationName;
  final double amount;
  final String date;
  final String? status;
  final String? fuelType;

  Transaction({
    required this.id,
    required this.fuelCardId,
    required this.stationName,
    required this.amount,
    required this.date,
    this.status,
    this.fuelType,
  });
}