// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'app.dart';
import 'app_state_container.dart';

class SimpleBlogDelegate extends BlocDelegate {

  @override
  void onTransition(Transition transtion) {
    print(transtion);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(stacktrace);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlogDelegate();
  runApp(new AppStateContainer(
    child: new App(userRepository: UserRepository()),
  ));
}