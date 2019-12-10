import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/auth/SignInPage.dart';
import 'package:task_manager/main.dart';
import 'package:task_manager/task_detail/TaskDetailPage.dart';

import 'MainPage.dart';
import 'auth/SignUpPage.dart';

class Routes {
  static final Router _router = new Router();
  static FirebaseUser user;

  static var planetDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new TaskDetailPage(params["id"][0]);
    });

  static var signInHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new SignInPage();
    });

  static var signUpHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new SignUpPage();
    });

  static var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new MainPage(displayArchieved: false);
    });

  static var authHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new MyApp();
    });

  static void initRoutes() {
    _router.define("/detail/:id", handler: planetDetailHandler);
    _router.define("/signin", handler: signInHandler);
    _router.define("/signup", handler: signUpHandler);
    _router.define("/", handler: homeHandler);
    _router.define("/auth", handler: authHandler);
  }

  static void _navigateTo(context, String route, {TransitionType transition=TransitionType.fadeIn, bool clearStack=false}) {
    _router.navigateTo(context, route, transition: transition, clearStack: clearStack);
  }

  static void navigateTo(context, String id) {
    Routes._navigateTo(
      context,
      '/detail/$id',
      transition: TransitionType.fadeIn
    );
  }

  static void signIn(context, {bool clearStack=false}) {
    Routes._navigateTo(context, '/signin', clearStack: clearStack);
  }

  static void auth(context, {bool clearStack=false}) {
    Routes._navigateTo(context, '/auth', clearStack: clearStack);
  }

  static void signUp(context) {
    Routes._navigateTo(context, '/signup');
  }
  static void home(context) {
    Routes._navigateTo(context, '/', clearStack:true);
  }

}