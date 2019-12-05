import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  String name;
  String description;
  int state;
  DateTime archievingDate;
  DateTime deletionDate;

  Task({this.id, this.name, this.state, this.description, this.archievingDate, this.deletionDate});

  Task.fromMap(Map snapshot,String id) :
        id = id ?? '',
        name = snapshot['name'] ?? '',
        state = snapshot['state'] ?? '',
        description = snapshot['description'] ?? '',
        archievingDate = snapshot['archievingDate'] != null ? (snapshot['archievingDate'] as Timestamp).toDate() : null,
        deletionDate = snapshot['deletionDate'] != null ? (snapshot['deletionDate'] as Timestamp).toDate() : null;

  toJson() {
    return {
      "name": name,
      "state": state,
      "description": description,
      "archievingDate": archievingDate,
      "deletionDate": deletionDate,
    };
  }
}