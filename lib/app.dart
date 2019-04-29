// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'package:asset_mobile/authentication/authentication.dart';
import 'package:asset_mobile/splash/splash.dart';
import 'package:asset_mobile/login/login.dart';
import 'package:asset_mobile/home/home.dart';
import 'package:asset_mobile/common/common.dart';

class App extends StatefulWidget {
  final UserRepository userRepository;
  final appTitle = 'Asset Word Electric (Thailand)';

  App({Key key, @required this.userRepository}) : super(key: key);

  State<App> createState() => _AppState(title: appTitle);
}

class _AppState extends State<App> {
  final String title;
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;

  _AppState({this.title}) ;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());

    super.initState();
  }

  @override
  void dispost() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        theme: new ThemeData(
            primarySwatch: Colors.teal
        ),
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }

            if (state is AuthenticationAuthenticated) {
              return HomePage();
            }

            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: _userRepository);
            }

            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
          },
        ),
      ),
    );
  }
}
//void main() => runApp(MyApp());

//class MyApp extends StatelessWidget {
//  final appTitle = 'Assets World Electrict (Thailand)';
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: appTitle,
//      home: MyHomePage(title: appTitle),
//    );
//  }
//}
