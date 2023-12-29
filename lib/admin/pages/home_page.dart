import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '/admin/controllers/menu_controller.dart' as MyMenuController;
import 'package:provider/provider.dart';

import '../applecation/applection.dart';
import '../comment/comm.dart';
import '../common/app_colors.dart';
import '../common/app_responsive.dart';
import '../profile/page/profile_page.dart';
import '../reports/report.dart';
import 'dashboard/dashboard.dart';

class HomePageadmin extends StatefulWidget {
  //final token;

  const HomePageadmin({
    Key? key,
    /* required this.token*/
  }) : super(key: key);

  @override
  State<HomePageadmin> createState() => _HomePageadminState();
}

class _HomePageadminState extends State<HomePageadmin> {
  String currentPage = "Dashboard";
  //late String email;

  @override
  /*void initState() {
    super.initState();
    //if (widget.token != null) {
    //Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token!);
    //email = jwtDecodedToken['email'];
    //}
  }*/

  void changePage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyMenuController.MenuController(),
      child: Scaffold(
        drawer: SideBar(changePage: changePage),
        key:
            Provider.of<MyMenuController.MenuController>(context, listen: false)
                .scaffoldKey,
        backgroundColor: AppColor.bgSideMenu,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AppResponsive.isDesktop(context))
                Expanded(
                  child: SideBar(changePage: changePage),
                ),
              Expanded(
                flex: 4,
                child: currentPage == "Dashboard"
                    ? Dashboard()
                    : currentPage == "Profile"
                        ? ProfilePagead()
                        : currentPage == "Application"
                            ? ApplicationList()
                            : currentPage == "Reports"
                                ? ReportPage()
                                : currentPage == "Comment"
                                    ? CommentPage()
                                    : Dashboard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideBar extends StatefulWidget {
  final Function(String) changePage;

  SideBar({required this.changePage});

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
                "Admin page",
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
              press: () {
                widget.changePage(
                    "Dashboard"); // Change the current page to "Dashboard"
              },
              key: UniqueKey(),
            ),
            DrawerListTile(
              title: "Application",
              icon: "assets/menu_recruitment.png",
              press: () {
                widget.changePage(
                    "Application"); // Change the current page to "Application"
              },
              key: UniqueKey(),
            ),
            DrawerListTile(
              title: "Comment",
              icon: "assets/menu_onboarding.png",
              press: () {
                widget.changePage(
                    "Comment"); // Change the current page to "Comment"
              },
              key: UniqueKey(),
            ),
            DrawerListTile(
              title: "Reports",
              icon: "assets/menu_report.png",
              press: () {
                widget.changePage(
                    "Reports"); // Change the current page to "Reports"
              },
              key: UniqueKey(),
            ),
            DrawerListTile(
              title: "Profile",
              icon: "assets/menu_calendar.png",
              press: () {
                widget.changePage(
                    "Profile"); // Change the current page to "Profile"
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
}
