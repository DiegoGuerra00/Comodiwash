import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:flutter/material.dart';

class EngineChecklistPage extends StatefulWidget {
  const EngineChecklistPage({Key? key}) : super(key: key);

  @override
  _EngineChecklistPageState createState() => _EngineChecklistPageState();
}

class _EngineChecklistPageState extends State<EngineChecklistPage> {
  double height = 85;
  double circleRadiusExt = 13;
  final titleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  // TODO implement realtime database to get the bellow infos in realtime
  int oilLevel = 1; //0 if good, 1 if medium, 2 if bad
  int coolantLevel = 0; //0 if good, 1 if medium, 2 if bad
  int brakesLevel = 1; //0 if good, 1 if medium, 2 if bad
  int steeringLevel = 3; //0 if good, 1 if medium, 2 if bad
  int wiperLevel = 2; //0 if good, 1 if medium, 2 if bad
  Color oilAvatarColor = Colors.grey.shade300;
  Color coolantAvatarColor = Colors.grey.shade300;
  Color brakesAvatarColor = Colors.grey.shade300;
  Color steeringAvatarColors = Colors.grey.shade300;
  Color wiperAvatarColor = Colors.grey.shade300;

  // TODO remake all text messages for the items

  /// Return the text to be showed to the user based on the oilLevel state
  ///
  /// @param _oilLevel the oil level stored in the firebase realtime database
  Text getOiltext(int _oilLevel) {
    if (_oilLevel == 0) {
      setState(() {
        oilAvatarColor = Colors.green;
      });
      return Text(
        'O óleo está no nível',
        style: TextStyle(fontSize: 18),
      );
    } else if (_oilLevel == 1) {
      setState(() {
        oilAvatarColor = Colors.yellow;
      });
      return Text(
        'O óleo está abaixo do nível',
        style: TextStyle(fontSize: 18),
      );
    } else {
      setState(() {
        oilAvatarColor = Colors.red;
      });
      return Text(
        'Sem óleo',
        style: TextStyle(fontSize: 18),
      );
    }
  }

  /// Return the text to be showed to the user based on the coolantLevel state
  ///
  /// @param _coolantLevel The coolant level stored in the firebase realtime database
  Text getCoolantText(int _coolantLevel) {
    if (_coolantLevel == 0) {
      setState(() {
        coolantAvatarColor = Colors.green;
      });
      return Text(
        'O radiador está no nível',
        style: TextStyle(fontSize: 18),
      );
    } else if (_coolantLevel == 1) {
      setState(() {
        coolantAvatarColor = Colors.yellow;
      });
      return Text(
        'O radiador está abaixo do nível',
        style: TextStyle(fontSize: 18),
      );
    } else {
      setState(() {
        coolantAvatarColor = Colors.red;
      });
      return Text(
        'Sem fluído',
        style: TextStyle(fontSize: 18),
      );
    }
  }

  /// Return the text to be showed to the user based on the brakesLevel state
  ///
  /// @param _brakesLevel The brake fluid level stored in the firebase realtime database
  Text getBrakesText(int _brakesLevel) {
    if (_brakesLevel == 0) {
      setState(() {
        brakesAvatarColor = Colors.green;
      });
      return Text(
        'O fluído está no nível',
        style: TextStyle(fontSize: 18),
      );
    } else if (_brakesLevel == 1) {
      setState(() {
        brakesAvatarColor = Colors.yellow;
      });
      return Text(
        'Está abaixo do nível',
        style: TextStyle(fontSize: 18),
      );
    } else if(_brakesLevel == 2) {
      setState(() {
        brakesAvatarColor = Colors.red;
      });
      return Text(
        'Sem fluído',
        style: TextStyle(fontSize: 18),
      );
    } else {
      return Text(
        'Incapaz de verificar',
        style: TextStyle(fontSize: 18),
      );
    }
  }

  /// Return the text to be showed to the user based on the steeringLevel state
  ///
  /// @param _steeringLevel The steering fluid level stored in the firebase realtime database
  Text getSteeringText(int _steeringLevel) {
    if (_steeringLevel == 0) {
      setState(() {
        steeringAvatarColors = Colors.green;
      });
      return Text(
        'Está no nível',
        style: TextStyle(fontSize: 18),
      );
    } else if (_steeringLevel == 1) {
      setState(() {
        steeringAvatarColors = Colors.yellow;
      });
      return Text(
        'Está abaixo do nível',
        style: TextStyle(fontSize: 18),
      );
    } else if(_steeringLevel == 2) {
      setState(() {
        steeringAvatarColors = Colors.red;
      });
      return Text(
        'Sem fluído',
        style: TextStyle(fontSize: 18),
      );
    } else {
      return Text(
        'Incapaz de verificar',
        style: TextStyle(fontSize: 18),
      );
    }
  }

  /// Return the text to be showed to the user based on the wiperLevel state
  ///
  /// @param _brakesLEvel The wiper fluid level stored in the firebase realtime database
  Text getWiperText(int _wiperLevel) {
    if (_wiperLevel == 0) {
      setState(() {
        wiperAvatarColor = Colors.green;
      });
      return Text(
        'Está no nível',
        style: TextStyle(fontSize: 18),
      );
    } else if (_wiperLevel == 1) {
      setState(() {
        wiperAvatarColor = Colors.yellow;
      });
      return Text(
        'Está abaixo do nível',
        style: TextStyle(fontSize: 18),
      );
    } else {
      setState(() {
        wiperAvatarColor = Colors.red;
      });
      return Text(
        'Sem fluído',
        style: TextStyle(fontSize: 18),
      );
    }
  }

  Widget oilCard() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text(
                      'A medição foi baseada apenas no nível do óleo pela vareta de medição do motor'),
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
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text('Nível do'),
                        Text('Óleo', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: getOiltext(oilLevel),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: oilAvatarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget coolantCard() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text(
                      'A medição foi baseada apenas no nível do fluído de arrefecimento do recipiente de expansão, caso seu veículo não possua o recipiente expansão a medição foi realizado pela tampa do reservatório do radiador'),
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
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text('Nível do'),
                        Text('Arrefecimento', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: getCoolantText(coolantLevel),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                CircleAvatar(
                    radius: circleRadiusExt,
                    backgroundColor: coolantAvatarColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget brakesCard() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text('A medição foi baseada apenas no nível do fluído de freio no reservatório externo, caso seu veículo não possua o reservatório externo desconsidere esta medição'),
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
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text('Nível do'),
                        Text('Fluído de Freio', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: getBrakesText(brakesLevel),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: brakesAvatarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget steeringCard() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text('A medição foi baseada apenas no nível do fluído no reservatório externo, caso seu veículo não possua o reservatório externo desconsidere esta medição'),
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
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text('Nível do'),
                        Text('Fluído de Direção', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: getSteeringText(steeringLevel),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: steeringAvatarColors,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget wiperCard() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text('A medição foi baseada apenas no nível do fluído no reservatório, caso seu veículo não possua o reservatório desconsidere esta medição'),
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
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text('Nível da'),
                        Text('Água do Parabrisa', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: getWiperText(wiperLevel),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: wiperAvatarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: '', useTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            oilCard(),
            coolantCard(),
            brakesCard(),
            steeringCard(),
            wiperCard(),
          ],
        ),
      ),
    );
  }
}
