import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:whereitis_2/model/model_profile.dart';
import 'package:whereitis_2/project/textstyle.dart';

class DrawerProfileView extends StatelessWidget {
  late Rx<ProfileModel> rxModel;
  DrawerProfileView({super.key, required this.rxModel});

  final double height = 200;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Stack(
        children: [
          Align(alignment: Alignment.center, child: profileImage()),
          Align(alignment: Alignment.bottomRight, child: credentials()),
        ],
      ),
    );
  }

  Widget credentials() => Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${rxModel.value.firstName} ${rxModel.value.lastName}',
              style: ProjectTextStyle.header1(),
            ),
            Text(
              '${rxModel.value.email}',
              style: ProjectTextStyle.header1(),
            ),
          ],
        ),
      );

  Widget profileImage() => const Column(
        children: [
          CircleAvatar(
            child: Image(
              image: AssetImage(
                "assets/images/profile_placeholder.png",
              ),
            ),
            radius: 200 / 2,
          ),
        ],
      );
}
