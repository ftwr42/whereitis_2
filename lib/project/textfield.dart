import 'package:flutter/material.dart';
import 'package:whereitis_2/project/textstyle.dart';

class ProjectTextFieldWidget {
  static Widget inputField1(String title, TextEditingController controller, bool editMode) =>
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Text(
                        "$title:",
                        style: ProjectTextStyle.normal2(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  child: editMode
                      ? TextField(
                          controller: controller,
                        )
                      : Text(controller.text),
                ),
              ),
            ),
          ],
        ),
      );
}
