import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RouteInterceptor extends NavigatorObserver {
  final List<Route<dynamic>> _routeStack = [];

  List<Route<dynamic>> get routeStack => _routeStack;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.add(route);
    // printStack();
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.removeLast();
    // printStack();
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _routeStack.remove(route);
    // printStack();
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (oldRoute != null) {
      _routeStack.remove(oldRoute);
    }
    if (newRoute != null) {
      _routeStack.add(newRoute);
    }
    // printStack();
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void printStack() {
    if (kDebugMode) {
      print('Current Navigation Stack:');
      for (var route in _routeStack) {
        print(route.settings.name);
      }
    }
  }
}





