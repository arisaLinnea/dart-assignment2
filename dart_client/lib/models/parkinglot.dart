import 'package:uuid/uuid.dart';

class Address {
  String _street;
  String _zipCode;
  String _city;

  Address(this._street, this._zipCode, this._city);

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(json['street'], json['zipCode'], json['city']);
  }

  //TODO implement toJson

  @override
  String toString() {
    return '$_street, $_zipCode $_city';
  }
}

class ParkingLot {
  String _id;
  Address _address;
  double _hourlyPrice;

  ParkingLot(
      {required Address address, required double hourlyPrice, String? id})
      : _id = id ?? Uuid().v4(),
        _address = address,
        _hourlyPrice = hourlyPrice;

  String get id => _id;

  set address(Address value) {
    _address = value;
  }

  set hourlyPrice(double value) {
    _hourlyPrice = value;
  }

  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
        id: json['id'],
        address: Address.fromJson(json['address']),
        hourlyPrice: double.parse(json['hourlyPrice']));
  }

  Map<String, dynamic> toJson() =>
      {'id': _id, 'address': _address.toString(), 'hourlyPrice': _hourlyPrice};

  @override
  String toString() {
    return 'Address: ${_address.toString()}, hourly price: $_hourlyPrice';
  }
}
