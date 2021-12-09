import 'package:collection/collection.dart';
import 'package:comodiwash/models/car_list.dart';
import 'package:comodiwash/models/garage_car.dart';
import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:comodiwash/models/manufacturer_list.dart';
import 'package:comodiwash/models/year_list.dart';
import 'package:comodiwash/repositories/garage_repository.dart';
import 'package:comodiwash/services/car_services.dart';
import 'package:comodiwash/services/manufacturer_services.dart';
import 'package:comodiwash/services/years_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddCarPage extends StatefulWidget {
  const AddCarPage({Key? key}) : super(key: key);

  @override
  _AddCarPageState createState() => _AddCarPageState();
}

class _AddCarPageState extends State<AddCarPage> {
  String searchText = '';
  String selectedManufacturer = 'Selecione a marca';
  String selectedModel = 'Selecione o modelo';
  String icon = '';
  String selectedYear = 'Selecione o ano';
  int selectedManufacturerIndex = -1;
  int selectedModelIndex = -1;
  int selectedYearModel = -1;
  late GarageRepository garage;
  String plateNumber = '';
  String selectedColor = 'Selecione a cor';
  String selectedColorIcon = 'assets/icons/colors/fantasia.png';
  String licensePlateIcon = 'assets/icons/placas/placa_generica.png';
  String selectedPlateType = '';

  /// Checks if the license plate is in valid
  /// 
  /// @param plate The string with the plate numbers to be checked
  checkLicensePlate<bool>(String plate) {
    List<String> plateChars = [];
    List<String> validPlate1 = [
      'char',
      'char',
      'char',
      'number',
      'number',
      'number',
      'number'
    ];
    List<String> validPlate2 = [
      'char',
      'char',
      'char',
      'number',
      'char',
      'number',
      'number'
    ];
    Function eq = const ListEquality().equals;

    if (plate.length != 7) {
      return false;
    }

    for (var i = 0; i < plate.length; i++) {
      if (num.tryParse(plate[i]) == null) {
        plateChars.add('char');
      } else {
        plateChars.add('number');
      }
    }

    if (eq(plateChars, validPlate1) || eq(plateChars, validPlate2)) {
      return true;
    } else {
      return false;
    }
  }

  /// Return TextField for the search box
  Widget buildSeachBox() {
    // TODO implement search
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 8),
      child: Container(
        height: 45,
        child: TextField(
          onChanged: (text) {
            searchText = text;
            print(searchText);
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              labelText: 'Busca...',
              prefixIcon: Icon(Icons.search)),
        ),
      ),
    );
  }

  /// Return FutureBuilder to build the manufacturer selection page, using the list provided by the json
  Widget manufacturerSelection() {
    return FutureBuilder(
      future: loadManufacturer(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: false,
                itemCount:
                    (snapshot.data! as ManufacturerList).manufacturers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2)),
                itemBuilder: (BuildContext context, int name) => InkWell(
                  onTap: () => {
                    setState(() {
                      selectedManufacturerIndex = name;
                    }),
                    selectedManufacturer = (snapshot.data! as ManufacturerList)
                        .manufacturers[name]
                        .name,
                    icon = (snapshot.data! as ManufacturerList)
                        .manufacturers[name]
                        .icon,
                    Navigator.pop(context)
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(width: 3, color: Colors.white)),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Container(
                                height: 60,
                                child: Image.asset(
                                    (snapshot.data! as ManufacturerList)
                                        .manufacturers[name]
                                        .icon),
                              ),
                            ),
                            Spacer(),
                            Text(
                              (snapshot.data! as ManufacturerList)
                                  .manufacturers[name]
                                  .name,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ))),
                ),
              ));
        } else if (snapshot.hasError) {
          print('${snapshot.hasError}');
          return Text('Erro');
        } else {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                SizedBox(
                    width: 280,
                    height: 280,
                    child: Image.asset(
                        'assets/icons/ComodiWashHorizontalRender.png')),
                CircularProgressIndicator(color: Color.fromRGBO(45, 26, 71, 1)),
              ],
            ),
          );
        }
      },
    );
  }

  /// Return FutureBuilder to build the model selection page, using the list provided by the json
  Widget modelSelection() {
    return FutureBuilder(
        future: loadCars(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Car> _carList = [];
            for (var i = 0; i < (snapshot.data! as CarList).cars.length; i++) {
              if ((snapshot.data! as CarList).cars[i].manufacturer ==
                  selectedManufacturer) {
                _carList.add((snapshot.data! as CarList).cars[i]);
              }
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _carList.length,
                itemBuilder: (BuildContext context, int car) => InkWell(
                  onTap: () {
                    selectedModel = _carList[car].model;
                    setState(() {
                      selectedModelIndex = car;
                    });
                    Navigator.pop(context);
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(width: 3, color: Colors.white)),
                    child: SizedBox(
                      height: 70,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(_carList[car].model,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print('${snapshot.hasError}');
            return Text('Erro');
          } else {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(
                      width: 280,
                      height: 280,
                      child: Image.asset(
                          'assets/icons/ComodiWashHorizontalRender.png')),
                  CircularProgressIndicator(
                      color: Color.fromRGBO(45, 26, 71, 1)),
                ],
              ),
            );
          }
        });
  }

  /// Return FutureBuilder to build the year selection page, using the list provided by the json
  Widget yearSelection() {
    return FutureBuilder(
        future: loadYear(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2),
                ),
                itemCount: (snapshot.data! as YearList).years.length,
                itemBuilder: (BuildContext context, int year) => InkWell(
                  onTap: () {
                    selectedYear =
                        (snapshot.data! as YearList).years[year].year;
                    setState(() {
                      selectedYearModel = year;
                    });
                    Navigator.pop(context);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(width: 3, color: Colors.white)),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          (snapshot.data! as YearList).years[year].year,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            print('${snapshot.hasError}');
            return Text('Erro');
          } else {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  SizedBox(
                      width: 280,
                      height: 280,
                      child: Image.asset(
                          'assets/icons/ComodiWashHorizontalRender.png')),
                  CircularProgressIndicator(
                      color: Color.fromRGBO(45, 26, 71, 1)),
                ],
              ),
            );
          }
        });
  }

  /// Return the listview with the color options and it's icons
  Widget colorSelection() {
    List<String> colors = [
      'Amarela',
      'Azul',
      'Bege',
      'Branca',
      'Cinza',
      'Dourada',
      'Grená',
      'Laranja',
      'Marrom',
      'Prata',
      'Preta',
      'Rosa',
      'Roxa',
      'Verde',
      'Vermelha',
      'Fantasia',
    ];

    List<String> colorsIcon = [
      'assets/icons/colors/amarela.png',
      'assets/icons/colors/azul.png',
      'assets/icons/colors/bege.png',
      'assets/icons/colors/branca.png',
      'assets/icons/colors/cinza.png',
      'assets/icons/colors/dourada.png',
      'assets/icons/colors/grena.png',
      'assets/icons/colors/laranja.png',
      'assets/icons/colors/marrom.png',
      'assets/icons/colors/prata.png',
      'assets/icons/colors/preta.png',
      'assets/icons/colors/rosa.png',
      'assets/icons/colors/roxa.png',
      'assets/icons/colors/verde.png',
      'assets/icons/colors/vermelha.png',
      'assets/icons/colors/fantasia.png',
    ];

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (BuildContext context, int color) => Card(
        child: SizedBox(
          height: 70,
          child: InkWell(
              onTap: () {
                setState(() {
                  selectedColor = colors[color];
                  selectedColorIcon = colorsIcon[color];
                });
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.asset(colorsIcon[color]),
                      )
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      colors[color],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  /// Return the page body with a colunm containing all the widgets
  Widget buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildManufacturerCard(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: buildModelCard(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: buildYearCard(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: buildPlateSelector(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: buildLicensePlateField(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: buildColorSelectionCard(),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: buildConfirmButton(),
        ),
      ],
    );
  }

  /// Return a card showing the manufacturer selected by the user
  Widget buildManufacturerCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 70,
        child: InkWell(
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: manufacturerSelection());
              }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Marca',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Spacer(),
                Text(selectedManufacturer, style: TextStyle(fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Return a card with the model selected by the user
  Widget buildModelCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 70,
        child: InkWell(
          onTap: () {
            if (selectedManufacturer != 'Selecione a marca') {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: modelSelection());
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Alerta'),
                      content: Text('Por favor selecione a marca antes'),
                      actions: <Widget>[
                        TextButton(
                            onPressed: Navigator.of(context).pop,
                            child: Text(
                              'Ok',
                              style: TextStyle(
                                  color: Color.fromRGBO(45, 26, 71, 1)),
                            ))
                      ],
                    );
                  });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Modelo',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Spacer(),
                Text(selectedModel, style: TextStyle(fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Return a card with the year selected by the user
  Widget buildYearCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 70,
        child: InkWell(
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: yearSelection());
              }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Ano',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Spacer(),
                Text(selectedYear, style: TextStyle(fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Return modalButtonSheet with the plate options when clicked
  Widget buildPlateSelector() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: InkWell(
            onTap: () => {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            children: [
                              Card(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      licensePlateIcon =
                                          'assets/icons/placas/placa_padrao.png';
                                      selectedPlateType = 'Placa Padrao';
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Image.asset(
                                                  'assets/icons/placas/placa_padrao.png')),
                                        ),
                                        Spacer(),
                                        Text('Placa Padrão',
                                            style: TextStyle(fontSize: 18)),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: selectedPlateType ==
                                                  'Placa Padrao'
                                              ? Icon(Icons
                                                  .check_circle_outline_rounded)
                                              : Icon(
                                                  Icons.radio_button_unchecked),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      licensePlateIcon =
                                          'assets/icons/placas/placa_mercosul.png';
                                      selectedPlateType = 'Placa Mercosul';
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Image.asset(
                                                  'assets/icons/placas/placa_mercosul.png')),
                                        ),
                                        Spacer(),
                                        Text('Placa Mercosul',
                                            style: TextStyle(fontSize: 18)),
                                        Spacer(),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: selectedPlateType ==
                                                  'Placa Mercosul'
                                              ? Icon(Icons
                                                  .check_circle_outline_rounded)
                                              : Icon(
                                                  Icons.radio_button_unchecked),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: [
                    Text('Selecione a Placa',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Spacer(),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(licensePlateIcon),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  /// Return TextField for the license plate entry
  Widget buildLicensePlateField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        scrollPadding: EdgeInsets.only(bottom: 40),
        autocorrect: false,
        autofocus: false,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r"\s")),
          LengthLimitingTextInputFormatter(7),
          UpperCaseFormatter()
        ],
        onChanged: (text) {
          plateNumber = text;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(45, 26, 71, 1)),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelText: 'Insira a placa',
          labelStyle: TextStyle(color: Color.fromRGBO(45, 26, 71, 1)),
        ),
      ),
    );
  }

  /// Return Card with the color selected by the user
  Widget buildColorSelectionCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 70,
        child: InkWell(
          onTap: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: colorSelection());
              }),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Cor',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Spacer(),
                SizedBox(
                    width: 30,
                    height: 30,
                    child: Image.asset(selectedColorIcon)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(selectedColor, style: TextStyle(fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the confirm button to send the new car data to firebase
  /// 
  /// If the license plate is invalid or any of the information isn't selected returns a error dialog, otherwise adds the car to firebase in the user garage
  Widget buildConfirmButton() {
    garage = Provider.of<GarageRepository>(context);

    return ElevatedButton(
      onPressed: () => {
        if (checkLicensePlate(plateNumber) &&
            (selectedColor != 'Selecione a cor') && (selectedManufacturer != 'Selecione a marca') && (selectedModel != 'Selecione o modelo') && (selectedYear != 'Selecione o ano'))
          {
            garage.save(new GarageCar(
                manufacturer: selectedManufacturer,
                model: selectedModel,
                year: selectedYear,
                icon: icon,
                licensePlate: plateNumber,
                color: selectedColor)),
            Navigator.pop(context),
          }
        else
          {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Alerta'),
                    content: Text('Informações Inválidas'),
                    actions: <Widget>[
                      TextButton(
                          onPressed: Navigator.of(context).pop,
                          child: Text(
                            'Ok',
                            style:
                                TextStyle(color: Color.fromRGBO(45, 26, 71, 1)),
                          ))
                    ],
                  );
                })
          }
      },
      child: Text('Confirmar', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(300, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Color.fromRGBO(45, 26, 71, 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: 'Adicionar Carro', useTitle: true),
      resizeToAvoidBottomInset: false,
      body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                  primary: Color.fromRGBO(45, 26, 71, 1),
                  secondary: Color.fromRGBO(45, 26, 71, 1))),
          child: buildBody()),
    );
  }
}

/// Input formatter to change a text typed in a textfield to uppercase
class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue formatedValue) {
    return TextEditingValue(
        text: formatedValue.text.toUpperCase(),
        selection: formatedValue.selection);
  }
}
