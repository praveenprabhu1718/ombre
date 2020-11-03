import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ombre/Constants/constants.dart';
import 'package:ombre/Model/event.dart';

class FetchEvents{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Event>> fetechEvents() async {
    await Firebase.initializeApp();
    List<Event> events = List<Event>();
    QuerySnapshot querySnapshot = await firestore.collection(EVENTS_COLLECTION).get();
    for(int i  =0; i < querySnapshot.docs.length; i++){
      events.add(Event.fromMap(querySnapshot.docs[i].data()));
    }
    return events;
  }

}