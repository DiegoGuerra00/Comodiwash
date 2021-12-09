/// Class defining a car model
class Car {
  final String manufacturer;
  final String model;

  Car({required this.manufacturer, required this.model});

  /// Map the json data in car instances
  factory Car.fromJson(Map<String, dynamic> json) {
    return new Car(manufacturer: json['marca'], model: json['modelo']);
  }
}

class CarList { 
  final List<Car> cars;

  CarList(this.cars);

  /// Parse the mapped json in a list of car instances
  factory CarList.fromJson(List<dynamic> parsedJson) {
    List<Car> cars = new List<Car>.empty();
    cars = parsedJson.map((i) => Car.fromJson(i)).toList();

    return CarList(cars);
  }
}
