import 'package:flutter/material.dart';
import 'package:gp_fe/usrTime/screens/cart/cart_screen.dart';

import '../../../constants.dart';
import '../../../login/responsive.dart';
import '../../curved_navigation_bar.dart';
import '../../map/map.dart';
import '../booking/boking_screen.dart';
import '../favorite/favorite_screen.dart';
import '../stores/counter.dart';
import 'components/banner.dart';
import 'components/categories.dart';
import 'components/discount_banner.dart';
import 'components/home_header.dart';
import 'components/popular_product.dart';
import 'components/top_stores.dart';
class HomeScreenu extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: buildMobileUI(context),
      tablet: buildTabletUI(context),
      desktop: buildDesktopUI(context),
    );
  }

  Widget buildMobileUI(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              HomeHeader(),
              DiscountBanner(),
              Categories(),
              SizedBox(height: 20),
              Responsive.isDesktop(context) ? BannerSection() : MobBanner(),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: pagecolor,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: Color(0xFFB7B7B7).withOpacity(.16),
                          ),
                        ],
                      ),
                    
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Counter(
                            color: Color(0xFFFF8748),
                            number: 15,
                            title: "محل",
                          ),
                          Counter(
                            color: Color(0xFFFF4848),
                            number: 50,
                            title: "منتج",
                          ),
                          Counter(
                            color:  Color(0xFF36C12C),
                            number: 46,
                            title: "نوع",
                          ),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(height: 20),
              topstore(),
              SizedBox(height: 20),
              //PopularProducts(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Color(0xFF063970),
        child: CurvedNavigationBar(
          index: 0,
          color: Color(0xFF063970),
          buttonBackgroundColor: Color(0xFF063970),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          height: 75.0,
          items: const [
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.book, size: 30, color: Colors.white),
            Icon(Icons.add, size: 30, color: Colors.white),
            Icon(Icons.favorite, size: 30, color: Colors.white),
            Icon(Icons.shopping_cart, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomeScreenu();
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const MapPage();
                  }),
                );
                break;
              case 3:
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) {
                //     return const CartScreen();
                //   }),
                // );
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
      ),
    );
  }

  Widget buildTabletUI(BuildContext context) {
    return buildMobileUI(context);
    
  }

  Widget buildDesktopUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                      HomeHeader(),
                      DiscountBanner(),
                      Categories(),
                      Responsive.isDesktop(context) ? BannerSection() : MobBanner(),
                        Padding(
                    padding: const EdgeInsets.all(40),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: pagecolor,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: Color(0xFFB7B7B7).withOpacity(.16),
                          ),
                        ],
                      ),
                    
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Counter(
                            color: Color(0xFFFF8748),
                            number: 15,
                            title: "محل",
                          ),
                          Counter(
                            color: Color(0xFFFF4848),
                            number: 50,
                            title: "منتج",
                          ),
                          Counter(
                            color:  Color(0xFF36C12C),
                            number: 46,
                            title: "نوع",
                          ),
                        ],
                      ),
                    ),
                  ),
                      topstore(),
                      SizedBox(height: 20),
                      //PopularProducts(),
                      SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xFF063970),
              child: CurvedNavigationBar(
                index: 0,
                color: Color(0xFF063970),
                buttonBackgroundColor: Color(0xFF063970),
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                height: 75.0,
                items: const [
                  Icon(Icons.home, size: 30, color: Colors.white),
                  Icon(Icons.book, size: 30, color: Colors.white),
                  Icon(Icons.map, size: 30, color: Colors.white),
                  Icon(Icons.favorite, size: 30, color: Colors.white),
                  Icon(Icons.shopping_cart, size: 30, color: Colors.white),
                  Icon(Icons.person, size: 30, color: Colors.white),
                ],
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
                          return const bookScreen();
                        }),
                      );
                      break;
                    case 2:
                      //MapPaje
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
            ),
          ],
        ),
      ),
    );
  }
}
