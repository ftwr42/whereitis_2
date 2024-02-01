import 'package:get/get.dart';
import 'package:whereitis_2/model/model_element.dart';

class ExplorerController extends RxController {
  List<Rx<ElementModel>> _modelsFixed = [];
  List<Rx<ElementModel>> _modelsShow = [];

  List<Rx<ElementModel>> get getModelShow => _modelsShow;

  void loadElementModels() {
    _modelsFixed = [
      ElementModel(
        title: "Hund",
        description: "Kleiner Schwarzer Hund",
        location: "In da Box",
        id: "hundid",
        auth: "drwxrwxrwx",
        imagePath: "",
      ).obs,
      ElementModel(
        title: "Hund",
        description: "Kleiner Schwarzer Hund",
        location: "In da Box",
        id: "hundid",
        auth: "drwxrwxrwx",
        imagePath: "",
      ).obs,
      ElementModel(
        title: "Hund",
        description: "Kleiner Schwarzer Hund",
        location: "In da Box",
        id: "hundid",
        auth: "frwxrwxrwx",
        imagePath: "",
      ).obs,
      ElementModel(
        title: "Hund",
        description: "Kleiner Schwarzer Hund",
        location: "In da Box",
        id: "hundid",
        auth: "frwxrwxrwx",
        imagePath: "",
      ).obs,
    ];
    _modelsFixed.forEach((element) {
      _modelsShow.add(element);
    });
  }

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   loadElementModels();
  // }

  void filterList(String filter) {
    if (filter == "") {
      _modelsFixed.map((e) => _modelsShow.add(e));
    } else {
      _modelsFixed.map((e) => {if (e.value.title.startsWith(filter)) _modelsShow.add(e)});
    }
  }
}
