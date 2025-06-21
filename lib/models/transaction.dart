// TODO Implement this library.
class Transaction {
  final int id;
  final int fuelCardId;
  final String stationName;
  final double amount;
  final String date;
  final String fuelType;
  final String? status;

  Transaction({
    required this.id,
    required this.fuelCardId,
    required this.stationName,
    required this.amount,
    required this.date,
    required this.fuelType,
    this.status,
  });
}
