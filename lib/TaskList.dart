import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Preloader.dart';

import 'TaskCard.dart';
import 'model/Task.dart';
import 'model/TaskDAO.dart';

class TaskList extends StatefulWidget {
  TaskList({
    Key key,
    this.state,
    this.displayArchieved
  }) : super(key: key);

  final int state;
  bool displayArchieved;
  ListView listView;
  List<Task> tasks;
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: widget.displayArchieved ? TaskDAO.getArchievedTasks(widget.state) : TaskDAO.getTasks(widget.state),
        builder: (context, snapshot) => getListView(snapshot),
      )
    );
  }

  Widget getListView(AsyncSnapshot snapshot) {    
    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) { 
      widget.tasks = List<Task>(); 
      for (var item in snapshot.data) {
        var documentSnapshot = item as DocumentSnapshot;
        Task task = Task.fromMap(documentSnapshot.data, documentSnapshot.documentID);
        widget.tasks.add(task);
      }
      widget.listView = ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {          
          return TaskCard(widget.tasks[index], _removeTask);
        },
      );
      return widget.listView;
    }
    else {
      return Center(
        child: Preloader()
      );
    }            
  }
  
  void _removeTask(Task task) {
    setState(() {
      widget.tasks.removeWhere((t) => t.id == task.id);
    });
  }
}