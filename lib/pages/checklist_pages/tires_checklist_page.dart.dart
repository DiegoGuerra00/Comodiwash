import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:flutter/material.dart';

class TiresChecklistPage extends StatefulWidget {
  const TiresChecklistPage({Key? key}) : super(key: key);

  @override
  _TiresChecklistPageState createState() => _TiresChecklistPageState();
}

class _TiresChecklistPageState extends State<TiresChecklistPage> {
  double height = 200;
  double circleRadiusExt = 13;
  final titleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  String dialogtext = 'A medição do pneu foi realizada através de um paquímetro de profundidade onde a tolerancia máxima aceitável para os pneus é X'; //TODO add X value
  bool tireFL = true;
  bool tireFR = true;
  bool tireRL = true;
  bool tireRR = true;
  Color tireFLAvatarColor = Colors.grey.shade300;
  Color tireFRAvatarColor = Colors.grey.shade300;
  Color tireRLAvatarColor = Colors.grey.shade300;
  Color tireRRAvatarColor = Colors.grey.shade300;

  Widget buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [buildFLCard(), buildFRCard()],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [buildRLCard(), buildRRCard()],
        ),
        Spacer()
      ],
    );
  }

  /// Build the card to display the info about the front left tire
  Widget buildFLCard() {
    getFLTireWear(tireFL);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text(dialogtext),
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
              });
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      // child: Icon(Icons.ac_unit),
                      child: Image.asset('assets/icons/checklist/tires_checklist/tire_icon.png')
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text('Dianteiro'),
                            Text('Esquerdo', style: titleTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: tireFLAvatarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the card to display the info about the front right tire
  Widget buildFRCard() {
    getFRTireWear(tireFR);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text(dialogtext),
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
              });
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Image.asset('assets/icons/checklist/tires_checklist/tire_icon.png')
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text('Dianteiro'),
                            Text('Direito', style: titleTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: tireFLAvatarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the card to display the info about the rear left tire
  Widget buildRLCard() {
    getRLTireWear(tireRL);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text(dialogtext),
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
              });
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Image.asset('assets/icons/checklist/tires_checklist/tire_icon.png')
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text('Traseiro'),
                            Text('Esquerdo', style: titleTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: tireFLAvatarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the card to display the info about the rear right tire
  Widget buildRRCard() {
    getRRTireWear(tireRR);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text(dialogtext),
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
              });
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      child: Image.asset('assets/icons/checklist/tires_checklist/tire_icon.png')
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Text('Traseiro'),
                            Text('Direito', style: titleTextStyle),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: tireFLAvatarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Returns the text to be shown to the user based on the bool passed
  ///
  /// @param _tireFL if true tire is good, else it's bad
  void getFLTireWear(_tireFL) {
    if (_tireFL) {
      setState(() {
        tireFLAvatarColor = Colors.green;
      });
    } else {
      setState(() {
        tireFLAvatarColor = Colors.red;
      });
    }
  }

  /// Returns the text to be shown to the user based on the bool passed
  ///
  /// @param _tireFR if true tire is good, else it's bad
  void getFRTireWear(_tireFR) {
    if (_tireFR) {
      setState(() {
        tireFRAvatarColor = Colors.green;
      });
    } else {
      setState(() {
        tireFRAvatarColor = Colors.red;
      });
    }
  }

  /// Returns the text to be shown to the user based on the bool passed
  ///
  /// @param _tireRL if true tire is good, else it's bad
  void getRLTireWear(_tireRL) {
    if (_tireRL) {
      setState(() {
        tireRLAvatarColor = Colors.green;
      });
    } else {
      setState(() {
        tireRLAvatarColor = Colors.red;
      });
    }
  }

  /// Returns the text to be shown to the user based on the bool passed
  ///
  /// @param _tireRR if true tire is good, else it's bad
  void getRRTireWear(_tireRR) {
    if (_tireRR) {
      setState(() {
        tireRRAvatarColor = Colors.green;
      });
    } else {
      setState(() {
        tireRRAvatarColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: '', useTitle: false),
      body: buildBody(),
    );
  }
}
