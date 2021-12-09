class Manufacturer {
  final String name;
  final String icon;

  Manufacturer({required this.name, required this.icon});

  /// Map the json data into manufacturer instances
  factory Manufacturer.fromJson(Map<String, dynamic> json) {
    return new Manufacturer(name: json['marca'], icon: json['icon']);
  }
}

class ManufacturerList {
  final List<Manufacturer> manufacturers;

  ManufacturerList(this.manufacturers);

  /// Get the mapped json data and save in a list of manufacturer instances
  factory ManufacturerList.fromJson(List<dynamic> parsedJson) {
    List<Manufacturer> manufacturers = new List<Manufacturer>.empty();
    manufacturers = parsedJson.map((i) => Manufacturer.fromJson(i)).toList();

    return ManufacturerList(manufacturers);
  }
}
