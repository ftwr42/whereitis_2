import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';

class HandleStores {
  late String activeStore;
  late List files;
  HandleStores({required this.files, required this.activeStore});

  Future<WFile?> getActiveStore() async {
    var wStore = (await DBTool.loadFileFromFS(activeStore))!;
    return wStore;
  }
}
