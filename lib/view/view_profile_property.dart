import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/project/textfield.dart';

class ProfilePropertyView extends StatefulWidget {
  late Rx<WProfile> rxProfile;
  late bool editable;
  ProfilePropertyView({required this.rxProfile, this.editable = false});

  @override
  State<ProfilePropertyView> createState() => _ElementPropertyViewState();
}

class _ElementPropertyViewState extends State<ProfilePropertyView> {
  void _toggleEditable() {
    setState(() {
      widget.editable = !widget.editable;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cLastname = TextEditingController();
    var cEmail = TextEditingController();
    var cDescription = TextEditingController();
    var cFirstname = TextEditingController();

    cFirstname.text = widget.rxProfile.value.firstname;
    cLastname.text = widget.rxProfile.value.lastname;
    cEmail.text = widget.rxProfile.value.email;
    cDescription.text = widget.rxProfile.value.description;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectTextFieldWidget.inputField1('Firstname', cFirstname, widget.editable),
            SizedBox(height: 16.0),
            ProjectTextFieldWidget.inputField1('lastname', cLastname, widget.editable),
            SizedBox(height: 16.0),
            ProjectTextFieldWidget.inputField1('email', cEmail, widget.editable),
            SizedBox(height: 16.0),
            ProjectTextFieldWidget.inputField1('description', cDescription, widget.editable),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  _toggleEditable();
                  if (!widget.editable) {
                    var model = widget.rxProfile.value;
                    model.description = cDescription.text;
                    model.firstname = cFirstname.text;
                    model.email = cEmail.text;
                    model.lastname = cLastname.text;
                    DBTool.putProfile(widget.rxProfile.value);
                  }
                },
                child: Text((widget.editable ? "SAVE" : "EDIT")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
