import 'package:flutter/material.dart';

 /// Build a generic card with the info for the checklist pages
 /// 
 /// @param topText String with the text in the top left of the card, with the description of what is that card
 /// @param bottonText String that goes bellow the topText, complementing the description of the card
 /// @param statusDetailText Text Widget with the text of the status of that checklist item[
 /// @param descriptionText String with the text shown when the card is clicked
 /// @param statusAvatarColor Color of the circle avatar, demonstrating the status of that item
class ChecklistCard extends StatelessWidget {
  String topText;
  String bottonText;
  Text statusDetailText;
  String descriptionText;
  Color statusAvatarColor;

  ChecklistCard(
      {Key? key,
      required this.topText,
      required this.bottonText,
      required this.statusDetailText,
      required this.descriptionText,
      required this.statusAvatarColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = 85;
    final double circleRadius = 13;
    final titleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Aviso'),
                  content: Text(descriptionText),
                  actions: <Widget>[
                    TextButton(
                        onPressed: Navigator.of(context).pop,
                        child: Text(
                          'Ok',
                          style:
                              TextStyle(color: Color.fromRGBO(45, 26, 71, 1)),
                        ))
                  ],
                );
              });
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Text(topText),
                        Text(bottonText, style: titleTextStyle),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: statusDetailText,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.01,
                ),
                CircleAvatar(
                  radius: circleRadius,
                  backgroundColor: statusAvatarColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
