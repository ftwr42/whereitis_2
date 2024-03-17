import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';

class HandleStores {
  late String activeStore;
  late List files;
  // WFile? wActiveStore;
  HandleStores({required this.files, required this.activeStore}) {
    bool a = false;
    for (String str in files) {
      if (str == activeStore) {
        a = true;
      }
    }
    if (!a) {
      activeStore = files[0];
    }
  }

  Future<WFile?> getActiveStore() async {
    var wStore = (await DBTool.loadFileFromFS(activeStore))!;
    // wActiveStore = wStore;
    var s = await DBTool.loadStringFromFS('root');
    if (s == "" || s == "empty") {
      return WFile(
          title: "title",
          description: "description",
          auth: "auth",
          location: "location",
          image: "image",
          files: []);
    }

    return wStore;
  }
}
