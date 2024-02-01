import 'dart:io';

class ElementModel {
  late String title;
  late String description;
  late String location;
  late String id;
  late File image;
  late String auth;
  // late Map<String, bool> auth = {
  //   'd': false,
  //   'ur': false,
  //   'uw': false,
  //   'ux': false,
  //   'gr': false,
  //   'gw': false,
  //   'gx': false,
  //   'pr': false,
  //   'pw': false,
  //   'px': false,
  // };

  ElementModel(
      {required this.title,
      required this.description,
      required this.location,
      required this.id,
      required this.auth,
      required String imagePath}) {
    image = File("assets/cubboard_default_1.jpg");
  }
}
