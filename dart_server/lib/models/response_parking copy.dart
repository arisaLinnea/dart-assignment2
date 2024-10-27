import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:dart_server/models/response_parkinglot.dart';
import 'package:dart_server/models/response_vehicle.dart';

class ResponseParking {
  String _id;
  ResponseVehicle _vehicle;
  ResponseParkingLot _parkinglot;
  DateTime _startTime;
  DateTime? _endTime;

  ResponseParking(
      {required ResponseVehicle vehicle,
      required ResponseParkingLot parkinglot,
      required DateTime startTime,
      DateTime? endTime,
      String? id})
      : _id = id ?? Uuid().v4(),
        _vehicle = vehicle,
        _parkinglot = parkinglot,
        _startTime = startTime,
        _endTime = endTime;

  String get id => _id;

  set vehicle(ResponseVehicle value) {
    _vehicle = value;
  }

  set parkingLot(ResponseParkingLot value) {
    _parkinglot = value;
  }

  set startTime(DateTime value) {
    _startTime = value;
  }

  set endTime(DateTime value) {
    _endTime = value;
  }

  factory ResponseParking.fromJson(Map<String, dynamic> json) {
    return ResponseParking(
        id: json['id'],
        vehicle: ResponseVehicle.fromJson(json['vehicle']),
        parkinglot: ResponseParkingLot.fromJson(json['parkinglot']),
        startTime: DateTime.parse(json['startTime']),
        endTime:
            json['endTime'] != null ? DateTime.parse(json['startTime']) : null);
  }

  Map<String, dynamic> toJson() => {
        'id': _id,
        'vehicle': _vehicle.toJson(),
        'parkinglot': _parkinglot.toJson(),
        'startTime': _startTime
            .toIso8601String(), // Convert DateTime to ISO 8601 string,
        'endTime': _endTime?.toIso8601String()
      };

  @override
  String toString() {
    var formatter = DateFormat('dd-MM-yyyy HH:mm');
    String formattedStartDate = formatter.format(_startTime);
    String? formattedEndDate =
        _endTime != null ? formatter.format(_endTime!) : null;
    return 'Vehicle: ${_vehicle.toString()}, Parking lot: ${_parkinglot.toString()}, Starttime: $formattedStartDate, Endtime: ${formattedEndDate ?? '-'}';
  }
}
