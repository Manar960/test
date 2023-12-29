import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp_fe/login/responsive.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'ordercards.dart';
import 'paymint.dart';



class orders extends StatefulWidget {
  const orders({Key? key, required this.paymentMethod}) : super(key: key);
final String paymentMethod;
  @override
  _ordersState createState() => _ordersState();
}

class _ordersState extends State<orders> {
  List? item;

  @override
  void initState() {
    super.initState();
    getOrdar();
  }
  
  Future<void> getOrdar() async {
    try {
      var response = await http.get(
        Uri.parse('https://gp-back-gp.onrender.com/getOrdar'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          item = jsonResponse['orders'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }
 
  Future<void> deleteOrdar(String OrderCode,String companyName) async {
    final url = 'https://gp-back-gp.onrender.com/order/delete-ordar';

    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'OrderCode': OrderCode, 
        'companyName':companyName
      }),
    );
  }
  Future<void> removeFromCart(String CartCode) async {
    final url = 'https://gp-back-gp.onrender.com/cart/order-remove';

    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'CartCode': CartCode,
      }),
    );
  }
  void showcards(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 350,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
           
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                LottieBuilder.asset(
                    "assets/car1.json",              
                    width: 150,
                    height: 150,
                    fit: BoxFit.fill,
                    repeat: false,
                    animate: true,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'طلبك جاهز يرجى الاستلام في اقرب وقت',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

 @override
Widget build(BuildContext context) {
  getOrdar();
  return Scaffold(
    appBar: AppBar(
      title: Text('طلباتك'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context) ? 2 : 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 3,
            ),
            itemCount: item?.length ?? 0,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var product = item![index];
              return orderscards(
                press2:(){
                    deleteOrdar(item![index]['OrderCode'],item![index]['companyName']);
                    removeFromCart(item![index]['CartCode']);
                } ,
                title: item![index]['companyName'].toString(),
                image: "assets/images/Magical_World.png",
                price: item![index]['totalPrice'].toString(),
                press: () {
                 
                  if(item![index]['waydelivary'].toString()=="store"){
                   showcards(context) ;    
                   deleteOrdar(item![index]['OrderCode'],item![index]['companyName']);
                   removeFromCart(item![index]['CartCode']);
                  }
                  else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const paymentMethod1(),
                    ),
                  );
                  }

                 
                },
                cardColor: index % 2 == 0
                    ? const Color(0xFFF3F8FF)
                    : const Color(0xFFF3F8FF),
              );
            },
          ),
        ],
      ),
    ),
  );
}

}

