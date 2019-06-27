
class ChartModel {
  final name;
  final qty;

  ChartModel(this.name, this.qty);

  ChartModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        qty = json["qty"];
}

class ChartModelResponse {
  final List<ChartModel> results;
  final String error;

  ChartModelResponse(this.results, this.error);

  ChartModelResponse.fromJson(Map<String, dynamic> json)
      : results =
  (json["results"] as List).map((i) => new ChartModel.fromJson(i)).toList(),
        error = "";

  ChartModelResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;
}