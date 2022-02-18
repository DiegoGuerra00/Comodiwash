import 'package:comodiwash/models/cart_item.dart';
import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:comodiwash/repositories/shopping_cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late ShoppingCartRepository cartItems =
      Provider.of<ShoppingCartRepository>(context);
  double totalPrice = 0;
  NumberFormat real =
      NumberFormat.currency(locale: 'pt_BR', name: 'R\$', decimalDigits: 0);

  Widget buildEmptyListBody() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset('assets/icons/ComodiWashSquarerender.png'),
          ),
          SizedBox(
            height: 15,
          ),
          Text('O seu carrinho está vazio', style: TextStyle(fontSize: 24)),
          SizedBox(
            height: 25,
          ),
          Text(
            'Volte uma página e adicione produtos ou serviços ao seu carrinho',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          Spacer()
        ],
      )),
    );
  }

  Widget buildBody() {
    return Consumer<ShoppingCartRepository>(builder: (context, items, child) {
      return items.cartList.isEmpty
          ? buildEmptyListBody()
          : ListView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: items.cartList.length,
              itemBuilder: (BuildContext context, int item) => Card(
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                      child: SizedBox(
                        child: Image.asset(items.cartList[item].icon),
                        width: 75,
                        height: 75,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items.cartList[item].name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text(real.format(items.cartList[item].price),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                          onTap: () {
                            print('Removido Carrinho');
                          },
                          child: Icon(Icons.delete_outline)),
                    )
                  ],
                ),
              ),
            );
    });
  }

  Widget checkoutCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
                height: 15,
                width: 50,
                child: Card(
                  color: Colors.grey.withOpacity(0.3),
                )),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Checkout',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          checkoutButton()
        ],
      ),
    );
  }

  Widget checkoutButton() {
    return ElevatedButton(
        onPressed: () {},
        child: Text('Checkout'),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            primary: Color.fromRGBO(45, 26, 71, 1),
            onPrimary: Colors.white,
            minimumSize: Size(300, 50)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: '', useTitle: false),
        body: Column(
          children: [
            Expanded(child: buildBody()),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Card(elevation: 10, child: checkoutCard()),
            ),
          ],
        ));
  }
}
