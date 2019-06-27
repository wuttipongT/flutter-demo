import 'package:asset_mobile/model/user_response.dart';
import 'package:asset_mobile/repository/employee_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:asset_mobile/model/chart_model.dart';

class EmployeeBloc {
  final EmployeeRepository _repository = EmployeeRepository();
//  BehaviorSubject<Map> _subject = BehaviorSubject<Map>();
//  BehaviorSubject<int> _subjectTotal = BehaviorSubject<int>();
//  BehaviorSubject<List<Map<String, dynamic>>>  _subjectAsset = BehaviorSubject<List<Map<String, dynamic>>>();

  Future getCheckData(Map o) async {

    Map box = new Map();
    final prefs = await SharedPreferences.getInstance();

    box['token'] = prefs.getString('token');
    box['section'] = prefs.getString('section');
    box['year'] = prefs.getString('year');
    box['month'] = prefs.getString('month');
    box['take'] = o['take'];
    box['skip'] = o['skip'];

    Map response = await _repository.CheckData(box);
    return response;
//    _subject.sink.add(response);
  }

  Future getTotal([String type = ""]) async {
    final prefs = await SharedPreferences.getInstance();
    var box = {
      "section": prefs.getString('section')
    };

    switch(type) {
      case 'asset':
        box['type'] = "asset";
        break;
      case 'balance':
        box['type'] = "balance";
        box['year'] = prefs.getString('year');
        box['month'] = prefs.getString('month');
        break;
      case 'pc-detail' :
        box['type'] = "pc-detail";
        break;
      default:
        box['year'] = prefs.getString('year');
        box['month'] = prefs.getString('month');
    }

    String token = prefs.getString('token');
    int response = await _repository.getTotal(box, token);
    return response;
  }

  Future getAsset(Map o) async {
    Map box = new Map();
    final prefs = await SharedPreferences.getInstance();
    box['token'] = prefs.getString('token');
    box['section'] = prefs.getString('section');
    box['take'] = o['take'];
    box['skip'] = o['skip'];

    Map response = await _repository.getAsset(box);
//    _subjectAsset.sink.add(response);
    return response;
  }

  Future getBalance(Map o) async {
    Map box = new Map();
    final prefs = await SharedPreferences.getInstance();
    box['section'] = prefs.getString('section');
    box['year'] = prefs.getString('year');
    box['month'] = prefs.getString('month');
    box['take'] = o['take'];
    box['skip'] = o['skip'];

    Map response = await _repository.getBalance(box, prefs.getString('token'));
//    _subjectAsset.sink.add(response);
    return response;
  }

  Future<List<Map<String, dynamic>>> getPc(Map o) async {
    Map box = new Map();
    final prefs = await SharedPreferences.getInstance();
    box['take'] = o['take'];
    box['skip'] = o['skip'];

    var response = await _repository.getPc(box, prefs.getString('token'));
//    _subjectAsset.sink.add(response);
    return response;
  }

  Future<List<Map<String, dynamic>>> getAssetByKey(String assetno) async {
    Map box = new Map();
    final prefs = await SharedPreferences.getInstance();
    box['section'] = prefs.getString('section');
    box['assetno'] = assetno;

    var response = await _repository.getAssetByKey(box, prefs.getString('token'));
//    _subjectAsset.sink.add(response);
    return response;
  }

  Future<List<Map<String, dynamic>>> getPcDetailByKey(String assetno) async {
    Map box = new Map();
    final prefs = await SharedPreferences.getInstance();
    box['assetno'] = assetno;

    var response = await _repository.getPc(box, prefs.getString('token'));
//    _subjectAsset.sink.add(response);
    return response;
  }

  Future<List<ChartModel>> getChart() async{
    final prefs = await SharedPreferences.getInstance();
    var response = await _repository.getChart( prefs.getString('token'));
    return response.results;
  }
//  BehaviorSubject<Map> get subject => _subject;
//  BehaviorSubject<int> get subjectTotal => _subjectTotal;
//  BehaviorSubject<List<Map<String, dynamic>>> get subjectAsset => _subjectAsset;
}


final bloc = EmployeeBloc();