import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EventDestaque {
  late String title;
  late String subtitle;
  String? id;
  DateTime date = DateTime.now();
  EventDestaque(
      {required this.title, required this.subtitle, required this.date});

  EventDestaque.fromMap(data) {
    date = (data['date']! as Timestamp).toDate();
    subtitle = data['subtitle'];
    id = data['id'];
    title = data['title'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch),
      'title': title,
      'id': id,
      'subtitle': subtitle,
    };
  }
}

class EventDestaqueController extends ChangeNotifier {
  EventDestaqueController() {
    getDestaqueEvents();
  }
  List<EventDestaque> _events = [];
  List<EventDestaque> get events => _events;
  set events(List<EventDestaque> list) {
    _events = list;
    notifyListeners();
  }

  getDestaqueEvents() async {
    QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection('destaque').get();
    List<EventDestaque> downloadedEvents = [];
    for (var doc in snap.docs) {
      EventDestaque event = EventDestaque.fromMap(doc.data());

      downloadedEvents.add(event);
    }
    events = downloadedEvents;
    notifyListeners();
  }

  uploadDestauqeEvent(EventDestaque newEvent) async {
    EventDestaque event = newEvent;
    CollectionReference artigoRef =
        FirebaseFirestore.instance.collection('destaque');

    DocumentReference documentRef = await artigoRef.add(event.toMap());

    event.id = documentRef.id;

    await documentRef.set(event.toMap());
    await getDestaqueEvents();
  }

  deleteEvent(EventDestaque event) async {
    await FirebaseFirestore.instance
        .collection('destaque')
        .doc(event.id)
        .delete();
    await getDestaqueEvents();
  }
}
