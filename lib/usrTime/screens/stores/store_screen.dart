import 'package:flutter/material.dart';
import 'package:gp_fe/usrTime/screens/favorite/favorite_screen.dart';
import '../../curved_navigation_bar.dart';
import '../../map/map.dart';
import '../booking/boking_screen.dart';
import '../butombar.dart';
import '../cart/cart_screen.dart';
import '../home/components/home_header.dart';
import '../home/home_screen.dart';
import 'caracc1.dart';
import 'carcolors.dart';
import 'carseting.dart';
import 'carshowrooms.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            HomeHeader(),
            SizedBox(height: 20),
            caracc(),
            SizedBox(height: 20),
            carseting(),
            SizedBox(height: 20),
            carshowrooms(),
            carcolors(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const HomeScreenu();
                  }),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return  bookScreen();
                  }),
                );
                break;
              case 2:
                // MapPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MapPage();
                  }),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const favScreen();
                  }),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const CartScreen();
                  }),
                );
                break;
            }
          },
        ),
    );
  }
}
