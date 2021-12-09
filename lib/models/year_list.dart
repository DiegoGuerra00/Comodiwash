class Year {
  final String year;

  Year({required this.year});

  /// Map the json into YearList instances
  factory Year.fromJson(Map<String, dynamic> json) {
    return new Year(year: json['ano']);
  }
}

class YearList {
  final List<Year> years;

  YearList(this.years);

  /// Get the mapped json and save in a list of instances
  factory YearList.fromJson(List<dynamic> parsedJson) {
    List<Year> years = new List<Year>.empty();
    years = parsedJson.map((i) => Year.fromJson(i)).toList();

    return YearList(years);
  }
}
