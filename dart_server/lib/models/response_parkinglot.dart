import 'package:uuid/uuid.dart';

class ResponseAddress {
  String _street;
  String _zipCode;
  String _city;

  ResponseAddress(this._street, this._zipCode, this._city);

  factory ResponseAddress.fromJson(Map<String, dynamic> json) {
    return ResponseAddress(json['street'], json['zipCode'], json['city']);
  }

  Map<String, dynamic> toJson() =>
      {'street': _street, 'zipCode': _zipCode, 'city': _city};

  @override
  String toString() {
    return '$_street, $_zipCode $_city';
  }
}

class ResponseParkingLot {
  String _id;
  ResponseAddress _address;
  double _hourlyPrice;

  ResponseParkingLot(
      {required ResponseAddress address,
      required double hourlyPrice,
      String? id})
      : _id = id ?? Uuid().v4(),
        _address = address,
        _hourlyPrice = hourlyPrice;

  String get id => _id;

  set address(ResponseAddress value) {
    _address = value;
  }

  set hourlyPrice(double value) {
    _hourlyPrice = value;
  }

  factory ResponseParkingLot.fromJson(Map<String, dynamic> json) {
    return ResponseParkingLot(
        id: json['id'],
        address: ResponseAddress.fromJson(json['address']),
        hourlyPrice: double.parse(json['hourlyPrice']));
  }

  Map<String, dynamic> toJson() =>
      {'id': _id, 'address': _address.toJson(), 'hourlyPrice': _hourlyPrice};

  @override
  String toString() {
    return 'Address: ${_address.toString()}, hourly price: $_hourlyPrice';
  }
}
