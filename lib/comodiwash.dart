import 'package:comodiwash/pages/user_profile_pages/new_car_pages/add_car_page.dart';
import 'package:comodiwash/pages/user_profile_pages/profile_page.dart';
import 'package:comodiwash/pages/user_profile_pages/settings_page.dart';
import 'package:comodiwash/repositories/garage_repository.dart';
import 'package:comodiwash/repositories/products_repository.dart';
import 'package:comodiwash/repositories/services_repository.dart';
import 'package:comodiwash/repositories/shopping_cart_repository.dart';
import 'package:comodiwash/services/login_handle.dart';
import 'package:comodiwash/services/auth_service.dart';
import 'package:comodiwash/services/themes/themes_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';

class ComodiWash extends StatefulWidget {
  const ComodiWash({Key? key}) : super(key: key);

  @override
  _ComodiWashState createState() => _ComodiWashState();
}

class _ComodiWashState extends State<ComodiWash> {
  final quickActions = QuickActions();
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  final ThemeData theme = ThemeData();

  @override
  void initState() {
    super.initState();

    quickActions.setShortcutItems([
      ShortcutItem(
          type: 'newCar',
          localizedTitle: 'Novo Carro',
          icon: 'add_quick_action'),
      ShortcutItem(
          type: 'config',
          localizedTitle: 'Configurações',
          icon: 'settings_quick_action'),
      ShortcutItem(
          type: 'profile',
          localizedTitle: 'Perfil',
          icon: 'profile_quick_action')
    ]);

    quickActions.initialize((type) {
      if (type == 'newCar') {
        navigatorKey.currentState!.pushNamed('/new_car');
      } else if (type == 'config') {
        navigatorKey.currentState!.pushNamed('/config');
      } else if (type == 'profile') {
        navigatorKey.currentState!.pushNamed('/profile');
      }
    });
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(),
            ),
            ChangeNotifierProvider<ThemeNotifier>(
                create: (_) => ThemeNotifier()
            ),
            ChangeNotifierProvider(
                create: (context) => GarageRepository(auth: context.read<AuthProvider>())
            ),
            ChangeNotifierProvider(
              create: (context) => ServicesRepository() 
            ),
            ChangeNotifierProvider(
              create: (context) => ProductsRepository() 
            ), ChangeNotifierProvider(create: (context) => ShoppingCartRepository())
          ],
          child: MaterialApp(
            theme: theme.copyWith(
              backgroundColor: Colors.white,
              colorScheme: theme.colorScheme.copyWith(secondary: Color.fromRGBO(45, 26, 71, 1))
            ),
            debugShowCheckedModeBanner: false,
            home: LoginHandle(),
            navigatorKey: navigatorKey,
            routes: {
              '/new_car': (context) => AddCarPage(),
              '/config': (context) => SettingsPage(),
              '/profile': (context) => ProfilePage(),
            },
          ));
}
