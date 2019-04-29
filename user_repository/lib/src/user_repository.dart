import 'package:meta/meta.dart';
import 'package:asset_mobile/model/employee.dart';
import 'package:asset_mobile/repository/employee_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {

  String username;
  String password;
  String name;
  String year;
  String month;
  String section;
  String token;

  Future<String> authenticate({
    @required String username,
    @required String password,
    String name,
    String year,
    String month,
    String section,
    String api_token
  }) async {

    this.username = username;
    this.password = password;
    this.name = name;
    this.year = year;
    this.month = month;
    this.section = section;
    this.token = api_token;

    _storageSession();

    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    final EmployeeRepository _repository = EmployeeRepository();
    _repository.logout(this.token);
    _removeSession();
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  _storageSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name", this.name);
    prefs.setString("email", this.username);
    prefs.setString("year", this.year);
    prefs.setString("month", this.month);
    prefs.setString("section", this.section);
    prefs.setString("token", this.token);
  }

  _removeSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("year");
    prefs.remove("month");
    prefs.remove("section");
    prefs.remove("token");
  }
}