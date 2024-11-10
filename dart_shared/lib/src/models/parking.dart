import 'package:dart_shared/src/models/parkinglot.dart';
import 'package:dart_shared/src/models/vehicle.dart';
import 'package:intl/intl.dart';

class Parking {
  String? _id;
  Vehicle? vehicle;
  ParkingLot? parkinglot;
  DateTime startTime;
  DateTime? endTime;

  Parking(
      {required this.vehicle,
      required this.parkinglot,
      required this.startTime,
      this.endTime,
      String? id})
      : _id = id;

  String get id => _id ?? '-1';

  factory Parking.fromJson(Map<String, dynamic> json) {
    return Parking(
        id: json['id'],
        vehicle:
            json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
        parkinglot: json['parkinglot'] != null
            ? ParkingLot.fromJson(json['parkinglot'])
            : null,
        startTime: DateTime.parse(json['startTime']),
        endTime:
            json['endTime'] != null ? DateTime.parse(json['startTime']) : null);
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'vehicle': vehicle?.toJson(),
        'parkinglot': parkinglot?.toJson(),
        'startTime':
            startTime.toIso8601String(), // Convert DateTime to ISO 8601 string,
        'endTime': endTime == null ? null : startTime.toIso8601String()
      };

  @override
  String toString() {
    var formatter = DateFormat('dd-MM-yyyy HH:mm');
    String formattedStartDate = formatter.format(startTime);
    String? formattedEndDate =
        endTime != null ? formatter.format(endTime!) : null;
    return 'Vehicle: ${vehicle.toString()}, Parking lot: ${parkinglot.toString()}, Starttime: $formattedStartDate, Endtime: ${formattedEndDate ?? '-'}';
  }
}
