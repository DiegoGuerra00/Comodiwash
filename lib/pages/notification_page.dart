import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Widget buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: InkWell(
              onTap: () => {print('notificação')},
              child: SizedBox(
                  height: 100,
                  child: Center(
                      child: Text(
                    "Nenhuma Notificação",
                    style: TextStyle(fontSize: 16),
                  ))),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
        Container(
            child: Image.asset('assets/icons/ComodiWashHorizontalRender.png')),
        Text(
          'Página em construção...',
          style: TextStyle(fontSize: 18),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
            padding: EdgeInsets.all(10),
            child: IconButton(
              icon: Icon(Icons.check_box, color: Colors.black),
              onPressed: () => {print('checkbox')},
            )),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () {
                print('limpar notificações');
              },
              child: Text(
                'Limpar',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ),
        ],
      ),
      body: buildBody(),
    );
  }
}
