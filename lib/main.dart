import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Preloader.dart';

import 'MainPage.dart';
import 'Routes.dart';

void main() {
  Routes.initRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Task manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          splashColor: Colors.transparent,
        ),
        // home: MainPage (displayArchieved: false),
        home: new FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, snapshot) => buildPage(snapshot)));
  }

  Widget buildPage(snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasData) {
        Routes.user = snapshot.data;
        return MainPage(displayArchieved: false);
      } else {
        return Builder(
          builder: (context) => new Scaffold(
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img/background.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height - 24) / 2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 75,
                      child: OutlineButton(
                        color: Colors.white,
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.white30,
                          style: BorderStyle.solid,
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                        ),
                        child: Text(
                          'ВХОД',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w200),
                        ),
                        onPressed: () => Routes.signIn(context),
                      ),
                    ),
                    // padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height - 24) / 2,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 75,
                      child: OutlineButton(
                        color: Colors.white,
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.white30,
                          style: BorderStyle.solid,
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(60.0),
                        ),
                        child: Text(
                          'РЕГИСТРАЦИЯ',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w200),
                        ),
                        onPressed: () => Routes.signUp(context),
                      ),
                    ),
                    // padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } else {
      return Preloader();
    }
  }
}
