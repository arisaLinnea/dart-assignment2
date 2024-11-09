class Address {
  String? _id;
  String street;
  String zipCode;
  String city;

  Address(
      {required this.street,
      required this.zipCode,
      required this.city,
      String? id})
      : _id = id;

  String get id => _id ?? '-1';

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        id: json['id'],
        street: json['street'],
        zipCode: json['zipCode'],
        city: json['city']);
  }

  Map<String, dynamic> toJson() =>
      {'id': _id, 'street': street, 'zipCode': zipCode, 'city': city};

  @override
  String toString() {
    return '$street, $zipCode $city';
  }
}

class ParkingLot {
  String? _id;
  Address address;
  double hourlyPrice;

  ParkingLot({required this.address, required this.hourlyPrice, String? id})
      : _id = id;

  String get id => _id ?? '-1';

  factory ParkingLot.fromJson(Map<String, dynamic> json) {
    return ParkingLot(
        id: json['id'],
        address: Address.fromJson(json['address']),
        hourlyPrice: json['hourlyPrice']);
  }

  Map<String, dynamic> toJson() =>
      {'id': _id, 'address': address.toJson(), 'hourlyPrice': hourlyPrice};

  @override
  String toString() {
    return 'Address: ${address.toString()}, hourly price: $hourlyPrice';
  }
}
