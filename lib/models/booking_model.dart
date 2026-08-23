class BookingModel {
  final String bookingId;
  final String ownerId;
  final String routeName;
  final String customerName;
  final String customerPhone;
  bool paymentConfirmed;

  BookingModel({
    required this.bookingId,
    required this.ownerId,
    required this.routeName,
    required this.customerName,
    required this.customerPhone,
    this.paymentConfirmed = false,
  });
}