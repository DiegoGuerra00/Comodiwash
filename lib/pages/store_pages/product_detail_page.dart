import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:comodiwash/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  final Products products;

  ProductDetailPage({Key? key, required this.products}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$', decimalDigits: 0);
  bool isReadMore = false;
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
              if (qtd < 10) {
                qtd += 1;
              }
            }),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.add,
                size: 25,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }

  /// Return SingleChildScrollView with the product description text
  Widget buildDescription() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.28,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text(
          widget.products.description,
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GenericAppBar(title: '', useTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // product icon
            Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Image.asset(widget.products.icon),
              ),
            ),
            // product name
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.products.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 20),
            // row with price, qtd button and rating bar
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Row(
                children: [
                  buildQtdButton(false),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      qtd.toString(),
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  buildQtdButton(true),
                  Spacer(),
                  Column(children: [
                    Text(
                      real.format(widget.products.price * qtd),
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    RatingBar.builder(
                      minRating: 1,
                      initialRating: rating,
                      allowHalfRating: true,
                      itemSize: 30,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) => setState(() {
                        this.rating = rating;
                      }),
                    )
                  ])
                ],
              ),
            ),
            Spacer(),
            // product description
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: buildDescription(),
            ),
            Spacer(),
            // add to cart button
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
                    print('Carrinho ${widget.products.name}');
                  },
                  icon: Icon(Icons.shopping_bag, size: 28,),
                  label: Text(
                    'Adicionar ao carrinho',
                    style: TextStyle(fontSize: 18),
                  )
              )
            )
          ],
        ),
      ),
    );
  }
}
