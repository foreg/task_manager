import 'package:flutter/material.dart';
import 'package:task_manager/Theme.dart' as Theme;
import 'package:task_manager/model/Task.dart';
import 'package:task_manager/model/TaskDAO.dart';

class TaskDetailBody extends StatefulWidget {
  final Task task;

  TaskDetailBody(this.task);

  @override
  _TaskDetailBodyState createState() => _TaskDetailBodyState();
}

class _TaskDetailBodyState extends State<TaskDetailBody> {
  final _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // return new Stack(
    //   children: <Widget>[
    //     new Container(
    //       color: Theme.Colors.taskPageBackground,
    //       child: new Center(
    //         child: new Hero(
    //           tag: 'task-icon-${task.id}',
    //           child: new Image(
    //             image: new AssetImage("assets/img/mars.png"),
    //             height: Theme.Dimens.taskHeight,
    //             width: Theme.Dimens.taskWidth,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ]
    // );
    return Scaffold(
        appBar: AppBar(
          title: Text('Просмотр задачи'),
          backgroundColor: Theme.Colors.appBar,
          ),
        body: Container(
            padding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
              builder: (context) => Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration:
                        InputDecoration(labelText: 'Название'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Пожалуйста, введите название';
                        }
                      },
                      initialValue: widget.task.name,
                      onSaved: (val) =>
                        setState(() => widget.task.name = val),
                    ),
                    TextFormField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration:
                        InputDecoration(labelText: 'Описание'),
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Пожалуйста, введите описание';
                      //   }
                      // },
                      initialValue: widget.task.description,
                      onSaved: (val) =>
                        setState(() => widget.task.description = val),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                      child: RaisedButton(
                        onPressed: () {
                          final form = _formKey.currentState as FormState;
                          if (form.validate()) {
                            form.save();
                            TaskDAO.updateTask(widget.task, widget.task.id).then((result) {
                              Navigator.pop(context);
                            });
                            // _user.save();
                            _showDialog(context);
                          }
                        },
                        child: Text('Сохранить'))),
                  ])))));
  }
  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Сохранение..')));
  }
}
