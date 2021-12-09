import 'package:comodiwash/pages/checklist_pages/checklist_main_page.dart';
import 'package:comodiwash/pages/notification_page.dart';
import 'package:comodiwash/pages/place_holder_page.dart';
import 'package:comodiwash/pages/store_pages/store_page.dart';
import 'package:comodiwash/pages/user_profile_pages/user_profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: currentPage);
  }

  setcurrentPage(page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          controller: pc,
          children: [
            StorePage(),
            // PlaceHolderPage(),
            CheckListMainPage(),
            NotificationPage(),
            UserProfile(),
          ],
          onPageChanged: setcurrentPage,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: currentPage,
          height: 60,
          backgroundColor: Colors.white24,
          buttonBackgroundColor: Color.fromRGBO(45, 26, 71, 1),
          color: Color.fromRGBO(45, 26, 71, 1),
          onTap: (index) {
            setState(() {
              currentPage = index;
              pc.animateToPage(index, duration: Duration(milliseconds: 400), curve: Curves.ease);
            });
          },
          items: <Widget>[
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.checklist, size: 30, color: Colors.white),
            Icon(Icons.notifications, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white)
          ],
        ),

        
      );
}
