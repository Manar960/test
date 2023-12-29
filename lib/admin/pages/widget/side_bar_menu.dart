/*import 'package:flutter/material.dart';

import '../../application/app.dart';
import '../../application/app_page.dart';

import '../../comment/comm.dart';
import '../../common/app_colors.dart';
import '../../profile/page/profile_page.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: AppColor.bgSideMenu,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                "Admin page ",
                style: TextStyle(
                  color: AppColor.yellow,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DrawerListTile(
              title: "Home",
              icon: "assets/menu_home.png",
              press: () {},
              key: UniqueKey(),
            ),
            DrawerListTile(
              title: "Application",
              icon: "assets/menu_recruitment.png",
              press: () {},
              key: UniqueKey(),
            ),
            DrawerListTile(
              title: "Comment",
              icon: "assets/menu_onboarding.png",
              press: () {
                Navigator.pop(context); // أغلق القائمة الجانبية
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CommentPage(),
                ));
              },
              key: UniqueKey(),
            ),
            DrawerListTile(
              title: "Reports",
              icon: "assets/menu_report.png",
              press: () {},
              key: UniqueKey(),
            ),
            DrawerListTile(
              title: "Profile",
              icon: "assets/menu_calendar.png",
              press: () {
                // أغلق القائمة الجانبية
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ));
              },
              key: UniqueKey(),
            ),
            Spacer(),
            Image.asset("assets/sidebar_image.png")
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, icon;
  final VoidCallback press;

  const DrawerListTile(
      {required Key key,
      required this.title,
      required this.icon,
      required this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        icon,
        color: AppColor.black,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: AppColor.black),
      ),
    );
  }
}*/
