import 'package:flutter/material.dart';

class PlaceHolderPage extends StatelessWidget {
  const PlaceHolderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          Container(
            child: Image.asset('assets/images/comodiwash-logo-gif.gif')
          ),
          Text(
            'Página em construção...',
            style: TextStyle(fontSize: 18),  
          )
        ],
      ),
    );
  }
}
