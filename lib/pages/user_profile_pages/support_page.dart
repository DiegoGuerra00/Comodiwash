import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:comodiwash/pages/user_profile_pages/support_pages/about_page.dart';
import 'package:comodiwash/pages/user_profile_pages/support_pages/contact_page.dart';
import 'package:comodiwash/pages/user_profile_pages/support_pages/privacy_policy_page.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  /// Build the body with the cards for the contacts, info and privacy infos
  Widget buildSupoortBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ContactPage())),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Contato',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AboutPage())),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Sobre',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => PrivacyPolicyPage())),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Política de Privacidade',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: 'Suporte', useTitle: true,),
      body: buildSupoortBody(),
    );
  }
}
