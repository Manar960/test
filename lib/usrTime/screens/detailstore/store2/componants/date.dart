import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gp_fe/usrTime/screens/detailstore/detailpage/componant/responsive.dart';
import 'package:http/http.dart' as http;
import '../../../../map/map.dart';
import '../../../booking/boking_screen.dart';
import '../../../butombar.dart';
import '../../../cart/cart_screen.dart';
import '../../../dialog.dart';
import '../../../home/home_screen.dart';


class date extends StatefulWidget {
  const date({Key? key, required this.Name, required this.image, required this.user, }) : super(key: key);
final String Name ,image,user;
  @override
  _dateState createState() => _dateState();
}
 
  int selectedTimeIndex = 0;

class _dateState extends State<date> {
  TextEditingController _date = TextEditingController();
    late String time;
Future<bool> Booking(String StoreName, String userName, String Storeimage, DateTime date) async {
  final url = 'https://gp-back-gp.onrender.com/Booking';

  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'StoreName': StoreName,
      'UserName': userName,
      'Storeimage': Storeimage,
      'date': date.toUtc().toIso8601String(),
    }),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final bool status = responseData['status'];

    return status;
  } else {
    print('Failed to make booking. Status code: ${response.statusCode}');
    return false;
  }
}
 @override
  void initState() {
    super.initState();
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        title: Text('حجز موعد'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: Align(
  alignment: Alignment.topCenter,
  child: Padding(
    padding: const EdgeInsets.all(30),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _date,
          decoration: const InputDecoration(
            labelText: 'التاريخ',
            filled: true,
            prefixIcon: Icon(Icons.calendar_today),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
          readOnly: true,
          onTap: () {
            _selectDate();
          },
        ),
        SizedBox(height: 20),
        const Center(
          child: Text(
            'الوقت',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(height: 20), 
        Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio:Responsive.isDesktop(context)? 3.0:1
          ),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            int hour = index*2 + 8;
             time = '$hour:00';

            return InkWell(
              onTap: () {
                   setState(() {
          selectedTimeIndex = index;
          print('Selected time: $time');
          print('Date: ${DateTime.parse('${_date.text} $time')}');
        });
              },
              child: Card(
                color: selectedTimeIndex == index ? Color.fromARGB(255, 172, 207, 244) : Color.fromARGB(255, 208, 215, 10),
                child: Center(
                  child: Text(
                    time,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                
              ),
            );
          },
        ),
      ),
      Center(
        child: SizedBox(
                height: 40,
                width: 200,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF063970),
                  ),
                  onPressed: () async {
                  bool bookingStatus = await Booking(widget.Name, widget.user, widget.image, DateTime.parse('${_date.text} $time'));

                  if (bookingStatus) {
                    showCards(context, "assets/booked.json", 'تم الحجز');
                  } else {
                    showCards(context, "assets/sad.json", 'محجوز');
                  }
                  _date.text="";
                  selectedTimeIndex=0;
                },

                  child: Text(
                    "احجز",
                    style: TextStyle(color: Colors.white, height: 1, fontSize: 20),
                  ),
                ),
              ),
      ),
      ],
    ),
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

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _date.text = _picked.toString().split(" ")[0];
      });
    }
  }
}