import 'dart:async';
import 'package:intl/intl.dart';


class Contact {

  static final DateFormat _formatter = DateFormat('MMMM d, yyyy');

  final String fullName;
  final String gender;
  final String email;
  final String imageUrl;
  final String birthday;
  final Location location;
  final List<Phone> phones;

  const Contact({this.fullName, this.gender, this.email, this.imageUrl,
     this.birthday, this.location, this.phones});

  Contact.fromMap(Map<String, dynamic>  map) :
                    fullName = "${map['name']['first']} ${map['name']['last']}",
                    gender = map['gender'],
                    email = map['email'],
                    imageUrl = map['picture']['large'],
                    birthday = _formatter.format(DateTime.parse(map['dob']['date'])),
                    location = Location.fromMap(map['location']),
                    phones = <Phone>[
                      new Phone(type: 'Home',   number: map['phone']),
                      new Phone(type: 'Mobile', number: map['cell'])
                    ];
}

class Location {
  final Street street;
  final String city;

  const Location({this.street, this.city});

  Location.fromMap(Map<String, dynamic> map)
      : street = new Street(
            number: map['street']['number'], name: map['street']['name']),
        city = map['city'];
}

class Street {
  final int number;
  final String name;

  const Street({this.number, this.name});
}

class Phone {
  final String type;
  final String number;

  const Phone({this.type, this.number});
}


abstract class ContactRepository {
  Future<List<Contact>> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
