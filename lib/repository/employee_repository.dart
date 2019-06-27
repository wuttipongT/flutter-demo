import 'package:asset_mobile/model/employee_response.dart';
import 'package:asset_mobile/repository/employee_api_provider.dart';
import 'package:asset_mobile/model/chart_model.dart';

class EmployeeRepository {
  EmployeeApiProvider _apiProvider = EmployeeApiProvider();

  Future<EmployeeResponse> login(String username, String passwd) async {
    return await _apiProvider.login(username, passwd);
  }

  Future logout(String token) {
    _apiProvider.logout(token);
  }

  Future<Map> CheckData(Map box) {
    return _apiProvider.CheckData(box);
  }

  Future<Map> getAsset(Map box) {
    return _apiProvider.getAsset(box);
  }

  Future<Map> getBalance(Map box, String token) {
    return _apiProvider.getBalance(box, token);
  }

  Future<int> getTotal(var box, String token) {
    return _apiProvider.getTotal(box, token);
  }

  Future<List<Map<String, dynamic>>> getPc(var box, String token) {
    return _apiProvider.getPc(box, token);

  }

  Future<List<Map<String, dynamic>>> getAssetByKey(var box, String token) {
    return _apiProvider.getAssetByKey(box, token);

  }

  Future<List<Map<String, dynamic>>> getPcDetailByKey(var box, String token) {
    return _apiProvider.getPcDetailByKey(box, token);
  }

  Future<ChartModelResponse> getChart(String token) async{
    return await _apiProvider.getChart(token);
  }

}