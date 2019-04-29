import 'package:asset_mobile/model/employee.dart';

class EmployeeResponse {
//  final List<Employee> result;
  Employee result;
  final String error;

  EmployeeResponse(this.result, this.error);

  EmployeeResponse.fromJson(Map<String, dynamic> json)
    : result = new Employee.fromJson(json["results"]),//result = (json["results"] as List).map((i) => new Employee.fromJson(i)).toList(),
      error = "";

  EmployeeResponse.withError(String errorValue)
  : result = null,//result = List(),
    error = errorValue;
}