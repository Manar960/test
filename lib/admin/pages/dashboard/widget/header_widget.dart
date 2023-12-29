import 'package:flutter/material.dart';
import 'package:gp_fe/admin/controllers/menu_controller.dart'
    as MyMenuController;
import 'package:provider/provider.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_responsive.dart';

class HeaderWidget extends StatefulWidget {
  final String title; // إضافة باراميتر لتمرير نص العنوان

  HeaderWidget({required this.title}); // كونستركتور يأخذ نص العنوان كباراميتر

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          if (!AppResponsive.isDesktop(context))
            IconButton(
              icon: Icon(
                Icons.menu,
                color: AppColor.black,
              ),
              onPressed: Provider.of<MyMenuController.MenuController>(context,
                      listen: false)
                  .controlMenu,
            ),
          Text(
            widget.title, // استخدام القيمة الممررة من الباراميتر
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (!AppResponsive.isMobile(context)) ...{
            Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                navigationIcon(icon: Icons.search),
                navigationIcon(icon: Icons.send),
                navigationIcon(icon: Icons.notifications_none_rounded),
              ],
            )
          }
        ],
      ),
    );
  }

  Widget navigationIcon({icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }
}
