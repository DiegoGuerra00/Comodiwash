import 'package:comodiwash/pages/checklist_pages/engine_checklist_page.dart';
import 'package:comodiwash/pages/checklist_pages/tires_checklist_page.dart.dart';
import 'package:flutter/material.dart';

class CheckListMainPage extends StatefulWidget {
  const CheckListMainPage({Key? key}) : super(key: key);

  @override
  _CheckListMainPageState createState() => _CheckListMainPageState();
}

class _CheckListMainPageState extends State<CheckListMainPage>
    with TickerProviderStateMixin {
  bool hasService = true;
  bool checklistSelected = true;
  late AnimationController controller;
  double buttonHeight = 350;
  double buttonWidth = 60;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      // duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    // controller.repeat();
    super.initState();
  }

  Widget buildServiceBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 14, right: 14, bottom: 8),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Serviço',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Column(
                  children: [
                    Text('Modelo',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(45, 26, 71, 1))),
                    Text('Marca',
                        style: TextStyle(
                            fontSize: 14, color: Color.fromRGBO(45, 26, 71, 1)))
                  ],
                )
              ],
            ),
            buildSumaryCard(),
            SizedBox(
              height: 10,
            ),
            buildOptionButtons(),
            SizedBox(
              height: 10,
            ),
            changeChecklistRecord(),
          ],
        ),
      ),
    );
  }

  /// Returns a Card to show the sumary of the active service
  ///
  /// If no services are active then show a empty Card with a message
  Widget buildSumaryCard() {
    // TODO add list with all services actives at the time
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Nome do Serviço',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromRGBO(45, 26, 71, 1))),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Text('30%',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(45, 26, 71, 1))),
                    Spacer(),
                    SizedBox(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: LinearProgressIndicator(
                        value: controller.value,
                        backgroundColor: Color.fromRGBO(45, 26, 71, 0.7),
                        color: Color.fromRGBO(45, 26, 71, 1),
                      ),
                    )
                  ],
                ),
                Spacer(),
                Text('00/00/0000')
              ],
            ),
          )),
    );
  }

  /// Returns a row with the buttons to switch to checklist options or video recording
  Widget buildOptionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                primary: checklistSelected
                    ? Color.fromRGBO(45, 26, 71, 1)
                    : Colors.white,
                onPrimary: checklistSelected ? Colors.white : Colors.black,
                minimumSize: Size(150, 45)),
            onPressed: () {
              print('Checklist');
              setState(() {
                checklistSelected = !checklistSelected;
              });
            },
            child: Text(
              'Checklist',
              style: TextStyle(fontSize: 16),
            )),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                primary: checklistSelected
                    ? Colors.white
                    : Color.fromRGBO(45, 26, 71, 1),
                onPrimary: checklistSelected ? Colors.black : Colors.white,
                minimumSize: Size(150, 45)),
            onPressed: () {
              setState(() {
                checklistSelected = !checklistSelected;
              });
              print('Gravação');
            },
            child: Text('Gravação', style: TextStyle(fontSize: 16))),
      ],
    );
  }

  /// Returns a colunm with the buttons to lead to every individual checklist page
  Widget buildChecklistOptions() {
    return Column(
      children: [
        // engine button
        engineButton(),
        SizedBox(
          height: 10,
        ),
        // lights button
        lightsButton(),
        SizedBox(
          height: 10,
        ),
        // tires button
        tiresButton(),
        SizedBox(
          height: 10,
        ),
        // acessories button
        acessoriesButton(),
        SizedBox(
          height: 10,
        ),
        // info button
        infoButton()
      ],
    );
  }

  /// Returns an elevated button that leads to the engine checklist page
  Widget engineButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Colors.white,
          onPrimary: Colors.black,
          minimumSize: Size(buttonHeight, buttonWidth)),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => EngineChecklistPage()));
      },
      label: Text(
        'Motor                                                                  ',
        textScaleFactor: 1.3,
      ),
      icon: ImageIcon(AssetImage('assets/icons/checklist/motor.png')),
    );
  }

  /// Returns an elevated button that leads to the lights checklist page
  Widget lightsButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Colors.white,
          onPrimary: Colors.black,
          minimumSize: Size(buttonHeight, buttonWidth)),
      onPressed: () {},
      label: Text(
        'Iluminação                                                                  ',
        textScaleFactor: 1.3,
      ),
      icon: ImageIcon(AssetImage('assets/icons/checklist/luzes.png')),
    );
  }

  /// Returns an elevated button that leads to the tires checklist page
  Widget tiresButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Colors.white,
          onPrimary: Colors.black,
          minimumSize: Size(buttonHeight, buttonWidth)),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => TiresChecklistPage()));
      },
      label: Text(
        'Pneus                                                                  ',
        textScaleFactor: 1.3,
      ),
      icon: ImageIcon(AssetImage('assets/icons/checklist/pneus.png')),
    );
  }

  /// Returns an elevated button that leads to the acessories checklist page
  Widget acessoriesButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Colors.white,
          onPrimary: Colors.black,
          minimumSize: Size(buttonHeight, buttonWidth)),
      onPressed: () {},
      label: Text(
        'Acessórios                                                                  ',
        textScaleFactor: 1.3,
      ),
      icon: ImageIcon(AssetImage('assets/icons/checklist/acessorios.png')),
    );
  }

  /// Returns an elevated button that leads to the info checklist page
  Widget infoButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Colors.white,
          onPrimary: Colors.black,
          minimumSize: Size(buttonHeight, buttonWidth)),
      onPressed: () {},
      label: Text(
        'Informações Gerais                                                                  ',
        textScaleFactor: 1.3,
      ),
      icon: ImageIcon(AssetImage('assets/icons/checklist/informacoes.png')),
    );
  }

  /// Returns a box with the vidoe from the service after it's done
  Widget buildRecordWidget() {
    return SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: (Container()),
        ));
  }

  /// Switch to checklist options or recording
  /// 
  /// If passed parameter is true switch to checklist options, if false to recording
  Widget changeChecklistRecord() {
    if (checklistSelected) {
      return buildChecklistOptions();
    } else {
      return buildRecordWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildServiceBody());
  }
}
