import 'package:comodiwash/models/checklist_card.dart';
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
  // Store the status of the items based on firebase database
  // TODO implement realtime database to get the bellow infos in realtime
  int oilLevel = 1; //0 if good, 1 if medium, 2 if bad
  int coolantLevel = 0; //0 if good, 1 if medium, 2 if bad
  int brakesLevel = 1; //0 if good, 1 if medium, 2 if bad
  int steeringLevel = 3; //0 if good, 1 if medium, 2 if bad
  int wiperLevel = 2; //0 if good, 1 if medium, 2 if bad
  // Default color of the status avatars
  Color oilAvatarColor = Colors.grey.shade300;
  Color coolantAvatarColor = Colors.grey.shade300;
  Color brakesAvatarColor = Colors.grey.shade300;
  Color steeringAvatarColor = Colors.grey.shade300;
  Color wiperAvatarColor = Colors.grey.shade300;

  // Text of the destails of the items that appear when the card is clicked
  String oilDescription =
      'A medição foi baseada apenas no nível do óleo pela vareta de medição do motor';
  String coolantDescrition =
      'A medição foi baseada apenas no nível do fluído de arrefecimento do recipiente de expansão, caso seu veículo não possua o recipiente expansão a medição foi realizado pela tampa do reservatório do radiador';
  String brakesDescription =
      'A medição foi baseada apenas no nível do fluído de freio no reservatório externo, caso seu veículo não possua o reservatório externo desconsidere esta medição';
  String steeringDescription =
      'A medição foi baseada apenas no nível do fluído no reservatório externo, caso seu veículo não possua o reservatório externo desconsidere esta medição';
  String wiperDescription =
      'A medição foi baseada apenas no nível do fluído no reservatório, caso seu veículo não possua o reservatório desconsidere esta medição';

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
    } else if (_brakesLevel == 2) {
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
        steeringAvatarColor = Colors.green;
      });
      return Text(
        'Está no nível',
        style: TextStyle(fontSize: 18),
      );
    } else if (_steeringLevel == 1) {
      setState(() {
        steeringAvatarColor = Colors.yellow;
      });
      return Text(
        'Está abaixo do nível',
        style: TextStyle(fontSize: 18),
      );
    } else if (_steeringLevel == 2) {
      setState(() {
        steeringAvatarColor = Colors.red;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: '', useTitle: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ChecklistCard(
                topText: 'Nível do',
                bottonText: 'Óleo',
                statusDetailText: getOiltext(oilLevel),
                descriptionText: oilDescription,
                statusAvatarColor: oilAvatarColor),
            ChecklistCard(
                topText: 'Nível do',
                bottonText: 'Arrefecimento',
                statusDetailText: getCoolantText(coolantLevel),
                descriptionText: coolantDescrition,
                statusAvatarColor: coolantAvatarColor),
            ChecklistCard(
                topText: 'Nível do',
                bottonText: 'Fluído de Freio',
                statusDetailText: getBrakesText(brakesLevel),
                descriptionText: brakesDescription,
                statusAvatarColor: brakesAvatarColor),
            ChecklistCard(
                topText: 'Nível do',
                bottonText: 'Fluído de Direção',
                statusDetailText: getSteeringText(steeringLevel),
                descriptionText: steeringDescription,
                statusAvatarColor: steeringAvatarColor),
            ChecklistCard(
                topText: 'Nível da',
                bottonText: 'Água do Parabrisa',
                statusDetailText: getWiperText(wiperLevel),
                descriptionText: wiperDescription,
                statusAvatarColor: wiperAvatarColor),
          ],
        ),
      ),
    );
  }
}
