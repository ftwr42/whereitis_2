import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/db/wii_profile.dart';
import 'package:whereitis_2/project/assets_images.dart';
import 'package:whereitis_2/view/view_profile_property.dart';

class PropertyProfilePage extends StatelessWidget {
  late bool change;
  late Rx<WProfile> rxProfile;

  PropertyProfilePage({
    super.key,
    this.change = false,
    required this.rxProfile,
  });

  @override
  Widget build(BuildContext context) {
    WProfile newProfile = WProfile(
        firstname: "firstname",
        lastname: "lastname",
        id: "prwxrwxrwx",
        email: "email",
        description: "description",
        image: AssetsImages.PLACEHOLDER_PROFILE);

    return Scaffold(
      appBar: AppBar(
        title: Text("profile".toUpperCase()),
      ),
      body: ProfilePropertyView(
        rxProfile: rxProfile,
      ),
    );
  }
}
