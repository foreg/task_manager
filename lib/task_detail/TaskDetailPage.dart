import 'package:flutter/material.dart';
import 'package:task_manager/model/TaskDAO.dart';
import 'package:task_manager/task_detail/TaskDetailBody.dart';

import '../Preloader.dart';

class TaskDetailPage extends StatelessWidget {

  // final Task task;
  final String id;

  TaskDetailPage(String id) : id = id;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new FutureBuilder(
            future: TaskDAO.getTask(id),
            builder: (context, snapshot) => getDetailView(snapshot),
          ),
        ],
      ),
    );
  }
  static Widget getDetailView(AsyncSnapshot snapshot) {    
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      return TaskDetailBody(snapshot.data);
    }
    else {
      return Center(
        child: Preloader() //todo preloader,
      );
    }            
  }
}
