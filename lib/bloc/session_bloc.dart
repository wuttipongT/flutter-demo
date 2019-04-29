import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

class SessionBloc {
  final BehaviorSubject<Map> _subject = BehaviorSubject<Map>();

  getSession() async {
    Map o = new Map();
    final prefs = await SharedPreferences.getInstance();
    o['name'] = prefs.getString("name");
    o['email'] = prefs.getString("email");
    o['section'] = prefs.getString("section");
    o['month'] = prefs.getString("month");
    o['year'] = prefs.getString("year");
    o['token'] = prefs.getString("token");

    _subject.sink.add(o);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<Map> get subject => _subject;

}
final bloc = SessionBloc();