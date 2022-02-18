import 'package:comodiwash/models/cart_item.dart';
import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:comodiwash/models/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:comodiwash/repositories/shopping_cart_repository.dart';
import 'package:provider/provider.dart';

class ServiceDetailPage extends StatefulWidget {
  final Services services;

  ServiceDetailPage({Key? key, required this.services}) : super(key: key);

  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  NumberFormat real =
      NumberFormat.currency(locale: 'pt_BR', name: 'R\$', decimalDigits: 0);
  int qtd = 1;
  double rating = 0;
  late ShoppingCartRepository cartItems =
      Provider.of<ShoppingCartRepository>(context, listen: false);
  String img2 = 'assets/images/ComodiWash_horizontal.png';
  String imagePath = 'assets/images/ComodiWash_horizontal.png';
  int imageIndex = 0;
  TextEditingController _textController = TextEditingController();
  String feedback = '';

  void changeImage(int index) {
    switch (index) {
      case 0:
        setState(() {
          imagePath = widget.services.icon;
        });
        break;
      case 1:
        setState(() {
          imagePath = img2;
        });
        break;
    }
  }

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
    return Text(
      widget.services.name,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget ratingBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          RatingBar.builder(
            minRating: 1,
            initialRating: rating,
            allowHalfRating: true,
            itemSize: 50,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) => setState(() {
              this.rating = rating;
            }),
          ),
          TextFormField(
            controller: _textController,
            maxLines: 7,
            onChanged: (text) {
              print(_textController.text.trim());
            },
            decoration: InputDecoration(
              hintText: 'Digite aqui seu feedback',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(45, 26, 71, 1)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('feedback button');
            },
            child: Text('Envie seu feedback'),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                primary: Color.fromRGBO(45, 26, 71, 1),
                onPrimary: Colors.white,
                minimumSize: Size(300, 50)),
          )
        ],
      ),
    );
  }

  // TODO add actual rating
  Widget ratingButton() {
    return ElevatedButton.icon(
      onPressed: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ratingBar());
            });
      },
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
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx > 0) {
                    setState(() {
                      if (imageIndex < 3) {
                        imageIndex++;
                      }
                    });
                    changeImage(imageIndex);
                  }
                  if (details.delta.dx < 0) {
                    setState(() {
                      if (imageIndex >= 0) {
                        imageIndex--;
                      }
                    });
                    changeImage(imageIndex);
                  }
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(imagePath),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Builds title and price of service
            Align(alignment: Alignment.bottomLeft, child: serviceTitle()),
            SizedBox(height: 5),
            // Build rating button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(alignment: Alignment.centerLeft, child: ratingButton()),
                Text(
                  real.format(widget.services.price),
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
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
                      cartItems.save(CartItem(
                          icon: widget.services.icon,
                          name: widget.services.name,
                          price: widget.services.price,
                          qtd: 1));
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
