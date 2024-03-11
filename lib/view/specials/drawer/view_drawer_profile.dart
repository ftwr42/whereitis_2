import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/project/textstyle.dart';
import 'package:whereitis_2/singleton.dart';

class DrawerProfileView extends StatelessWidget {
  DrawerProfileView({super.key});

  final double height = 250;

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

  Widget credentials() => FutureBuilder(
        future: DBTool.loadProfileFromFs(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Widget w;
          if (snapshot.hasData) {
            String data = snapshot.data;
            var profile = WProfile.fromJson(jsonDecode(data)).obs;
            Singleton().rxProfile = profile;
            w = credentialsShow(
                profile.value.email, profile.value.firstname, profile.value.lastname);
          } else {
            w = credentialsShow("ur mail", "ur name", "ur lastname");
          }
          return w;
        },
      );

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
