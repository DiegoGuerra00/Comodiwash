import 'package:comodiwash/pages/home_page.dart';
import 'package:comodiwash/services/themes/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void introEnd(context) {
    StorageManager.saveData('viewIntro', 'true');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      onDone: () => introEnd(context),
      pages: [
        PageViewModel(
            title: 'Primeira Página',
            body: 'Primeira Página',
            image: Image.asset('assets/images/comodiwash-logo-gif.gif')),
        PageViewModel(
            title: 'Segunda Página',
            body: 'Segunda Página',
            image: Image.asset('assets/images/comodiwash-logo-gif.gif')),
      ],
      skip: const Text('Skip'),
      next: const Text(
        'Próximo',
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Color.fromRGBO(45, 26, 71, 1)),
      ),
      done: const Text('Finalizar',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(45, 26, 71, 1))),
      curve: Curves.fastLinearToSlowEaseIn,
      dotsDecorator: DotsDecorator(activeColor: Color.fromRGBO(45, 26, 71, 1)),
    );
  }
}
