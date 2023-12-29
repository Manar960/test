import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../common/app_colors.dart';
import '../pages/dashboard/widget/header_widget.dart';

class ReportPage extends StatelessWidget {
  final int totalUsers = 100;
  final int normalUsers = 60;
  final int companies = 20;
  final int experts = 20;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600; // تحديد إذا كان الجهاز محمولًا

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          HeaderWidget(
            title: 'reports',
          ),
          SizedBox(height: 20), // تقليل ارتفاع هذا الفراغ
          isMobile
              ? Column(
                  children: [
                    DataTable(
                      columns: [
                        DataColumn(label: Text('المجموع')),
                        DataColumn(label: Text('المستخدمين ')),
                        DataColumn(label: Text('الشركات')),
                        DataColumn(label: Text('الخبراء')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('$totalUsers')),
                          DataCell(Text('$normalUsers')),
                          DataCell(Text('$companies')),
                          DataCell(Text('$experts')),
                        ]),
                      ],
                    ),
                    SizedBox(
                        height: 20), // تقليل الفراغ بين الجدول والرسم البياني
                    AspectRatio(
                      aspectRatio: 1.5, // يمكنك تعديل هذا الرقم حسب احتياجاتك
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              title: 'خبراء',
                              value: experts.toDouble(),
                              color: Colors.blue,
                            ),
                            PieChartSectionData(
                              title: 'مستخدمين ',
                              value: normalUsers.toDouble(),
                              color: Colors.green,
                            ),
                            PieChartSectionData(
                              title: 'شركات',
                              value: companies.toDouble(),
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('المجموع')),
                          DataColumn(label: Text('المستخدمين ')),
                          DataColumn(label: Text('الشركات')),
                          DataColumn(label: Text('الخبراء')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('$totalUsers')),
                            DataCell(Text('$normalUsers')),
                            DataCell(Text('$companies')),
                            DataCell(Text('$experts')),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(
                        width: 20), // تقليل الفراغ بين الجدول والرسم البياني
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: screenSize.width /
                            (screenSize.height *
                                0.6), // يمكنك تعديل هذا الرقم حسب احتياجاتك
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                title: 'خبراء',
                                value: experts.toDouble(),
                                color: Colors.blue,
                              ),
                              PieChartSectionData(
                                title: 'مستخدمين',
                                value: normalUsers.toDouble(),
                                color: Colors.green,
                              ),
                              PieChartSectionData(
                                title: 'شركات',
                                value: companies.toDouble(),
                                color: Colors.orange,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
