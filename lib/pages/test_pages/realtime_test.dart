import 'dart:math';

import 'package:comodiwash/databases/db_realtime.dart';
import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeTest extends StatefulWidget {
  const RealtimeTest({Key? key}) : super(key: key);

  @override
  _RealtimeTestState createState() => _RealtimeTestState();
}

class _RealtimeTestState extends State<RealtimeTest> {
  final database = FirebaseDatabase.instance.ref();
  String _car = '';
  String _name = '';

  String randomUID() {
    List<String> numbers = [
      '12434',
      '6136',
      '13567156',
      '4251',
      '1249576',
      '1346756'
    ];

    return numbers[Random().nextInt(numbers.length)];
  }

  String randomCar() {
    List<String> cars = ['civic', 'gol', 'city', 'march', 'miata'];

    return cars[Random().nextInt(cars.length)];
  }

  String randomName() {
    List<String> names = [
      'arthur',
      'pedro',
      'joana',
      'ana',
      'luan',
      'fernanda'
    ];

    return names[Random().nextInt(names.length)];
  }

  void testWrite() async {
    final userRef = database.child('users');
    // final user = <String, dynamic>{'uid': 456, 'name': 'teste2'};

    await userRef
        .child(randomUID())
        .set({'car': randomCar(), 'name': randomName()});
    // await userRef.set({'uid': 456, 'nome': 'teste2'}).then((value) => print('Write sucess'));
  }

  void testRead() {
    final userRef = database.child('users');
    userRef
        .child('4251')
        .child('car')
        .onValue
        .listen((DatabaseEvent event) {
      setState(() {
        _car = event.snapshot.value as String;
      });
      print(event.snapshot.value);
    });

    userRef
        .child('4251')
        .child('name')
        .onValue
        .listen((DatabaseEvent event) {
      setState(() {
        _name = event.snapshot.value as String;
      });
      print(event.snapshot.value);
    });
  }

  void testUpdate() {
    final userRef = database.child('users');

    userRef.child('4251').update({'car': 'impala'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: 'Database Test', useTitle: true),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () => testWrite(), child: Text('Write')),
            ElevatedButton(onPressed: () => testRead(), child: Text('Read')),
            ElevatedButton(
                onPressed: () => testUpdate(), child: Text('Update')),
            Center(
              child: Text('Nome: $_name Carro: $_car'),
            )
          ],
        ),
      ),
    );
  }
}
