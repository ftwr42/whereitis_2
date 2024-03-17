import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/project/textstyle.dart';
import 'package:whereitis_2/view/page_explorer.dart';
import 'package:whereitis_2/view/pages/page_property_file.dart';

class ElementGridView extends StatelessWidget {
  late Rx<WFile> rxmodel;
  late Rx<WFile> rxParent;
  ElementGridView({required this.rxmodel, required this.rxParent});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          // Open new explorer with new model controller
          if (rxmodel.value.auth.startsWith('d')) {
            Get.to(ExplorerView(
              wFile: rxmodel,
              withDrawer: false,
            ));
          } else {
            Get.to(() => PropertyFilePage(
                  editable: false,
                  type: 'container',
                  parentFile: rxParent,
                  wFile: rxmodel,
                ));
          }
        },
        onLongPress: () {
          Get.to(() => PropertyFilePage(
                editable: false,
                type: 'container',
                parentFile: rxParent,
                wFile: rxmodel,
              ));
        },
        child: Obx(
          () {
            return Stack(
              children: [
                FutureBuilder(
                  future: DBTool.loadImageFromFS(imageName: rxmodel.value.image),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Align(
                        alignment: Alignment.center,
                        child: Image.file(snapshot.data!),
                      );
                    } else {
                      return Align(
                        alignment: Alignment.center,
                        child: Image.asset("assets/images/cubboard_default_1.jpg"),
                      );
                    }
                  },
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
                            rxmodel.value.title,
                            style: ProjectTextStyle.title(),
                          ),
                          SizedBox(height: 8),
                          Text(
                            rxmodel.value.description,
                            style: ProjectTextStyle.description(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
