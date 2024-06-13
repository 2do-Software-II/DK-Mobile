class Reserva {
  final String customerId;
  final String status;
  final String roomType;
  final String roomDescription;
  final DateTime startDate;
  final DateTime endDate;

  Reserva({
    required this.customerId,
    required this.status,
    required this.roomType,
    required this.roomDescription,
    required this.startDate,
    required this.endDate,
  });

  factory Reserva.fromJson(Map<String, dynamic> json) {
    return Reserva(
      customerId: json['customer']['id'],
      status: json['status'],
      roomType: json['room']['type'],
      roomDescription: json['room']['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
