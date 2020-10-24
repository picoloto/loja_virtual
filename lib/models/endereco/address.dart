import 'package:loja_virtual/utils/const/address_constants.dart';

class Address {
  String street;
  String number;
  String complement;
  String district;
  String zipCode;
  String city;
  String state;
  double lat;
  double long;

  Address(
      {this.street,
      this.number,
      this.complement,
      this.district,
      this.zipCode,
      this.city,
      this.state,
      this.lat,
      this.long});

  Address.fromMap(Map<String, dynamic> map) {
    street = map[addressStreet] as String;
    number = map[addressNumber] as String;
    complement = map[addressComplement] as String;
    district = map[addressDistrict] as String;
    zipCode = map[addressZipCode] as String;
    city = map[addressCity] as String;
    state = map[addressState] as String;
    lat = map[addressLat] as double;
    long = map[addressLong] as double;
  }

  Map<String, dynamic> toMap() {
    return {
      addressStreet: street,
      addressNumber: number,
      addressComplement: complement,
      addressDistrict: district,
      addressZipCode: zipCode,
      addressCity: city,
      addressState: state,
      addressLat: lat,
      addressLong: long,
    };
  }
}
