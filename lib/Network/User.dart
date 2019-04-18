class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        username = map["username"],
        email = map["email"],
        address = Address.fromJsonMap(map["address"]),
        phone = map["phone"],
        website = map["website"],
        company = Company.fromJsonMap(map["company"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['address'] = address == null ? null : address.toJson();
    data['phone'] = phone;
    data['website'] = website;
    data['company'] = company == null ? null : company.toJson();
    return data;
  }
}

class Geo {
  final String lat;
  final String lng;

  Geo.fromJsonMap(Map<String, dynamic> map)
      : lat = map["lat"],
        lng = map["lng"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address.fromJsonMap(Map<String, dynamic> map)
      : street = map["street"],
        suite = map["suite"],
        city = map["city"],
        zipcode = map["zipcode"],
        geo = Geo.fromJsonMap(map["geo"]);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = street;
    data['suite'] = suite;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['geo'] = geo == null ? null : geo.toJson();
    return data;
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        catchPhrase = map["catchPhrase"],
        bs = map["bs"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['catchPhrase'] = catchPhrase;
    data['bs'] = bs;
    return data;
  }
}
