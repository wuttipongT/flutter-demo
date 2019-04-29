import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:user_repository/user_repository.dart';

import 'package:asset_mobile/authentication/authentication.dart';
import 'package:asset_mobile/login/login.dart';
import 'package:asset_mobile/repository/employee_repository.dart';
import 'package:asset_mobile/model/employee_response.dart';
import 'package:asset_mobile/model/employee.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  final EmployeeRepository _repository = EmployeeRepository();

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
          EmployeeResponse response = await _repository.login(event.username, event.password);

          if (response != null && response.result != null) {
            Employee d = response.result;
            final token = await userRepository.authenticate(
              username: event.username,
              password: event.password,
              name: d.name,
              year: d.year,
              month: d.month,
              section: d.section,
              api_token: d.api_token
            );

            authenticationBloc.dispatch(LoggedIn(token: token));
            yield LoginInitial();
          } else {
            yield LoginFailure(error: response.error);
          }

      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}