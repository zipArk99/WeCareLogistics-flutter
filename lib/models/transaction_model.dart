class Transcation {
  final String transactionId;
  final String senderId;
  final String courierServiceId;
  final String orderId;
  final double transactionAmount;
  final DateTime transactionDate;

  Transcation({
    required this.transactionId,
    required this.senderId,
    required this.courierServiceId,
    required this.orderId,
    required this.transactionAmount,
    required this.transactionDate,
  });
}
