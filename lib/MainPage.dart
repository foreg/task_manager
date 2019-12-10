
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/model/TaskState.dart';
import 'package:task_manager/Theme.dart' as Theme;

import 'Routes.dart';
import 'TaskList.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title, this.displayArchieved}) : super(key: key);

  final String title;
  bool displayArchieved;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);  
  
  List<StatefulWidget> _widgetOptions;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    _widgetOptions = <StatefulWidget>[
      TaskList(state: TaskState.NEW, displayArchieved: widget.displayArchieved),
      TaskList(state: TaskState.ACTIVE, displayArchieved: widget.displayArchieved),
      TaskList(state: TaskState.CLOSED, displayArchieved: widget.displayArchieved),    
    ];
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Theme.AppIcons.archieve,
            onPressed: () {
              setState(() {
                widget.displayArchieved = !widget.displayArchieved;
              });
            },
          ),
          Builder(builder: (BuildContext context) {
            return FlatButton(
              child: const Text('Выйти', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                final FirebaseUser user = Routes.user;
                if (user != null) {
                  _signOut();
                }
                Routes.auth(context, clearStack: true);
              },
            );
          })
        ],
        title: widget.displayArchieved ? Text('Корзина') : Text('Задачи'),
        backgroundColor: widget.displayArchieved ? Theme.Colors.appBarArchieved : Theme.Colors.appBar,
      ),
      body: Center(
        child: buildElementAt(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Theme.AppIcons.newTask,
            title: Text('Новые'),
          ),
          BottomNavigationBarItem(
            icon: Theme.AppIcons.active,
            title: Text('Активные'),
          ),
          BottomNavigationBarItem(
            icon: Theme.AppIcons.done,
            title: Text('Завершенные'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.Colors.appBar,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Routes.navigateTo(context, '-1'),
        child: Icon(Icons.add),
        backgroundColor: Theme.Colors.taskAdd,
      ),
    );
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  StatefulWidget buildElementAt() {
    // print('LOG AT buildElementAt');
    setState(() {});
    return _widgetOptions.elementAt(_selectedIndex);
  } 
}