import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/project/textstyle.dart';
import 'package:whereitis_2/view/pages/page_property_profile.dart';

class DrawerProfileView extends StatelessWidget {
  late Rx<WProfile> rxProfile;
  DrawerProfileView({super.key, required this.rxProfile});

  final double height = 250;

  @override
  Widget build(BuildContext context) {
    var value = rxProfile.value;
    return GestureDetector(
      onLongPress: () {
        Get.to(PropertyProfilePage(
          rxProfile: rxProfile,
        ));
      },
      child: Container(
        height: height,
        child: Stack(
          children: [
            Align(alignment: Alignment.center, child: profileImage()),
            Align(
                alignment: Alignment.bottomRight,
                child: credentialsShow(value.email, value.firstname, value.lastname)),
          ],
        ),
      ),
    );
  }

  Widget credentialsShow(String email, String firstname, String lastname) => Container(
        height: height,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${firstname} ${lastname}',
                style: ProjectTextStyle.header1(),
              ),
              Text(
                '${email}',
                style: ProjectTextStyle.header1(),
              ),
            ],
          ),
        ),
      );

  Widget profileImage() => Column(
        children: [
          Obx(
            () => FutureBuilder(
                future: DBTool.loadImageFromFS(imageName: rxProfile.value.image),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      radius: 200 / 2,
                      child: Image.file(snapshot.data!),
                    );
                  } else {
                    return const CircleAvatar(
                      radius: 200 / 2,
                      child: Image(
                        image: AssetImage(
                          "assets/images/profile_placeholder.png",
                        ),
                      ),
                    );
                  }
                }),
          )
        ],
      );
}
