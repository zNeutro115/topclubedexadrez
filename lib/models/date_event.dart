import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DateEvent {
  late DateTime date;
  late String name;
  String? id;
  String? idOfPerson;
  late bool isOnline;
  String compromiss = '';
  late int eventColor;
  late int hour;
  static const List<Color> colors = [
    Color.fromARGB(255, 4, 125, 141), // aula
    Colors.deepPurple, // aula online
    Colors.green, // evento
    Colors.orange, //torneio
  ];

  static final List<String> listOfHours = [
    '1 às 2',
    '2 às 3',
    '3 às 4',
    '4 às 5',
    '5 às 6',
    '7 às 8',
  ];

  DateEvent(
    this.date, {
    this.name = 'Igor Miranda Souza',
    this.hour = 1,
    this.eventColor = 0,
    this.id,
    this.isOnline = false,
  }) {
    compromiss =
        '${listOfHours[hour]} - $name - ${isOnline ? 'Online' : 'Presencial'}';
  }

  DateEvent.fromMap(dynamic data) {
    date = (data['date']! as Timestamp).toDate();
    isOnline = (data['compromiss']! as String).contains('Online');
    id = data['id']!;
    idOfPerson = data['idOfPerson']!;
    name = data['name']!;
    eventColor = data['eventColor']!;
    compromiss = data['compromiss']!;
    for (var element in listOfHours) {
      if ((data['compromiss']! as String).contains(element)) {
        hour = listOfHours.indexOf(element);
      }
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch),
      'name': name,
      'eventColor': eventColor,
      'id': id,
      'idOfPerson': idOfPerson,
      'compromiss': compromiss,
    };
  }
}
