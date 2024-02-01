import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:whereitis_2/model/model_element.dart';
import 'package:whereitis_2/project/textfield.dart';
import 'package:whereitis_2/project/textstyle.dart';

class ElementPropertyView extends StatelessWidget {
  late Rx<ElementModel> model;
  ElementPropertyView({required this.model});

  @override
  Widget build(BuildContext context) {
    bool editable = false;

    var cTitle = TextEditingController();
    var cDescription = TextEditingController();
    var cLocation = TextEditingController();
    var cId = TextEditingController();
    var cAuth = TextEditingController();

    cTitle.text = model.value.title;
    cDescription.text = model.value.description;
    cLocation.text = model.value.location;
    cId.text = model.value.id;
    cAuth.text = model.value.auth.toString();

    return Container(
      child: Column(
        children: [
          Text(
            model.value.auth.substring(0, 1) == 'f' ? "Item" : "Container",
            style: ProjectTextStyle.header1(),
          ),
          ProjectTextFieldWidget.inputField1('Title', cTitle, editable),
          ProjectTextFieldWidget.inputField1('Description', cDescription, editable),
          ProjectTextFieldWidget.inputField1('Location', cLocation, editable),
          ProjectTextFieldWidget.inputField1('Id', cId, editable),
          ProjectTextFieldWidget.inputField1('Auth', cAuth, editable),
        ],
      ),
    );
  }
}
