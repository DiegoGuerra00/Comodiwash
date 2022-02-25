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
  // late FirebaseDatabase db = DBRealtime.get();
  DatabaseReference ref = FirebaseDatabase.instance.ref("users/");

  void testWrite() async {
    await ref.set({'uid': 123, 'servico': 'polimento'});
  }

  void testRead() async {
    ref.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });
  }

  void testUpdate() {
    ref.update({
      '123/uid': 1234
    });
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
            ElevatedButton(onPressed: () => testUpdate(), child: Text('Update')),
          ],
        ),
      ),
    );
  }
}
