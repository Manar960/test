import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config.dart';
import '../../../login/responsive.dart';
import '../../curved_navigation_bar.dart';
import '../home/home_screen.dart';
import 'package:http/http.dart' as http;

class MyButtonsScreen extends StatefulWidget {
  static var routeName = "/mybuttons";

  @override
  _MyButtonsScreenState createState() => _MyButtonsScreenState();
}

class _MyButtonsScreenState extends State<MyButtonsScreen> {
  bool _checkBoxAdd = false;
  bool _checkBoxDelete = false;
  bool _checkBoxEdit = false;
  String _selectedCategory = 'خدمة';

  TextEditingController nameController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: buildMobileLayout(),
      tablet: buildTabletLayout(),
      desktop: buildDesktopLayout(),
    );
  }

  String companyName = "";

  @override
  void initState() {
    super.initState();
    getCompanyName();
  }

  Future<void> getCompanyName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      companyName = prefs.getString('company') ?? '';
    });
  }

  Widget buildMobileLayout() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(75),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'الاسم',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF063970)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: barcodeController,
                      decoration: const InputDecoration(
                        labelText: 'الباركود',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF063970)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'السعر',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF063970)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'الوصف',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF063970)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  visible: _selectedCategory == 'منتج',
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      key: const Key('inventory_text_field'),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      controller: stokController,
                      decoration: const InputDecoration(
                        constraints: BoxConstraints(maxWidth: 400),
                        labelText: 'المخزون',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF063970)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRoleButton('إضافة', _checkBoxAdd, () {
                      setState(() {
                        _checkBoxAdd = !_checkBoxAdd;
                        _checkBoxEdit = false;
                        _checkBoxDelete = false;
                      });
                    }),
                    _buildRoleButton('تعديل', _checkBoxEdit, () {
                      setState(() {
                        _checkBoxEdit = !_checkBoxEdit;
                        _checkBoxAdd = false;
                        _checkBoxDelete = false;
                      });
                    }),
                    _buildRoleButton('حذف', _checkBoxDelete, () {
                      setState(() {
                        _checkBoxDelete = !_checkBoxDelete;
                        _checkBoxAdd = false;
                        _checkBoxEdit = false;
                      });
                    }),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        hint: const Text('اختر الفئة'),
                        dropdownColor: Colors.white,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                        items: <String>['خدمة', 'منتج'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Color(0xFF063970),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_selectedCategory == 'خدمة') {
                      if (_checkBoxAdd) {
                        await addService(companyName);
                      } else if (_checkBoxDelete) {
                        await deleteService();
                      } else if (_checkBoxEdit) {
                        await updateService();
                      }
                    } else if (_selectedCategory == 'منتج') {
                      if (_checkBoxAdd) {
                        await addProdact(companyName);
                      } else if (_checkBoxDelete) {
                        await deleteProdact();
                      } else if (_checkBoxEdit) {
                        await updateProdact();
                      }
                    }
                  },
                  child: const Text('تم'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF063970),
                  ),
                ),
                const SizedBox(height: 10),
                if (_checkBoxAdd || _checkBoxDelete || _checkBoxEdit)
                  const Text(
                    'تم اختيار الخيار',
                    style: TextStyle(color: Color(0xFF063970)),
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: Color(0xFF063970),
        ),
        child: CurvedNavigationBar(
          index: 2,
          color: const Color(0xFF063970),
          buttonBackgroundColor: const Color(0xFF063970),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          height: 75.0,
          items: const [
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.book, size: 30, color: Colors.white),
            Icon(Icons.add, size: 30, color: Colors.white),
            Icon(Icons.factory, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const HomeScreencom();
                  }),
                );
                break;
              case 1:
                // الانتقال إلى صفحة الريبورت
                break;
              case 2:
                // الانتقال إلى صفحة الأزرار
                break;
              case 3:
                // الانتقال إلى صفحة الطلبيات
                break;
              case 4:
                // الانتقال إلى صفحة الصفحة الشخصية
                break;
            }
          },
        ),
      ),
    );
  }

  Widget buildTabletLayout() {
    return buildMobileLayout();
  }

  Widget buildDesktopLayout() {
    return buildMobileLayout();
  }

  Widget _buildRoleButton(String text, bool selected, VoidCallback onPressed) {
    return Expanded(
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor:
              selected ? const Color(0xFF063970) : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              color: selected ? const Color(0xFF063970) : Colors.grey,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF063970),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Future<void> addService(String companyName) async {
    try {
      final response = await http.post(
        Uri.parse(addServic),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'Name': nameController.text,
          'parcode': barcodeController.text,
          'price': priceController.text,
          'descrption': descriptionController.text,
          'company': companyName,
        }),
      );

      if (response.statusCode == 200) {
        print('Service added successfully.');
      } else {
        print('Failed to add service. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding service: $error');
    }
  }

  Future<void> deleteService() async {
    try {
      final response = await http.delete(
        Uri.parse(deleteServic),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'parcode': barcodeController.text,
        }),
      );

      if (response.statusCode == 200) {
        print('Service deleted successfully.');
      } else {
        print('Failed to delete service. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting service: $error');
    }
  }

  Future<void> updateService() async {
    try {
      final response = await http.put(
        Uri.parse(updateServic),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'parcode': barcodeController.text,
          'updateData': {
            'Name': nameController.text,
            'parcode': barcodeController.text,
            'price': priceController.text,
            'descrption': descriptionController.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Service updated successfully.');
      } else {
        print('Failed to update service. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating service: $error');
    }
  }

  Future<void> addProdact(String companyName) async {
    try {
      final response = await http.post(
        Uri.parse(addProdacts),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'Name': nameController.text,
          'parcode': barcodeController.text,
          'price': priceController.text,
          'descrption': descriptionController.text,
          'company': companyName,
          'stok': stokController.text,
        }),
      );

      if (response.statusCode == 200) {
        print('Service added successfully.');
      } else {
        print('Failed to add service. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error adding service: $error');
    }
  }

  Future<void> deleteProdact() async {
    try {
      final response = await http.delete(
        Uri.parse(deleteProdacts),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'parcode': barcodeController.text,
        }),
      );

      if (response.statusCode == 200) {
        print('Service deleted successfully.');
      } else {
        print('Failed to delete service. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting service: $error');
    }
  }

  Future<void> updateProdact() async {
    try {
      final response = await http.put(
        Uri.parse(updateServic),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'parcode': barcodeController.text,
          'updateData': {
            'Name': nameController.text,
            'price': priceController.text,
            'descrption': descriptionController.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Service updated successfully.');
      } else {
        print('Failed to update service. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating service: $error');
    }
  }
}
