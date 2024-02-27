import 'dart:io';

import 'package:get/get.dart';

class FileModel {
  //can be a folder or a file like in linux, everything is a file

  late String title;
  late String description;
  late String location;
  late String id;
  late File _image;
  late String auth;
  late String imgPath;

  List<Rx<FileModel>>? files;

  FileModel(
      {required this.title,
      required this.description,
      required this.location,
      required this.id,
      required this.auth,
      required this.imgPath,
      required String imagePath}) {
    _image = File("assets/cubboard_default_1.jpg");

    if (isDir()) {
      files = [];
    }
  }

  FileModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    location = json['location'];
    id = json['id'];
    auth = json['auth'];
    imgPath = json['imgPath'];

    _image = File("assets/cubboard_default_1.jpg");
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'title': title,
      'description': description,
      'location': location,
      'id': id,
      'auth': auth,
      'imgPath': imgPath
    };
    return json;
  }

  bool isDir() {
    return (auth[0] == 'd') ? true : false;
  }

  bool addFile(Rx<FileModel> rxModel) {
    files?.add(rxModel);
    return true; //todo add when not available
  }

  void removeFile(String id) {
    files?.removeWhere((element) => element.value.id == id);
  }

  void changeFile(String id,
      {String title = "",
      String description = "",
      String location = "",
      String imgPath = "",
      String auth = ""}) {
    for (Rx<FileModel> rxFile in files!) {
      var model = rxFile.value;
      if (model.id == id) {
        model.title = (title != "") ? model.title : title;
        model.description = (description != "") ? model.description : description;
        model.location = (location != "") ? model.location : location;
        model.imgPath = (imgPath != "") ? model.imgPath : imgPath;
        model.auth = (auth != "") ? model.auth : auth;
      }
    }
  }
}
