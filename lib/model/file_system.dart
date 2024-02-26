import 'package:get/get.dart';
import 'package:whereitis_2/model/model_file.dart';

class FileSystem {
  late Rx<FileModel> root;
  late List<Rx<FileModel>> files;
  Rx<FileModel>? activeStore;
}
