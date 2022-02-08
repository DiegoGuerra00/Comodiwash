import 'package:comodiwash/services/themes/themes_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  String _selectedLanguage = 'Português';
  String _selectedCurrency = 'BRL';
  String _selectedCountry = 'Brasil';

  Widget buildThemeIndicator() {
    if (!isDark) {
      return Text('Claro', style: TextStyle(color: Colors.grey, fontSize: 16));
    } else {
      return Text('Escuro', style: TextStyle(color: Colors.grey, fontSize: 16));
    }
  }

  /// Return card with language settings
  Widget buildLanguageSettings() {
    // TODO implement english language
    return Padding(
      padding: const EdgeInsets.only(top: 14, left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Língua',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DropdownButton<String>(
                  value: _selectedLanguage,
                  underline: Container(
                    height: 0,
                  ),
                  iconSize: 0,
                  items: <String>['Português', 'Inglês'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                    });
                    print('selecionado língua: ' + _selectedLanguage);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Return card with currency settings
  Widget buildCurrencySettings() {
    // TODO implement dolar
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Moeda',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DropdownButton<String>(
                  value: _selectedCurrency,
                  underline: Container(
                    height: 0,
                  ),
                  iconSize: 0,
                  items: <String>['BRL', 'USD'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCurrency = newValue!;
                    });
                    print('selecionado moeda: ' + _selectedCurrency);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Return card with country settings
  Widget buildCountrySettings() {
    // TODO implement other countrys
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'País',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DropdownButton<String>(
                  value: _selectedCountry,
                  underline: Container(
                    height: 0,
                  ),
                  iconSize: 0,
                  items: <String>['Brasil', 'EUA'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: new Text(
                        value,
                        style: TextStyle(
                            color: Colors.grey.shade700, fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCountry = newValue!;
                    });
                    print('selecionado país: ' + _selectedCountry);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => Scaffold(
          appBar: AppBar(
            title: Text('Ajustes', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // TODO implement dark theme
            /* actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: buildThemeIndicator(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSwitch(
                  value: Theme.of(context).brightness == Brightness.dark,
                  onChanged: (value) {
                    /* print('isDark bool value:' + isDark.toString());
                    value ? theme.setDarkMode() : theme.setLightMode();
                    isDark = !isDark; */
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Função em Desenvolvimento'),
                      padding: EdgeInsets.all(8),
                    ));
                  },
                  activeColor: Color.fromRGBO(45, 26, 71, 1),
                ),
              ),
            ], */
          ),
          body: Column(
            children: [
              buildLanguageSettings(),
              buildCurrencySettings(),
              buildCountrySettings()
            ],
          )),
    );
  }
}
