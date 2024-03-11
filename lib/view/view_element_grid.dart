import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/controller/controller_explorer.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/project/textstyle.dart';
import 'package:whereitis_2/view/page_explorer.dart';
import 'package:whereitis_2/view/pages/page_touch_file.dart';

class ElementGridView extends StatelessWidget {
  late Rx<WFile> rxmodel;
  ElementGridView({required this.rxmodel});

  @override
  Widget build(BuildContext context) {
    var model = rxmodel.value;

    return Container(
      child: GestureDetector(
        onTap: () {
          // Open new explorer with new model controller
          if (rxmodel.value.auth.startsWith('d')) {
            Get.to(ExplorerView(
              controller: ExplorerController(),
              wFile: rxmodel,
              withDrawer: false,
            ));
          } else {
            Get.to(() => TouchFilePage(model: rxmodel));
          }
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withOpacity(0.75), // Semi-transparent background
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        model.title,
                        style: ProjectTextStyle.title(),
                      ),
                      SizedBox(height: 8),
                      Text(
                        model.description,
                        style: ProjectTextStyle.description(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
