import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:whereitis_2/model/model_file.dart';
import 'package:whereitis_2/project/textfield.dart';

class ElementPropertyView extends StatefulWidget {
  late Rx<FileModel> model;
  late bool editable;
  ElementPropertyView({required this.model, this.editable = false});

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

    cDescription.text = widget.model.value.description;
    cLocation.text = widget.model.value.location;
    cId.text = widget.model.value.id;
    cAuth.text = widget.model.value.auth.toString();

    return Container(
      child: Column(
        children: [
          ProjectTextFieldWidget.inputField1('Description', cDescription, widget.editable),
          ProjectTextFieldWidget.inputField1('Location', cLocation, widget.editable),
          ProjectTextFieldWidget.inputField1('Id', cId, widget.editable),
          ProjectTextFieldWidget.inputField1('Auth', cAuth, widget.editable),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () {
                    _toggleEditable();
                  },
                  child: Text((widget.editable ? "SAVE" : "EDIT"))),
            ),
          ),
        ],
      ),
    );
  }
}
