import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:flutter/material.dart';

class LightsChecklistPage extends StatefulWidget {
  const LightsChecklistPage({Key? key}) : super(key: key);

  @override
  _LightsChecklistPageState createState() => _LightsChecklistPageState();
}

class _LightsChecklistPageState extends State<LightsChecklistPage> {
  double height = 85;
  final titleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  double circleRadiusExt = 13;

  Widget buildBody() {
    return Column(
      children: [
        carBanner(),
        lightsCards(),
      ],
    );
  }

  /// Build the banner at the top that shows in realtime all fault lights
  Widget carBanner() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Container(
            child: Image.asset('assets/images/ComodiWash_horizontal.png'),
          ),
        ),
      ),
    );
  }

  Widget lightsCards() {
    return Column(
      children: [
        lightLowBeamR(),
        lightLowBeamL(),
        lightHighBeamR(),
        lightHighBeamL()
      ],
    );
  }

  /// Build the card of the right low beam
  Widget lightLowBeamR() {
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
                      'Test'),
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
                        Text('Farol baixo'),
                        Text('Direito', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the card of the left low beam
  Widget lightLowBeamL() {
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
                      'Test'),
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
                        Text('Farol baixo'),
                        Text('Direito', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the card of the right high beam
  Widget lightHighBeamR() {
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
                      'Test'),
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
                        Text('Farol baixo'),
                        Text('Direito', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the card of the left high beam
  Widget lightHighBeamL() {
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
                      'Test'),
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
                        Text('Farol baixo'),
                        Text('Direito', style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: Colors.green,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                CircleAvatar(
                  radius: circleRadiusExt,
                  backgroundColor: Colors.red,
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
      body: buildBody(),
    );
  }
}
