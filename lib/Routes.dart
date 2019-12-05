import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/task_detail/TaskDetailPage.dart';

class Routes {
  static final Router _router = new Router();


  static var planetDetailHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new TaskDetailPage(params["id"][0]);
    });

  static void initRoutes() {
    _router.define("/detail/:id", handler: planetDetailHandler);
  }

  static void _navigateTo(context, String route, {TransitionType transition}) {
    _router.navigateTo(context, route, transition: transition);
  }

  static void navigateTo(context, String id) {
    Routes._navigateTo(
      context,
      '/detail/$id',
      transition: TransitionType.fadeIn
    );
  }

}