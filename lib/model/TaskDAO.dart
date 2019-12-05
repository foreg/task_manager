import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/model/Task.dart';

import 'TaskState.dart';

class TaskDAO {
  static final databaseReference = Firestore.instance;


  static Future<List> getAllTasks() async {
    return await databaseReference.collection('tasks').getDocuments().then((result) {
      return result.documents.toList();
    });
  }

  static Future<List> getNewTasks() async {
    return await databaseReference.collection('tasks').where('state', isEqualTo: TaskState.NEW).getDocuments().then((result) {
      return result.documents.toList();
    });
  }

  static Future<List> getTasks(int state) async {
    return await databaseReference.collection('tasks').where('archievingDate', isNull: true).where('state', isEqualTo: state).getDocuments().then((result) {
      return result.documents.toList();
    });
  }

  static Future<List> getArchievedTasks(int state) async {
    return await databaseReference.collection('tasks').where('archievingDate', isGreaterThanOrEqualTo: Timestamp.fromDate(DateTime.parse('0001-01-01T00:00:00Z'))).where('state', isEqualTo: state).getDocuments().then((result) {
      return result.documents.toList();
    });
  }

  static Future<Task> getTask(String id) async {
    var documentReference =  databaseReference.collection('tasks').document(id);
    return await documentReference.get().then((result){
      if (result.data == null)
        return new Task(id: result.documentID);
      return Task.fromMap(result.data, result.documentID);
    });
  }

  static Future<void> removeTask(String id) async {
    return await databaseReference.collection('tasks').document(id).delete();
  }
  static Future<DocumentReference> addTask(Task task) async {
    return await databaseReference.collection('tasks').add(task.toJson());
  }
  static Future<void> updateTask(Task task , String id) async{
    if (id == '-1') {
      task.state = 0;
      return await addTask(task);
    }
    return await databaseReference.collection('tasks').document(id).updateData(task.toJson()) ;
  }
}