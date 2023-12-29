import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp_fe/usrTime/screens/detailstore/store2/store2.dart';
import '../../../login/responsive.dart';
import '../../models/Product.dart';
import 'package:http/http.dart' as http;

import '../home/components/home_header.dart';
import '../home/components/section_title.dart';
import '../home/components/store_card.dart';
import 'storecards.dart';


class carseting extends StatefulWidget {
  const carseting({Key? key}) : super(key: key);

  @override
  _carsetingState createState() => _carsetingState();
}

class _carsetingState extends State<carseting> {
  List? item;
  late bool isnew;

  @override
  void initState() {
    super.initState();
    getstore();
  }

  Future<void> getstore() async {
    try {
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/getsametypecompany/Car%20Seting'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          item = jsonResponse['data'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "تجليس السيارات",
            press: () {
            },
            showSeeAllButton: false,
            
          ),
        ),
            SizedBox(height: 25,),
         GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Responsive.isDesktop(context)?2:1, 
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            childAspectRatio: 3, 
          ),
          itemCount: item?.length ?? 0,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var product = item![index];
            return Storse(
              title: item![index]['Name'].toString(),
              image: item![index]['comimag'],
              location: item![index]['location'].toString(),
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => store2(item: item![index]),
                  ),
                );
              },
               cardColor: index % 2 == 0 ? Color.fromARGB(255, 210, 242, 238) : Color.fromARGB(255, 108, 138, 155),
            );
          },
        ),
      ],
    );
  }
}
