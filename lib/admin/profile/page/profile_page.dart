import 'package:flutter/material.dart';
import '../model/user.dart';
import '../../../userPro/utils/user_preferences.dart';
import '../../pages/dashboard/widget/header_widget.dart';
import '../widget/addminButoon.dart';
import '../widget/appbar_widget.dart';
import '../widget/button_widget.dart';
import '../widget/numbers_widget.dart';
import '../widget/profile_widget.dart';

class ProfilePagead extends StatefulWidget {
  @override
  _ProfilePageStatead createState() => _ProfilePageStatead();
}

class _ProfilePageStatead extends State<ProfilePagead> {
  final String pageTitle = 'الملف الشخصي';

  late User user; // Define user variable

  @override
  void initState() {
    super.initState();
    loadUser(); // Load the user data when the widget initializes
  }

  void loadUser() async {
    user = await UserPreferences.getUser(); // Use await to get the user
    setState(() {}); // Trigger a rebuild after getting the user data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeaderWidget(title: pageTitle),
                  const SizedBox(height: 24),
                  ProfileWidget(
                    imagePath: user.imagePath, // Use user data
                    onClicked: () async {},
                  ),
                  const SizedBox(height: 24),
                  buildName(user), // Use user data
                  const SizedBox(height: 24),
                  Center(child: buildUpgradeButton()),
                  const SizedBox(height: 24),
                  NumbersWidget(),
                  const SizedBox(height: 35),
                  ProjectsView(
                    key: UniqueKey(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'تسجيل الخروج',
        onClicked: () {
          // Implement your log out logic here
          // For example, you can clear user preferences and navigate to the login screen.
        },
      );
}
