import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../config.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';
import 'package:http/http.dart' as http;

class RecruitmentDataWidget extends StatefulWidget {
  const RecruitmentDataWidget({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RecruitmentDataWidgetState createState() => _RecruitmentDataWidgetState();
}

class _RecruitmentDataWidgetState extends State<RecruitmentDataWidget> {
  List<Map<String, dynamic>> adminDataList = [];

  @override
  void initState() {
    super.initState();
    fetchAdminData();
  }

  Future<void> fetchAdminData() async {
    try {
      final response = await http.get(Uri.parse(getadmindata));
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          adminDataList = List.from(json.decode(response.body)['adminData']);
        });
      } else {
        throw Exception('Failed to load admin data');
      }
    } catch (error) {
      print('Error fetching admin data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recruitment Progress",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              /// Table Header
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                ),
                children: [
                  tableHeader("Full Name"),
                  if (!AppResponsive.isMobile(context))
                    tableHeader("Designation"),
                  tableHeader("Status"),
                  if (!AppResponsive.isMobile(context)) tableHeader(""),
                ],
              ),

              /// Table Data
              for (final admin in adminDataList)
                tableRow(
                  context,
                  name: admin['adminName'],
                  designation:
                      "UI/UX Designer", // You may replace this with the actual designation from your data
                  email: admin[
                      'email'], // You may replace this with the actual status from your data
                  color: Colors
                      .yellow, // You may replace this with the actual color from your data
                ),
            ],
          ),
        ],
      ),
    );
  }

  TableRow tableRow(
    context, {
    required String name,
    required String designation,
    required String email,
    required Color color,
  }) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      children: [
        // Full Name
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              // You can replace the image with the actual image URL from your admin data
              // or use a placeholder image
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset(
                  "assets/user2.jpg",
                  width: 30,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(name ?? ''),
            ],
          ),
        ),
        // Designation
        if (!AppResponsive.isMobile(context)) Text(designation ?? ''),
        // Status
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color ?? Colors.grey,
              ),
              height: 10,
              width: 10,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(email ?? ''),
          ],
        ),
        // Menu icon
        if (!AppResponsive.isMobile(context))
          Image.asset(
            "assets/more.png",
            color: Colors.grey,
            height: 30,
          ),
      ],
    );
  }

  Widget tableHeader(text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: AppColor.black),
      ),
    );
  }
}
