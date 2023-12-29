import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../models/user.dart';
import '../../../constants.dart';

class CartCard extends StatefulWidget {
  const CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Map<String, dynamic> cart;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late int itemCount=0; 
  late int itemsprice = 0;
  String? username = AuthProvider.userData?.userName;

  @override
  void initState() {
    super.initState();
    fetchCartItemCount();
  }

  Future<void> fetchCartItemCount() async {
    try {
      final count = await getCartItemCount(widget.cart['ProBarCode'], username!);
      print('Fetched count: $count');
      setState(() {
        itemCount = count;
      });
    } catch (error) {
      print('Error fetching count: $error');
    }
  }
Future<int> getCartItemCount(String proBarCode, String userName) async {
  const String apiUrl = 'https://gp-back-gp.onrender.com/getcount'; 

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'ProBarCode': proBarCode, 'UserName': userName}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData['itemCount'] as int;
    } else {
      throw Exception('Failed to load cart item count');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to connect to the server');
  }
}
  
Future<void> removeFromCart(String proBarCode, String userName) async {
    final url = 'https://gp-back-gp.onrender.com/removeFromCart/oneitem';

    final response = await http.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ProBarCode': proBarCode,
        'UserName': userName,
   
        
      }),
    );
    if (response.statusCode == 201) {
      print('Product deleted to cart successfully');
    } else {
      print('Failed to deleted product to cart');
    }
  }
  Future<void> addToCart(String proBarCode, String userName) async {
    final url = 'https://gp-back-gp.onrender.com/addToCart';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'ProBarCode': proBarCode,
        'UserName': userName,
   
        
      }),
    );
    if (response.statusCode == 201) {
      print('Product added to cart successfully');
    } else {
      print('Failed to add product to cart');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(widget.cart['proimage']),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cart['proname'],
              style: const TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
           
            Text.rich(
              TextSpan(
                text: "\$${widget.cart['ProPrice']}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
            ),
            const SizedBox(height: 10),
             Align(
                alignment: Alignment.centerRight,
                child:
            Row(
              children: [
                InkWell(
                  onTap: () {
                    removeFromCart(widget.cart['ProBarCode'], username!);
                    if (itemCount > 0) {
                    setState(() {
                      itemCount--;
                    });
                    }
                   
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: const Icon(Icons.remove),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  itemCount.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                     addToCart(widget.cart['ProBarCode'], username!);
              setState(() {
                itemCount++;
              });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
            ),
          ],
        ),
      ],
    );
  }
}