import 'package:flutter/material.dart';

class Colors {

  const Colors();

  static const Color taskCard = const Color(0xFFfafafa);
  static const Color taskAdd = const Color(0xFF733ae6);
  static const Color taskTitle = const Color(0xFF000000);
  static const Color taskDescription = const Color(0xAA000000);

  
  static const Color appBar = const Color(0xFF3700b3);
  static const Color appBarArchieved = const Color(0xFFABABAB);

}

class Dimens {
  const Dimens();

  static const taskWidth = 90.0;
  static const taskHeight = 90.0;
}

class AppIcons {
  const AppIcons();

  static const Icon newTask = const Icon(Icons.fiber_new); 
  static const Icon active = const Icon(Icons.assignment); 
  static const Icon done = const Icon(Icons.done); 
  static const Icon archieve = const Icon(Icons.delete); 
}

class TextStyles {

  const TextStyles();

  static const TextStyle taskTitle = const TextStyle(
    color: Colors.taskTitle,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    fontSize: 20.0
  );

  static const TextStyle taskDescription = const TextStyle(
    color: Colors.taskDescription,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w400,
    fontSize: 14.0
  );
}
