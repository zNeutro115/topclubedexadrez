import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:topxadrez/models/date_event.dart';
import 'package:topxadrez/models/user_modal.dart';
import 'package:week_of_year/week_of_year.dart';

class CalendarController extends ChangeNotifier {
  CalendarController() {
    getEvents();
  }
  List<DateEvent> _eventsOnTheDate = [
    // DateEvent(DateTime.now(), name: 'Apresentação do site'),
    // DateEvent(DateTime.now(), name: 'Pedro Silva', hour: 3),
  ];

  getEvents() async {
    isEventUpdating = true;
    try {
      QuerySnapshot<Map<String, dynamic>> snap =
          await FirebaseFirestore.instance.collection('event').get();

      List<DateEvent> _downloadedEvents = [];
      for (var doc in snap.docs) {
        DateEvent product = DateEvent.fromMap(doc.data());
        _downloadedEvents.add(product);
      }

      // addArtigo(_artigos);
      eventsOnTheDate = _downloadedEvents;
      notifyListeners();
      isEventUpdating = false;
    } catch (e) {
      debugPrint(e.toString());
      isEventUpdating = false;
    }
  }

  List<DateEvent> get eventsOnTheDate => _eventsOnTheDate;

  set eventsOnTheDate(List<DateEvent> event) {
    _eventsOnTheDate = event;
    notifyListeners();
  }

  addEvent(DateEvent date) {
    _eventsOnTheDate.add(date);
    notifyListeners();
  }

  bool canMarkEvent(UserModel? u) {
    if (u == null) {
      return false;
    }
    if (u.isAdmin) {
      return true;
    }

    var _eventsOfWeek = _eventsOnTheDate.where(
        (element) => element.date.weekOfYear == DateTime.now().weekOfYear);
    for (var element in _eventsOfWeek) {
      if (element.idOfPerson == u.id) {
        return false;
      }
    }
    return true;
  }

  bool isValid(String myhour) {
    for (var element in _eventsOnTheDate) {
      if (element.date.day == (_dateTime ?? DateTime.now()).day) {
        if (DateEvent.listOfHours[element.hour] == myhour) {
          return false;
        }
      }
    }
    return true;
  }

  DateTime? _dateTime;
  int? _hour = 4;
  int color = 0;

  String? compromiss;
  String? idOfUser;
  bool _isOnline = false;
  bool _isEventUpdating = false;
  DateTime? get dateTime => _dateTime;
  int? get hour => _hour;
  bool get isOnline => _isOnline;
  bool get isEventUpdating => _isEventUpdating;

  set hour(int? hour) {
    _hour = hour;
    notifyListeners();
  }

  set isOnline(bool value) {
    _isOnline = value;
    notifyListeners();
  }

  set isEventUpdating(bool value) {
    _isEventUpdating = value;
    notifyListeners();
  }

  set dateTime(DateTime? date) {
    _dateTime = date;
    notifyListeners();
  }

  deleteDateEvent(DateEvent event) async {
    isEventUpdating = true;
    await FirebaseFirestore.instance.collection('event').doc(event.id).delete();
    await getEvents();
    isEventUpdating = false;
  }

  uploadDateEvent(UserModel user) async {
    isEventUpdating = true;
    try {
      debugPrint('eventColor: $color');
      debugPrint('hour: $hour');
      debugPrint('dateTime: $dateTime');
      debugPrint('compromiss: $compromiss');
      debugPrint('isOnline: $isOnline');
      debugPrint('idOfUser: $idOfUser');
      debugPrint('name: ${user.nome}');

      DateEvent _newEvent = DateEvent(_dateTime!,
          hour: _hour!, eventColor: color, isOnline: isOnline, name: user.nome);

      if (compromiss != null) {
        _newEvent.compromiss = compromiss!;
      }

      if (idOfUser != null) {
        _newEvent.idOfPerson = idOfUser;
      } else {
        _newEvent.idOfPerson = user.id;
      }

      CollectionReference artigoRef =
          FirebaseFirestore.instance.collection('event');
      DocumentReference documentRef = await artigoRef.add(_newEvent.toMap());
      _newEvent.id = documentRef.id;

      await documentRef.set(_newEvent.toMap());
      await getEvents();
      isEventUpdating = false;
      color = 0;
      hour = null;
      dateTime == null;
      compromiss == null;
      isOnline = false;
      idOfUser = null;
    } catch (e) {
      isEventUpdating = false;
    }
  }
}
