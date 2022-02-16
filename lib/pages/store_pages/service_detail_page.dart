import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:comodiwash/models/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ServiceDetailPage extends StatefulWidget {
  final Services services;

  ServiceDetailPage({Key? key, required this.services}) : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  int qtd = 1;
  double rating = 0;

  /// Returns a circular button with inkwell gesture detector
  ///
  /// @param isAdd Bool used to define if the icon should be add(if true) or minus(false)
  Widget buildQtdButton(bool isAdd) {
    if (!isAdd) {
      return Material(
        child: Ink(
          decoration: BoxDecoration(
              color: Color.fromRGBO(45, 26, 71, 1),
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle),
          child: InkWell(
            onTap: () => setState(() {
              if (qtd > 1) {
                qtd -= 1;
              }
            }),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.remove,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    } else {
      return Material(
        child: Ink(
          decoration: BoxDecoration(
              color: Color.fromRGBO(45, 26, 71, 1),
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle),
          child: InkWell(
            onTap: () => setState(() {
              qtd += 1;
            }),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Icon(Icons.add, size: 25, color: Colors.white),
            ),
          ),
        ),
      );
    }
  }

  /// Return SingleChildScrollView with the service description text
  Widget buildDescription() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.28,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          widget.services.description,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }

  Widget serviceTitle() {
    return Row(
      textBaseline: TextBaseline.ideographic,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      children: [
        Text(
          widget.services.name,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          real.format(widget.services.price),
          style: TextStyle(fontSize: 22),
        ),
      ],
    );
  }

  // TODO add actual rating
  Widget ratingButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(
        Icons.star,
        color: Colors.amber,
        size: 28,
      ),
      label: Text(
        rating.toString(),
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
          primary: Colors.white, elevation: 0, padding: EdgeInsets.all(0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GenericAppBar(title: '', useTitle: false),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 8),
        child: Column(
          children: [
            // service icon
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image.asset(widget.services.icon),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Builds title and price of service
            serviceTitle(),
            SizedBox(height: 15),
            // Build rating button
            Align(alignment: Alignment.centerLeft, child: ratingButton()),
            Spacer(),
            // service description
            buildDescription(),
            Spacer(),
            // Add to cart button
            SafeArea(
                top: false,
                left: false,
                right: false,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        primary: Color.fromRGBO(45, 26, 71, 1),
                        onPrimary: Colors.white,
                        minimumSize: Size(300, 50)),
                    onPressed: () {
                      print('Carrinho ${widget.services.name}');
                    },
                    icon: Icon(
                      Icons.shopping_bag,
                      size: 28,
                    ),
                    label: Text(
                      'Adicionar ao carrinho',
                      style: TextStyle(fontSize: 18),
                    )))
          ],
        ),
      ),
    );
  }
}
