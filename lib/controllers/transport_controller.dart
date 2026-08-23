import 'package:get/get.dart';

import '../models/booking_model.dart';
import '../models/owner_model.dart';
import '../models/route_model.dart';

class TransportController extends GetxController {
  var owners = <OwnerModel>[].obs;
  var routes = <RouteModel>[].obs;
  var bookings = <BookingModel>[].obs;

  OwnerModel? currentOwner;

  @override
  void onInit() {
    super.onInit();

    owners.addAll([
      OwnerModel(
        ownerId: 'OWN001',
        companyName: 'SmartRoute Transport',
        ownerName: 'Ali Khan',
        address: 'Johar Town, Lahore',
        phone1: '03001234567',
        phone2: '03111234567',
        jazzCashNumber: '03001234567',
        bankAccount: 'HBL 1234-5678-9999',
        vanCapacity: 10,
      ),
      OwnerModel(
        ownerId: 'OWN002',
        companyName: 'Safe Van Services',
        ownerName: 'Ahmed Raza',
        address: 'Model Town, Lahore',
        phone1: '03211234567',
        phone2: '03331234567',
        jazzCashNumber: '03211234567',
        bankAccount: 'Meezan 9876-5432-1111',
        vanCapacity: 12,
      ),
    ]);

    routes.addAll([
      RouteModel(
        routeId: 'R001',
        ownerId: 'OWN001',
        routeName: 'Johar Town to Riphah University',
        departureTime: '7:30 AM',
        returnTime: '4:00 PM',
        passengers: 18,
      ),
      RouteModel(
        routeId: 'R002',
        ownerId: 'OWN001',
        routeName: 'Thokar to Riphah University',
        departureTime: '8:00 AM',
        returnTime: '4:30 PM',
        passengers: 9,
      ),
      RouteModel(
        routeId: 'R003',
        ownerId: 'OWN002',
        routeName: 'Model Town to UCP',
        departureTime: '7:45 AM',
        returnTime: '5:00 PM',
        passengers: 22,
      ),
    ]);
  }

  void registerOwner(OwnerModel owner) {
    owners.add(owner);
    currentOwner = owner;
  }

  void setCurrentOwner(OwnerModel owner) {
    currentOwner = owner;
  }

  void addRoute(RouteModel route) {
    routes.add(route);
  }

  List<RouteModel> getRoutesByOwner(String ownerId) {
    return routes.where((route) => route.ownerId == ownerId).toList();
  }

  List<BookingModel> getBookingsByOwner(String ownerId) {
    return bookings.where((booking) => booking.ownerId == ownerId).toList();
  }

  int calculateVans(int passengers, int vanCapacity) {
    return (passengers / vanCapacity).ceil();
  }

  void bookSeat({
    required String ownerId,
    required String routeName,
    required String customerName,
    required String customerPhone,
  }) {
    bookings.add(
      BookingModel(
        bookingId: DateTime.now().millisecondsSinceEpoch.toString(),
        ownerId: ownerId,
        routeName: routeName,
        customerName: customerName,
        customerPhone: customerPhone,
      ),
    );
  }

  void confirmPayment(String bookingId) {
    final index = bookings.indexWhere(
          (booking) => booking.bookingId == bookingId,
    );

    if (index != -1) {
      bookings[index].paymentConfirmed = true;
      bookings.refresh();
    }
  }
}