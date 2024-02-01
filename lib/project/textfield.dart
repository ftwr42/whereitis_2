import 'package:flutter/material.dart';
import 'package:whereitis_2/project/textstyle.dart';

class ProjectTextFieldWidget {
  static Widget inputField1(String title, TextEditingController controller, bool editMode) => Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: ProjectTextStyle.normal1(),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: editMode
                ? TextField(
                    controller: controller,
                  )
                : Text(controller.text),
          ),
        ],
      );
}
