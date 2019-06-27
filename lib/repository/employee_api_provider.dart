import 'package:asset_mobile/model/employee_response.dart';
import 'package:dio/dio.dart';
import 'package:asset_mobile/model/chart_model.dart';
class EmployeeApiProvider {
  final String _endpoint = "http://assets.world-electric.com";
  final Dio _dio = Dio();
  
  Future<EmployeeResponse> login (String username, String passwd) async {
    var _http = Dio();
    try {
      Response response = await _http.post('$_endpoint/api/login', data: {"email": username, "password": passwd});
      var x = response.data;
      return EmployeeResponse.fromJson(response.data);
    }  on DioError catch(e) {
        return EmployeeResponse.withError(e.response.data['error']);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return EmployeeResponse.withError(error);
    }

  }

  Future logout (String token) async {
    try {
      Response response = await _dio.post('$_endpoint/api/logout', options: new Options(headers: {"Authorization": "Bearer $token"}));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Map> CheckData(Map box) async{
    try {
      //?section=IT&month=3&year=2019
      Response response = await _dio.get('$_endpoint/api/check', queryParameters: {"section": box['section'], "month": box['month'], "year": box['year'], "take":box['take'], "skip": box['skip']}, options: new Options(headers: {"Authorization": "Bearer ${box['token']}"}));
      Map o = response.data;
      return o;
//      return (o['data'] as List).map((i) => {"name":(i as Map)['CHK_ASSNO'], "title":(i as Map)['DESC']}).toList();

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }


  Future<int> getTotal(var box, String token) async{
    try {
      //?section=IT&month=3&year=2019
//      Response response = await _dio.get('$_endpoint/api/total', queryParameters: {"section": box['section'], "month": box['month'], "year": box['year'], "type"}, options: new Options(headers: {"Authorization": "Bearer ${box['token']}"}));
      String queryParam = "";
      box.forEach((k, v){
        queryParam += "&${k}=${v}";
      });

      Response response = await _dio.get('$_endpoint/api/total?${queryParam}', options: new Options(headers: {"Authorization": "Bearer ${token}"}));

      Map o = response.data;
      return o['total'];
//      return (o['data'] as List).map((i) => {"name":(i as Map)['CHK_ASSNO'], "title":(i as Map)['DESC']}).toList();

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Map> getAsset(Map box) async{
    try {
      //?section=IT&month=3&year=2019
      Response response = await _dio.get('$_endpoint/api/asset', queryParameters: {"section": box['section'], "take":box['take'], "skip": box['skip']}, options: new Options(headers: {"Authorization": "Bearer ${box['token']}"}));
      Map o = response.data;
      return o;
//      return (o['data'] as List).map((i) => {"name":(i as Map)['CHK_ASSNO'], "title":(i as Map)['DESC']}).toList();

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<Map> getBalance(var box, String token) async{
    try {
      //?section=IT&month=3&year=2019

      String queryParam = "";
      box.forEach((k, v){
        queryParam += "&${k}=${v}";
      });

      Response response = await _dio.get('$_endpoint/api/balance?${queryParam}', options: new Options(headers: {"Authorization": "Bearer ${token}"}));
      Map o = response.data;
      return o;
//      return (o['data'] as List).map((i) => {"name":(i as Map)['CHK_ASSNO'], "title":(i as Map)['DESC']}).toList();

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<List<Map<String, dynamic>>> getPc(var box, String token) async{
    var _http = Dio();
    try {
      //?section=IT&month=3&year=2019

      String _queryParam = "";
      box.forEach((k, v){
        _queryParam += "${k}=${v}&";
      });

      Response response = await _http.get("http://assets.world-electric.com/api/pc-detail?$_queryParam", options: new Options(headers: {"Authorization": "Bearer ${token}"}));
      List<Map<String, dynamic>> data = (response.data as List).map((i) => (i as Map<String, dynamic>)).toList();
      return data;
//      return (o['data'] as List).map((i) => {"name":(i as Map)['CHK_ASSNO'], "title":(i as Map)['DESC']}).toList();

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<List<Map<String, dynamic>>> getAssetByKey(var box, String token) async{
    var _http = Dio();
    try {
      //?section=IT&month=3&year=2019

      String _queryParam = "";
      box.forEach((k, v){
        _queryParam += "${k}=${v}&";
      });

      Response response = await _http.get('$_endpoint/api/asset?${_queryParam}', options: new Options(headers: {"Authorization": "Bearer ${token}"}));
      List<Map<String, dynamic>> data = (response.data['data'] as List).map((i) => (i as Map<String, dynamic>)).toList();
      return data;
//      return (o['data'] as List).map((i) => {"name":(i as Map)['CHK_ASSNO'], "title":(i as Map)['DESC']}).toList();

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<List<Map<String, dynamic>>> getPcDetailByKey(var box, String token) async{
    var _http = Dio();
    try {
      //?section=IT&month=3&year=2019

      String _queryParam = "";
      box.forEach((k, v){
        _queryParam += "${k}=${v}&";
      });

      Response response = await _http.get("http://assets.world-electric.com/api/pc-detail?$_queryParam", options: new Options(headers: {"Authorization": "Bearer ${token}"}));
      List<Map<String, dynamic>> data = (response.data['data'] as List).map((i) => (i as Map<String, dynamic>)).toList();
      return data;
//      return (o['data'] as List).map((i) => {"name":(i as Map)['CHK_ASSNO'], "title":(i as Map)['DESC']}).toList();

    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<ChartModelResponse> getChart(String token) async {
    var _http = Dio();
    try {
      Response response = await _http.get("$_endpoint/api/chart", options: new Options(headers: {"Authorization": "Bearer ${token}"}));
      return ChartModelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ChartModelResponse.withError("$error");
    }
  }
}