import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/project/textfield.dart';

class ElementPropertyView extends StatefulWidget {
  late Rx<WFile> wFile;
  late Rx<WFile> parentFile;
  late bool editable;
  bool change = false;
  ElementPropertyView(
      {required this.wFile,
      this.editable = false,
      required this.parentFile,
      required String type}) {
    change = editable;
  }

  @override
  State<ElementPropertyView> createState() => _ElementPropertyViewState();
}

class _ElementPropertyViewState extends State<ElementPropertyView> {
  void _toggleEditable() {
    setState(() {
      widget.editable = !widget.editable;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cDescription = TextEditingController();
    var cLocation = TextEditingController();
    var cId = TextEditingController();
    var cAuth = TextEditingController();
    var cTitle = TextEditingController();

    cTitle.text = widget.wFile.value.title;
    cDescription.text = widget.wFile.value.description;
    cLocation.text = widget.wFile.value.location;
    cId.text = widget.wFile.value.id;
    cAuth.text = widget.wFile.value.auth.toString();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectTextFieldWidget.inputField1('Title', cTitle, widget.editable),
            SizedBox(height: 16.0),
            ProjectTextFieldWidget.inputField1('Description', cDescription, widget.editable),
            SizedBox(height: 16.0),
            ProjectTextFieldWidget.inputField1('Location', cLocation, widget.editable),
            SizedBox(height: 16.0),
            ProjectTextFieldWidget.inputField1('Id', cId, widget.editable),
            SizedBox(height: 16.0),
            ProjectTextFieldWidget.inputField1('Auth', cAuth, widget.editable),
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.editable) {
                    var model = widget.wFile.value;
                    model.title = cTitle.text;
                    model.auth = cAuth.text;
                    model.location = cLocation.text;
                    model.description = cDescription.text;

                    if (widget.change) {
                      DBTool.SETID(model);
                    }

                    DBTool.putFile(widget.wFile.value, widget.parentFile);
                  }
                  _toggleEditable();
                },
                child: Text((widget.editable ? "SAVE" : "EDIT")),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // DBTool.dropFile(widget.wFile.value, widget.parentFile);
                  Get.back();
                },
                child: const Text("DELETE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
