import 'package:comodiwash/models/products.dart';
import 'package:comodiwash/models/services.dart';
import 'package:comodiwash/pages/store_pages/product_detail_page.dart';
import 'package:comodiwash/pages/store_pages/shopping_cart_page.dart';
import 'package:comodiwash/repositories/products_repository.dart';
import 'package:comodiwash/repositories/services_repository.dart';
import 'package:comodiwash/pages/store_pages/service_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  String _searchText = '';
  String _servicesSortSetting = 'A-Z';
  String _productsSortSettings = 'A-Z';
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$', decimalDigits: 0);
  late ServicesRepository services;
  late ProductsRepository products;
  bool searchPressed = false;

  void _searchBarPressed() {
    if (searchPressed) {
      setState(() {
        searchPressed = false;
      });
    } else if (!searchPressed) {
      setState(() {
        searchPressed = true;
      });
    }
  }

  /// Return colunm for the sort options of the services when the modalButtonSheet is clicked
  Widget buildServicesSortOptions() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _servicesSortSetting = 'A-Z';
                    Navigator.pop(context);
                  });
                },
                child:
                    Center(child: Text('A-Z', style: TextStyle(fontSize: 20))),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _servicesSortSetting = 'Menor Preço';
                    Navigator.pop(context);
                  });
                },
                child: Center(
                    child: Text('Menor Preço', style: TextStyle(fontSize: 20))),
              )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: InkWell(
            onTap: () {
              setState(() {
                _servicesSortSetting = 'Maior Preço';
                Navigator.pop(context);
              });
            },
            child: Center(
                child: Text('Maior Preço', style: TextStyle(fontSize: 20))),
          ),
        ),
      ],
    );
  }

  /// Return colunm for the sort options of the products when the modalButtonSheet is clicked
  Widget buildProdctsSortOptions() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _productsSortSettings = 'A-Z';
                    Navigator.pop(context);
                  });
                },
                child:
                    Center(child: Text('A-Z', style: TextStyle(fontSize: 20))),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _productsSortSettings = 'Menor Preço';
                    Navigator.pop(context);
                  });
                },
                child: Center(
                    child: Text('Menor Preço', style: TextStyle(fontSize: 20))),
              )),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: InkWell(
            onTap: () {
              setState(() {
                _productsSortSettings = 'Maior Preço';
                Navigator.pop(context);
              });
            },
            child: Center(
                child: Text('Maior Preço', style: TextStyle(fontSize: 20))),
          ),
        ),
      ],
    );
  }

  /// Return card(with inkwell) for the sort options of the services.
  ///
  /// onTap opens ModalButtonSheet
  Widget buildServicesSortButton() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      color: Color.fromRGBO(45, 26, 71, 1),
      child: SizedBox(
        width: 135,
        height: 30,
        child: InkWell(
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 160,
                  child: buildServicesSortOptions(),
                );
              }),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  _servicesSortSetting,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  Icons.sort,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Return card(with inkwell) for the sort options of the products.
  ///
  /// onTap opens ModalButtonSheet
  Widget buildProductsSortButton() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      color: Color.fromRGBO(45, 26, 71, 1),
      child: SizedBox(
        width: 135,
        height: 30,
        child: InkWell(
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 160,
                  child: buildProdctsSortOptions(),
                );
              }),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  _productsSortSettings,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Icon(
                  Icons.sort,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Open the specific page for the service, using MaterialPageRoute with Navigator.push
  ///
  /// @param services The service to use to open the detail page
  void openServicePage(Services services) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ServiceDetailPage(services: services)));
  }

  /// Open the specific page for the product, using MaterialPageRoute with Navigator.push
  ///
  /// @param products The product to use to open the detail page
  void openProductPage(Products products) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ProductDetailPage(products: products)));
  }

  /// Build the listview for the services, using data from the provider ServicesRepository, with data from firebase db
  Widget buildServices() {
    services = Provider.of<ServicesRepository>(context);

    return Consumer<ServicesRepository>(builder: (context, services, child) {
      return services.servicesList.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 270,
                child: ListView.separated(
                  itemCount: 50,
                  itemBuilder: (BuildContext context, int index) =>
                      LoadingContainer(
                    height: 260,
                    width: 200,
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    width: 50,
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 270,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: services.servicesList.length,
                  itemBuilder: (BuildContext context, int service) => Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: InkWell(
                      onTap: () =>
                          openServicePage(services.servicesList[service]),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  child: Image.asset(
                                      services.servicesList[service].icon)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 10),
                              child: Text(
                                services.servicesList[service].name,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                real.format(
                                    services.servicesList[service].price),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }

  /// Build the listview for the products, using data from the provider ProductsRepository, with data from firebase db
  Widget buildProducts() {
    products = Provider.of<ProductsRepository>(context);

    return Consumer<ProductsRepository>(builder: (context, services, child) {
      return products.productsList.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 270,
                child: ListView.separated(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) =>
                      const LoadingContainer(height: 260, width: 200),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 16,
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 270,
                child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: products.productsList.length,
                  itemBuilder: (BuildContext context, int product) => Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: InkWell(
                      onTap: () =>
                          openProductPage(products.productsList[product]),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                                  child: Image.asset(
                                      services.productsList[product].icon)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, top: 10),
                              child: Text(
                                products.productsList[product].name,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                real.format(
                                    products.productsList[product].price),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }

  /// Return textfild for the search bar on the top of the screen
  Widget buildSearchBar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: TextField(
        onChanged: (text) {
          _searchText = text;
          print(_searchText);
          // TODO implement search
        },
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(45, 26, 71, 1)),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            labelText: 'Busca...',
            labelStyle: TextStyle(color: Color.fromRGBO(45, 26, 71, 1)),
            prefixIcon: Icon(
              Icons.search,
              color: Color.fromRGBO(45, 26, 71, 1),
            )),
      ),
    );
  }

  /// Return the row where the services sort button is placed
  Widget buildServicesMenu() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 10, bottom: 6),
      child: Row(
        children: [
          Text(
            'Serviços',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: buildServicesSortButton(),
          )
        ],
      ),
    );
  }

  /// Return the row where the products sort button is placed
  Widget buildProductsMenu() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 10, bottom: 6),
      child: Row(children: [
        Text(
          'Produtos',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: buildProductsSortButton(),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          searchPressed
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 8, left: 8),
                  child: buildSearchBar(),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            child: GestureDetector(
              onTap: () {
                _searchBarPressed();
              },
              child: !searchPressed
                  ? Icon(
                      Icons.search,
                      color: Colors.black,
                    )
                  : Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ShoppingCartPage()));
              },
              child: Icon(Icons.local_grocery_store, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(45, 26, 71, 1),
              radius: 16,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.deepPurple,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            buildServicesMenu(),
            buildServices(),
            buildProductsMenu(),
            buildProducts()
          ],
        ),
      ),
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.black,
          // color: Colors.black.withOpacity(0.05),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
    );
  }
}
