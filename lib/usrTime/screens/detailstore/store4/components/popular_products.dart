import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../home/components/section_title.dart';
import 'package:http/http.dart' as http;
import '../../detailpage/Detailpage.dart';
import 'product_card.dart';

class PopularProducts extends StatefulWidget {
  const PopularProducts({Key? key}) : super(key: key);

  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  List? item;

  @override
  void initState() {
    super.initState();
    getpopProducts();
  }
  Future<void> getpopProducts() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:4000/get-pop-pro/product'),
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SectionTitle(
            title: "الاشهر",
            press: () {},
            showSeeAllButton: false,
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              item!.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ProductCard(
                  title: item![index]["Name"],
                  image: item![index]["proimage"],
                  price: item![index]["price"],
                  bgColor: index % 2 == 0 ? const Color(0xFFFEFBF9) : Color.fromARGB(255, 219, 237, 167),
                  press: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detailsproduct(item: item![index]),
                    ),
                  );
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
