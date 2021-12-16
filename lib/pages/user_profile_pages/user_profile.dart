import 'package:comodiwash/models/garage_car.dart';
import 'package:comodiwash/pages/user_profile_pages/car_detail_page.dart';
import 'package:comodiwash/pages/user_profile_pages/new_car_pages/add_car_page.dart';
import 'package:comodiwash/pages/user_profile_pages/settings_page.dart';
import 'package:comodiwash/pages/user_profile_pages/support_page.dart';
import 'package:comodiwash/repositories/garage_repository.dart';
import 'package:comodiwash/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final user = FirebaseAuth.instance.currentUser!;
  late GarageRepository garage;

  /// Return a slidable model for the cars list card
  ///
  /// Does the delete car action
  Widget buildRemoveSlidable() {
    return Container(
      child: Column(
        children: [
          Spacer(),
          Container(
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          Text('Remover', style: TextStyle(color: Colors.red)),
          Spacer()
        ],
      ),
    );
  }

  /// Return a slidable model for the cars list card
  ///
  /// Does the edit car action
  Widget buildEditSlidable() {
    return Container(
      child: Column(
        children: [
          Spacer(),
          Container(
            child: Icon(
              Icons.edit,
              color: Colors.black,
            ),
          ),
          Text('Editar', style: TextStyle(color: Colors.black)),
          Spacer()
        ],
      ),
    );
  }

  /// Navigate to the detail page of a car
  ///
  /// Recieves a car object
  openCarDetail(GarageCar car) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CarDetailPage(
                  car: car,
                )));
  }

  /// Navigate to the page to add a new car
  openAddCarPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => AddCarPage()));
  }

  /// Build the top banner with safe area
  Widget buildTopBanner() {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2000)),
          child: Image.asset('assets/images/user_profile_banner.png')),
    );
  }

  /// Returns a pop up menu with the buttons to the other pages of the user section
  Widget buildPopUpMenu() {
    return PopupMenuButton(
        onSelected: (value) {
          setState(() {
            switch (value) {
              case 0:
                print('Perfil');
                break;
              case 1:
                openAddCarPage();
                break;
              case 2:
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SupportPage()));
                break;
              case 3:
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SettingsPage()));
                break;
              case 4:
                final provider =
                    Provider.of<AuthProvider>(context, listen: false);
                provider.googleLogout();
                provider.emailSignOut();
                break;
            }
          });
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        child: Icon(Icons.person),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child:
                          Text('Perfil', style: TextStyle(color: Colors.black)),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        child: Icon(Icons.add_circle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Novo Carro',
                          style: TextStyle(color: Colors.black)),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        child: Icon(Icons.support_agent),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Suporte',
                          style: TextStyle(color: Colors.black)),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        child: Icon(Icons.settings),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Ajustes',
                          style: TextStyle(color: Colors.black)),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        child: Icon(Icons.logout),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child:
                          Text('Sair', style: TextStyle(color: Colors.black)),
                    )
                  ],
                ),
              ),
            ],
        child: Container(
          width: 50,
          height: 50,
          decoration: ShapeDecoration(
            color: Color.fromRGBO(45, 26, 71, 1),
            shape: CircleBorder(),
          ),
          child: Icon(Icons.more_horiz, color: Colors.white),
        ));
  }

  /// Return a row with the user profile picture and name
  Widget buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 43,
            backgroundColor: Color.fromRGBO(45, 26, 71, 1),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.deepPurple,
              // backgroundImage: NetworkImage(user.photoURL!),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          // TODO add name
          /* Text(
            user.displayName!,
            style: TextStyle(fontSize: 19),
          ), */
          Spacer(),
          buildPopUpMenu()
        ],
      ),
    );
  }

  /// Returns a listview with the user cars based on the list from firebase
  ///
  /// If the list is empty return a Text
  Widget buildGarageListView() {
    garage = Provider.of<GarageRepository>(context);

    return Consumer<GarageRepository>(builder: (context, garage, child) {
      return garage.garageList.isEmpty
          ? Center(
              child: Text(
              'Nenhum Carro Adicionado',
              style: TextStyle(fontSize: 18),
            ))
          : ListView.builder(
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: garage.garageList.length,
              itemBuilder: (BuildContext context, int car) => Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
                child: Slidable(
                  actionPane: SlidableBehindActionPane(),
                  actionExtentRatio: 0.25,
                  secondaryActions: <Widget>[
                    SlideAction(
                        onTap: () => print('Editar'),
                        child: buildEditSlidable()),
                    SlideAction(
                      onTap: () => {
                        garage.remove(garage.garageList[car]),
                        Fluttertoast.showToast(
                          msg: 'Carro Removido',
                          toastLength: Toast.LENGTH_LONG,
                        )
                      },
                      child: buildRemoveSlidable(),
                    ),
                  ],
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                        onTap: () => openCarDetail(garage.garageList[car]),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                child: Image.asset(garage.garageList[car].icon),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      garage.garageList[car].model,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      garage.garageList[car].year,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            );
    });
  }

  /// Return the button that leads to the add car page
  Widget buildAddCarBottomButton() {
    return Center(
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                primary: Color.fromRGBO(45, 26, 71, 1), //background
                onPrimary: Colors.white,
                minimumSize: Size(150, 45)),
            onPressed: () => openAddCarPage(),
            icon: Icon(
              Icons.add_circle,
              size: 25,
            ),
            label: Text(
              "Novo Carro",
              style: TextStyle(fontSize: 16),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        buildTopBanner(),
        buildProfileInfo(),
        Expanded(
          child: buildGarageListView(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: buildAddCarBottomButton(),
        )
      ],
    ));
  }
}
