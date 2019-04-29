class Employee {
  final String name;
  final String email;
  final String year;
  final String month;
  final String section;
  final String api_token;

  Employee(this.name, this.email, this.year, this.month, this.section, this.api_token);

  Employee.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      email = json['email'],
      year = json['year'],
      month = json['month'],
      section = json['section'],
      api_token = json['api_token'];
}