import 'package:get/get.dart';
import 'package:whereitis_2/model/model_file.dart';

class ExplorerController extends RxController {
  List<Rx<FileModel>> _modelsFixed = [];
  List<Rx<FileModel>> _modelsShow = [];

  List<Rx<FileModel>> get getModelShow => _modelsShow;

  void loadElementModels() {
    // _modelsFixed = [
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
