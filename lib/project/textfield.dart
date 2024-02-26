import 'package:flutter/material.dart';
import 'package:whereitis_2/project/textstyle.dart';

class ProjectTextFieldWidget {
  static Widget inputField1(String title, TextEditingController controller, bool editMode, {InputDecoration? decoration}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: ProjectTextStyle.normal2(),
          ),
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth, // Set the width to match the parent width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey), // Border color
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: editMode
                    ? TextFormField(
                  controller: controller,
                  style: ProjectTextStyle.normal2(),
                  decoration: decoration,
                )
                    : Text(
                  controller.text,
                  style: ProjectTextStyle.normal2(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static InputDecoration inputDecorationForLogin(String labelText, String hintText, IconData prefix) {
    return InputDecoration(
      labelText: labelText, // Placeholder text
      hintText: hintText,
      prefixIcon: Icon(prefix), // Icon before the text input
      suffixIcon: Icon(Icons.clear), // Icon after the text input
      border: OutlineInputBorder(
        // Border outline
        borderRadius: BorderRadius.circular(10),
      ),
      fillColor: Colors.black12,
      filled: true,
    );
  }
}
