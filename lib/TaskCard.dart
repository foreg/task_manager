import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/Theme.dart' as Theme;
import 'package:task_manager/model/Task.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/utils.dart';

import 'Routes.dart';
import 'model/TaskDAO.dart';
import 'model/TaskState.dart';

class TaskCard extends StatefulWidget {

  final Task task;

  final ValueChanged<Task> removeTaskCallBack;

  TaskCard(this.task, this.removeTaskCallBack);

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final taskThumbnail = new Container(
      alignment: new FractionalOffset(0.0, 0.5),
      margin: const EdgeInsets.only(left: 0.0),
      child: new Hero(
        tag: 'task-icon-${widget.task.id}',
        child: new Image(
          image: getImage(),
          height: Theme.Dimens.taskHeight,
          width: Theme.Dimens.taskWidth,
        ),
      ),
    );

    final taskCard = new Container(
      margin: const EdgeInsets.only(left: 30.0, right: 0.0),
      decoration: new BoxDecoration(
        color: Theme.Colors.taskCard,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(color: Colors.black,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0)
          )
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(truncateString(17, widget.task.name), style: Theme.TextStyles.taskTitle),
            new Container(
              color: const Color(0xFF3700b3),
              width: 24.0,
              height: 2.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0)
            ),
            new Text(truncateString(95, widget.task.description), style: Theme.TextStyles.taskDescription ),
            // new Row(
            //   children: <Widget>[
            //     new Icon(Icons.location_on, size: 14.0,
            //       color: Theme.Colors.taskDistance),
            //     new Text(
            //       'task.distance', style: Theme.TextStyles.taskDistance),
            //     new Container(width: 24.0),
            //     new Icon(Icons.flight_land, size: 14.0,
            //       color: Theme.Colors.taskDistance),
            //     new Text(
            //       'task.gravity', style: Theme.TextStyles.taskDistance),
            //   ],
            // )
          ],
        ),
      ),
    );

    return new Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: new Container(
        height: 120.0,
        margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: new FlatButton(
          onLongPress: () => archieveTask(widget.task),
          onPressed: () => Routes.navigateTo(context, widget.task.id),
          child: new Stack(
            children: <Widget>[
              taskCard,
              taskThumbnail,
            ],
          ),
        ),
      ),
      actions: getActions(),
      secondaryActions: getSecondaryActions(),
    );
  }

  List<Widget> getActions() {
    var actions = <Widget>[];
    switch (widget.task.state) {
      case TaskState.NEW:
        actions.add(
          IconSlideAction(
            caption: 'Удалить',
            color: Theme.Colors.taskAdd,
            icon: Theme.AppIcons.archieve.icon,
            onTap: () => archieveTask(widget.task),
          )
        );
        break;
      case TaskState.ACTIVE:
        actions.add(
          IconSlideAction(
            caption: 'в Новые',
            color: Theme.Colors.taskAdd,
            icon: Theme.AppIcons.newTask.icon,
            onTap: () => changeState(widget.task, TaskState.NEW),
          )
        );
        break;
      case TaskState.CLOSED:
        actions.add(
          IconSlideAction(
            caption: 'в Активные',
            color: Theme.Colors.taskAdd,
            icon: Theme.AppIcons.active.icon,
            onTap: () => changeState(widget.task, TaskState.ACTIVE),
          )
        );
        break;
      default:
    }
    return actions;
  }

  List<Widget> getSecondaryActions() {
    var actions = <Widget>[];
    switch (widget.task.state) {
      case TaskState.NEW:
        actions.add(
          IconSlideAction(
            caption: 'в Активные',
            color: Theme.Colors.taskAdd,
            icon: Theme.AppIcons.active.icon,
            onTap: () => changeState(widget.task, TaskState.ACTIVE),
          )
        );
        break;
      case TaskState.ACTIVE:
        actions.add(
          IconSlideAction(
            caption: 'в Сделанные',
            color: Theme.Colors.taskAdd,
            icon: Theme.AppIcons.done.icon,
            onTap: () => changeState(widget.task, TaskState.CLOSED),
          )
        );
        break;
      case TaskState.CLOSED:
        actions.add(
          IconSlideAction(
            caption: 'Удалить',
            color: Theme.Colors.taskAdd,
            icon: Theme.AppIcons.archieve.icon,
            onTap: () => archieveTask(widget.task),
          )
        );
        break;
      default:
    }
    return actions;
  }

  void archieveTask(Task task) {
    if (task.archievingDate == null)
      task.archievingDate = DateTime.now();
    else 
      task.archievingDate = null;
    TaskDAO.updateTask(task, task.id);
    widget.removeTaskCallBack(task);
    HapticFeedback.vibrate();
  }

  void changeState(Task task, int newState) {
    task.state = newState;
    TaskDAO.updateTask(task, task.id);
    widget.removeTaskCallBack(task);
    HapticFeedback.vibrate();
  }

  ImageProvider getImage() {
    var imagePath = "assets/img/mars.png";
    switch (widget.task.state) {
      case TaskState.NEW:
        imagePath = "assets/img/new_task.png";
        break;
      case TaskState.ACTIVE:
        imagePath = "assets/img/active_task.png";
        break;
      case TaskState.CLOSED:
        imagePath = "assets/img/closed_task.png";
        break;
      default:
    }
    return new AssetImage(imagePath);
  }
}