import 'package:comodiwash/models/garage_car.dart';
import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:flutter/material.dart';

class CarDetailPage extends StatefulWidget {
  GarageCar car;

  CarDetailPage({Key? key, required this.car}) : super(key: key);

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Image.asset(widget.car.icon),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(widget.car.manufacturer, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(width: 20),
                Text(widget.car.model, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Spacer(),
                Text(widget.car.year, style: TextStyle(fontSize: 18))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Placa: ${widget.car.licensePlate}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: widget.car.model, useTitle: true),
      body: buildBody(),
    );
  }
}
