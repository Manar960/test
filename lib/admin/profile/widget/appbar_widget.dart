import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/home_page.dart';

AppBar buildAppBar(BuildContext context) {
  const icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        icon: const Icon(icon),
        onPressed: () {
          Navigator.of(context).pop(); // أغلق القائمة الجانبية
          //Navigator.of(context).push(MaterialPageRoute(
          // builder: (context) => HomePage(),
          //));
        },
      ),
    ],
  );
}
