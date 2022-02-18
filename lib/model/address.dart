class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final AddressGeo geo;

  Address(this.street, this.suite, this.city, this.zipcode, this.geo);

  Address.fromJson(Map<String, dynamic> json)
      : street = json['street'],
        suite = json['suite'],
        city = json['city'],
        zipcode = json['zipcode'],
        geo = AddressGeo.fromJson(json["geo"]);
}

class AddressGeo {
  final String lat;
  final String lng;

  AddressGeo(this.lat, this.lng);

  AddressGeo.fromJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];
}

/*
 "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    },
 */