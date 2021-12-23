import 'package:comodiwash/models/checklist_card.dart';
import 'package:comodiwash/models/generic_app_bar.dart';
import 'package:flutter/material.dart';

class LightsChecklistPage extends StatefulWidget {
  const LightsChecklistPage({Key? key}) : super(key: key);

  @override
  _LightsChecklistPageState createState() => _LightsChecklistPageState();
}

class _LightsChecklistPageState extends State<LightsChecklistPage> {
  double height = 85;
  final titleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  double circleRadiusExt = 13;
  bool isFrontBanner =
      true; // true if the banner with the front of the car is on the screen, false if the rear banner is beeing shown
  int bannerIndex = 0;
  String bannerPath = 'assets/images/checklist_assets/checklist_front.png';

  // Lights info from firestore
  // TODO implement realtime database
  bool lowBeamR = true;
  bool lowBeamL = false;
  bool highBeamR = true;
  bool highBeamL = false;

  // Text shown when the card is clicked
  String lightsText =
      'Cada veículo tem um tipo de lâmpada específico, podendo ser:\n-Halógena\n-Led\n-Xenon\n-Laser\nConsulte o manual do proprietário para checar o modelo correto';

  Widget buildBody() {
    return Column(
      children: [
        carBanner(),
        lightsCards(),
      ],
    );
  }

  /// Change the banner image based on the boolean passed to the function
  void changeBanner(int bannerIndex) {
    switch (bannerIndex) {
      case 0:
        setState(() {
          bannerPath = 'assets/images/checklist_assets/checklist_front.png';
        });
        break;
      case 1:
        setState(() {
          bannerPath = 'assets/images/checklist_assets/checklist_rear.png';
        });
        break;
    }
  }

  /// Build the banner at the top that shows in realtime all fault lights
  Widget carBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [bannerBackButton(), bannerCard(), bannerForwardButton()],
    );
  }

  Widget bannerCard() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
            child: Center(
                child: Container(
              child: Image.asset(bannerPath),
            )),
          )),
    );
  }

  Widget bannerBackButton() {
    return ElevatedButton(
      onPressed: () {
        if (bannerIndex < 0) {

        } else {
          bannerIndex--;
        }

        changeBanner(bannerIndex);
      },
      child: Container(
          child: Icon(
        Icons.arrow_back_ios,
        size: 20,
      )),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Colors.grey,
          minimumSize: Size(55, 50)),
    );
  }

  Widget bannerForwardButton() {
    return ElevatedButton(
      onPressed: () {
        if (bannerIndex > 1) {

        } else {
          bannerIndex++;
        }

        changeBanner(bannerIndex);
      },
      child: Container(
          child: Icon(
        Icons.arrow_forward_ios,
        size: 20,
      )),
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          primary: Colors.grey,
          minimumSize: Size(55, 50)),
    );
  }

  /// Return column with the lighs cards
  Widget lightsCards() {
    return Column(
      children: [
        // Low beam right
        ChecklistCard(
            topText: 'Farol baixo',
            bottonText: 'Direito',
            statusDetailText: Text(''),
            descriptionText: lightsText,
            statusAvatarColor: getLowBeamRColor(lowBeamR)),
        // Low beam left
        ChecklistCard(
            topText: 'Farol baixo',
            bottonText: 'Esquerdo',
            statusDetailText: Text(''),
            descriptionText: lightsText,
            statusAvatarColor: getLowBeamLColor(lowBeamL)),
        // High beam right
        ChecklistCard(
            topText: 'Farol alto',
            bottonText: 'Direito',
            statusDetailText: Text(''),
            descriptionText: lightsText,
            statusAvatarColor: getHighBeamRColor(highBeamR)),
        // High beam left
        ChecklistCard(
            topText: 'Farol alto',
            bottonText: 'Esquerdo',
            statusDetailText: Text(''),
            descriptionText: lightsText,
            statusAvatarColor: getHighBeamLColor(highBeamL))
      ],
    );
  }

  /// Gets the avatar color based on the state of the light from firestore
  Color getLowBeamRColor(bool _lowBeamR) {
    if (_lowBeamR) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  /// Gets the avatar color based on the state of the light from firestore
  Color getLowBeamLColor(_lowbeamL) {
    if (_lowbeamL) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  /// Gets the avatar color based on the state of the light from firestore
  Color getHighBeamRColor(_highBeamR) {
    if (_highBeamR) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  /// Gets the avatar color based on the state of the light from firestore
  Color getHighBeamLColor(_highBeamL) {
    if (_highBeamL) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(title: '', useTitle: false),
      body: buildBody(),
    );
  }
}
