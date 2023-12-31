import 'package:flutter/material.dart';

import '../utils/project_model.dart';
import '../utils/theme_selector.dart';

class ProjectEntry extends StatelessWidget {
  const ProjectEntry({required Key key, required this.project})
      : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
          project.title,
          style: ThemeSelector.selectSubHeadline(context),
        ),
        SizedBox(height: screenHeight * 0.05),
        Text(
          project.description,
          style: ThemeSelector.selectBodyText(context),
        )
      ],
    );
  }
}
