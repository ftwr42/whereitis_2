import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/model_file.dart';
import 'package:whereitis_2/project/textstyle.dart';
import 'package:whereitis_2/view/pages/page_touch_file.dart';

class ElementGridView extends StatelessWidget {
  late Rx<FileModel> rxmodel;
  ElementGridView({required this.rxmodel});

  @override
  Widget build(BuildContext context) {
    var model = rxmodel.value;
    // print("description " + model.description);

    return Container(
      child: GestureDetector(
        onTap: () {
          //open new explorer with new model controller
        },
        onLongPress: () {
          Get.to(() => TouchFilePage(model: rxmodel));
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset("assets/images/cubboard_default_1.jpg"),
            ),
            buildText(model.title, ProjectTextStyle.normal1(), Alignment.topRight),
            buildText(model.description, ProjectTextStyle.normal2(), Alignment.bottomRight),
          ],
        ),
      ),
    );
    // return Container(
    //   child: Stack(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Container(
    //           width: 200,
    //           height: 200,
    //           color: Colors.red,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Align buildText(String text, TextStyle style, AlignmentGeometry align) {
    return Align(
      alignment: align,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );
  }
}
