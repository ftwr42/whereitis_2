import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:whereitis_2/model/model_element.dart';
import 'package:whereitis_2/project/textfield.dart';

class ElementPropertyView extends StatefulWidget {
  late Rx<ElementModel> model;
  ElementPropertyView({required this.model});

  @override
  State<ElementPropertyView> createState() => _ElementPropertyViewState();
}

class _ElementPropertyViewState extends State<ElementPropertyView> {
  bool editable = false;

  void _toggleEditable() {
    setState(() {
      editable = !editable;
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
          ProjectTextFieldWidget.inputField1('Description', cDescription, editable),
          ProjectTextFieldWidget.inputField1('Location', cLocation, editable),
          ProjectTextFieldWidget.inputField1('Id', cId, editable),
          ProjectTextFieldWidget.inputField1('Auth', cAuth, editable),
          Align(
            alignment: Alignment.center,
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      _toggleEditable();
                    },
                    child: Text("EDIT")),
                (editable) ? ElevatedButton(onPressed: () {}, child: Text("SAVE")) : Text(""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
