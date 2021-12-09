import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  Widget aboutText() {
    return Text(
      '2021.Copyright',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey.shade700
      ),
    );
  }

  Widget buildAboutBody() {
    return SizedBox(height: MediaQuery.of(context).size.height,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: aboutText()
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: 'Sobre', useTitle: true),
      body: buildAboutBody(),
    );
  }
}
