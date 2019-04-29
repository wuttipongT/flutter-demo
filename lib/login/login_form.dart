import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:asset_mobile/authentication/authentication.dart';
import 'package:asset_mobile/login/login.dart';

import 'package:dio/dio.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthenticationBloc authenticationBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authenticationBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _value2 = false;
  bool _obscureText = true;

  void _value2Changed(bool value) => setState(() => _value2 = value);

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
//    _usernameController.text = 's_janpen@world-electric.co.th';
//    _passwordController.text = 'C000064';

    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
          BuildContext context,
          LoginState state,
          ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        return Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'username',icon: new Icon(Icons.person)),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'password',
                      icon: new Icon(Icons.vpn_key),
                      suffix: new IconButton(onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      }, icon: new Icon(Icons.remove_red_eye))
                  ),
                  controller: _passwordController,
                  obscureText: _obscureText,

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: CheckboxListTile(
                    value: _value2,
                    onChanged: _value2Changed,
                    title: new Text('Remember Me'),
                    controlAffinity: ListTileControlAffinity.leading,
//                  secondary: new Icon(Icons.archive),
                    activeColor: Colors.red,
                  ),
                ),
                RaisedButton(
                  onPressed:
                  state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('Login', style: TextStyle(color: Colors.white),),
                  color: const Color(0xFF4db6ac),
                ),
//              RaisedButton(
//                child: Text('Click me!'),
//                onPressed: _onClickmePressed,
//              ),
                Container(
                  child:
                  state is LoginLoading ? CircularProgressIndicator() : null,
                ),
              ],
            ),
          )
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _onLoginButtonPressed() {
    _loginBloc.dispatch(LoginButtonPressed(
      username: _usernameController.text,
      password: _passwordController.text,
    ));
  }

  _onClickmePressed() async{
//    var o =  {"x": "y", "a": "b"};
//
//    String str = "";
//    o.forEach((k, v){
//      str += "&${k}=${v}";
//    });
//    print(str);
    final Dio _dio = Dio();
    try {
      Response response = await _dio.get("http://assets.world-electric.com/api/pc-detail?&take=150&skip=150", options: new Options(headers: {"Authorization": "Bearer W7QSEzSBMssf9ZEdqcjjgMrRdPfMdNWTiMUkHtywSmTSMHZa3kJKtrC40BYJ"}));
      List<Map<String, dynamic>> data = (response.data as List).map((i) => (i as Map<String, dynamic>)).toList();
//      List<Map<String, dynamic>> d = (data['data'] as List).map((i) => {"title": i['DESC'], "name": i['CHK_ASSNO']});
//      List l = (data['data'] as List).map((i) => {"name":(i as Map)['CHK_ASSNO'], "title":(i as Map)['DESC']}).toList();
      print(data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}