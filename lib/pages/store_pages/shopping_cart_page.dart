import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:comodiwash/repositories/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final cartItens = ShoppingCart.cartList;
  double totalPrice = 0;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');

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

  Widget buildItensList() {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      itemCount: cartItens.length,
      itemBuilder: (BuildContext context, int item) => Card(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
              child: SizedBox(
                child: Image.asset(cartItens[item].icon),
                width: 75,
                height: 75,
              ),
            ),
            Spacer(),
            Column(
              children: [
                Text(cartItens[item].name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(real.format(cartItens[item].price),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
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
  }

  Widget buildPaymentList() {
    return Text('Nenhum método de pagamento adicionado',
        style: TextStyle(fontSize: 18, color: Colors.grey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GenericAppBar(title: '', useTitle: false),
        body: cartItens.isEmpty
            ? buildEmptyListBody()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(child: buildItensList()),
                    SizedBox(height: 25,),
                    Text('Métodos de Pagamento',
                        style: TextStyle(fontSize: 20)
                    ),
                    buildPaymentList(),
                    Spacer(),
                    Text('Total do Pedido',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    Text(real.format(totalPrice),
                        style: TextStyle(fontSize: 20)
                    ),
                    Spacer(),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            primary: Color.fromRGBO(45, 26, 71, 1),
                            onPrimary: Colors.white,
                            minimumSize: Size(300, 50)
                        ),
                        onPressed: () {
                          print('Finalizar compra');
                        },
                        child: Text('Checkout'))
                  ],
                ),
              ));
  }
}
