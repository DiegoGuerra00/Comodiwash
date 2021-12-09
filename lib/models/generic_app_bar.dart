import 'package:flutter/material.dart';

/// Generic app bar that can be used with or without title and have a return button
class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  String title;
  bool useTitle = true;

  GenericAppBar({Key? key, required this.title, required this.useTitle})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    if (useTitle) {
      return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title, style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      );
    } 
  }
}
