
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../dialog.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.storeName, required this.stroeImage, required this.date, required this.bookingcode}) : super(key: key);
final String storeName,stroeImage,bookingcode;
final DateTime date;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
bool isBookingRemoved = false;
  @override
  void initState() {
    super.initState();
  }
Future<void> removebookng(String BookingCode) async {
    final url = 'https://gp-back-gp.onrender.com/$BookingCode';

    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'BookingCode': BookingCode,
      }),
    );
  
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2
          ),
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width ,
        child:  Column(
          children: [
            ListTile(
              title: Text(
                widget.storeName,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text("موعد"),
              trailing: CircleAvatar(
                backgroundImage: AssetImage(widget.stroeImage),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
              thickness: 1,
              height: 20,
            ),
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
             children: [
              Row(children: [
                Icon(Icons.calendar_month,
               color: Colors.black54,
               ),
               SizedBox(width: 5,),
               Text(DateFormat('yyyy-MM-dd').format(widget.date),
               style: TextStyle(
                color: Colors.black54
               ),
               )
              ],
              ),
              Row(
              children: [
                Icon(Icons.access_time_filled,
                color: Colors.black54,
                ),
                SizedBox(width: 5,),
                Text(DateFormat('HH:mm').format(widget.date),
                style: TextStyle(
                  color: Colors.black54
                ),
                ),
              ],
            ),  
                Row(
              children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle
                ),
              ),
              SizedBox(width: 5,),
                 Text("محجوز",
                style: TextStyle(
                  color: Colors.black54
                ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 15,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
                showCards(context, "assets/car1.json", ' تم الالغاء');
                removebookng(widget.bookingcode);
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(10), 
                ),
                child: Center(child: Text(
                  "الغاء",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),
                )),

              ),
            ),
            InkWell(
              onTap: (){
                showCards(context, "assets/car1.json", 'تم ');
                removebookng(widget.bookingcode);
              },
              child: Container(
                width: 150,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 122, 157, 227),
                  borderRadius: BorderRadius.circular(10), 
                ),
                child: Center(child: Text(
                  "تم",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255)
                  ),
                )),

              ),
            )
          ],
        )
      ],
    ),
   ),
  )
]),
      
);
}
}