import 'package:get/get.dart';
import 'package:whereitis_2/model/model_file.dart';
import 'package:whereitis_2/model/model_profile.dart';

class Singleton {
  //for safety this singleton only holds the data which is stored on phone and this how the
  //the singleton only holds real world data how i call it

  static final Singleton _singleton = Singleton._internal();

  late Rx<FileModel> rxRootFile;
  late Rx<ProfileModel> rxRootProfile;

  Rx<FileModel>? rxActiveStore;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal() {
    var profileModel = ProfileModel(
            firstName: "Jan",
            lastName: "Freirich",
            email: "JanFreirich@gmail.com",
            description: "admin")
        .obs;

    var root = FileModel(
            title: "root",
            description: "root",
            location: "root",
            id: "rootid",
            auth: "drwxrwxrwx",
            imgPath: "",
            imagePath: "root")
        .obs;

    var storeA = FileModel(
            title: "Store Chicken",
            description: "sells hot chicken",
            location: "west",
            id: "chickenid",
            auth: "drwxrwxrwx",
            imgPath: "",
            imagePath: "assets/images/store_placeholder.png")
        .obs;

    var storeB = FileModel(
            title: "Store Dogs",
            description: "sells wet dogs",
            location: "east",
            id: "dogsid",
            auth: "drwxrwxrwx",
            imgPath: "",
            imagePath: "assets/images/store_placeholder.png")
        .obs;

    var hundA = FileModel(
      title: "Hund A",
      description: "Kleiner Schwarzer Hund",
      location: "In da Box",
      id: "hundid",
      auth: "-rwxrwxrwx",
      imgPath: '',
      imagePath: "assets/images/store_placeholder.png",
    ).obs;

    var hundB = FileModel(
      title: "Hund B",
      description: "Kleiner Schwarzer Hund",
      location: "In da Box",
      id: "hundid",
      auth: "-rwxrwxrwx",
      imgPath: '',
      imagePath: "",
    ).obs;

    var hundC = FileModel(
      title: "Hund C",
      description: "Kleiner Schwarzer Hund",
      location: "In da Box",
      id: "hundid",
      auth: "-rwxrwxrwx",
      imgPath: '',
      imagePath: "",
    ).obs;

    var chickenA = FileModel(
      title: "Chicken A",
      description: "Kleiner Schwarzer Hund",
      location: "In da Box",
      id: "hundid",
      auth: "-rwxrwxrwx",
      imgPath: '',
      imagePath: "",
    ).obs;

    var chickenB = FileModel(
      title: "Chicken B",
      description: "Kleiner Schwarzer Hund",
      location: "In da Box",
      id: "hundid",
      auth: "-rwxrwxrwx",
      imgPath: '',
      imagePath: "",
    ).obs;

    var chickenC = FileModel(
      title: "Chicken C",
      description: "Kleiner Schwarzer Hund",
      location: "In da Box",
      id: "hundid",
      auth: "-rwxrwxrwx",
      imgPath: '',
      imagePath: "",
    ).obs;

    rxRootProfile = profileModel;

    rxRootFile = root;
    rxRootFile.value.files?.add(storeA);
    rxRootFile.value.files?.add(storeB);

    storeA.value.files?.add(chickenA);
    storeA.value.files?.add(chickenB);
    storeA.value.files?.add(chickenC);

    storeB.value.files?.add(hundA);
    storeB.value.files?.add(hundB);
    storeB.value.files?.add(hundC);

    rxActiveStore = storeA;
  }
}
