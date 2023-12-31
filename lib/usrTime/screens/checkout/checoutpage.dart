import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gp_fe/usrTime/screens/checkout/methoud.dart';
import 'package:gp_fe/usrTime/screens/checkout/ordres.dart';
import 'package:gp_fe/usrTime/screens/checkout/waydelivary.dart';
import '../../../constants.dart';
import '../../../models/user.dart';
import '../../map/map.dart';
import '../butombar.dart';
import '../cart/cart_screen.dart';
import '../home/home_screen.dart';
import 'package:http/http.dart' as http;

class checkout extends StatefulWidget {
  const checkout({Key? key,}) : super(key: key);

  @override
  _checkoutState createState() => _checkoutState();
}
  String? username = AuthProvider.userData?.userName;

 Future<void> addOrder( String userName,String location,String payminttype,String waydelivary) async {
    final url = 'http://localhost:4000/Ordar';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "UserName":userName,
        "payminttype":payminttype,
        "location":location,
        "waydelivary":waydelivary
      }),
    );
    if (response.statusCode == 201) {
      print('Product added to cart successfully');
    } else {
      print('Failed to add product to cart');
    }
  }

class _checkoutState extends State<checkout> {
  String paymentMethod = '';
  String waydelivary='';
  final TextEditingController addressController = TextEditingController();
 @override
  void initState() {
    super.initState();
  }
  
@override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text("الدفع"),
    ),
    body: Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: [
          Text("اختر",style: TextStyle(color: orangecolor,fontWeight: FontWeight.bold,fontSize: 20)),
          SizedBox(height: 5,),
          InkWell(onTap: (){
               setState(() {
                  paymentMethod = "cash";
                });
          },
          child: methoud(title: "كاش", isactive: paymentMethod=="cash"?true:false)),
          InkWell(onTap: (){
               setState(() {
                  paymentMethod = "card";
                });
          },
           child: methoud(title: "بطاقة", isactive: paymentMethod=="card"?true:false)),
          SizedBox(height: 20,),

      Text("طريقة التوصيل",style: TextStyle(color: orangecolor,fontWeight: FontWeight.bold,fontSize: 20)),
      SizedBox(height: 10,),
      Center(
       child: Row(
          children: [
       InkWell(
        onTap: (){
               setState(() {
                  waydelivary = "delivary";
                });
          },
        child: waytodelivary(icon: Icons.delivery_dining, isactive: waydelivary=="delivary"? true:false, title: "توصيل",pcolor: const Color.fromARGB(255, 231, 97, 97),)),
          SizedBox(width: 10,)
          ,
          InkWell(
            onTap: (){
               setState(() {
                  waydelivary = "store";
                });
          },
            child: waytodelivary(icon: Icons.drive_eta, isactive: waydelivary=="store"? true:false, title: "من المحل",pcolor: const Color.fromARGB(255, 231, 97, 97),)
          )
          ],
        )
        ),
        SizedBox(height: 20,),
          if(waydelivary=="delivary")
        Text("العنوان",style: TextStyle(color: orangecolor,fontWeight: FontWeight.bold,fontSize: 20)),
        SizedBox(height: 10,),
        if(waydelivary=="delivary")
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: bluecolor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: bluecolor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: orangecolor),
                  ),
                  labelStyle: TextStyle(color: bluecolor),
                ),
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.map_outlined, size: 60, color: const Color.fromARGB(255, 231, 97, 97)),
          ],
        ),

      SizedBox(height: 20,),
      Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "",
                      children: [
                        TextSpan(
                          text: "",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 231, 97, 97),
                    ),
                    onPressed: () {
                       addOrder(
                          username!,
                          addressController.text,
                          paymentMethod,
                          waydelivary
                        );
                        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return  orders(paymentMethod:paymentMethod);
                  }),
                );
                    },
                    child: const Text("أكمل عملية الدفع",style: TextStyle(color: Colors.white,height: 1,fontSize: 20),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )



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
                // Navigate to the report page
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
                    return const CartScreen();
                  }),
                );
                break;
              case 4:
                // Navigate to the personal page
                break;
            }
          },
        ),
  );
}

}