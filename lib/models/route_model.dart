class RouteModel {
  final String routeId;
  final String ownerId;
  final String routeName;
  final String departureTime;
  final String returnTime;
  final int passengers;

  RouteModel({
    required this.routeId,
    required this.ownerId,
    required this.routeName,
    required this.departureTime,
    required this.returnTime,
    required this.passengers,
  });
}