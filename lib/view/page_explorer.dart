import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer.dart';
import 'package:whereitis_2/view/specials/fab/view_fab.dart';
import 'package:whereitis_2/view/view_element_grid.dart';

class ExplorerView extends StatefulWidget {
  late Rx<WFile> wFile;
  late bool withDrawer;
  ExplorerView({super.key, required this.wFile, this.withDrawer = true});

  @override
  State<ExplorerView> createState() => _ExplorerViewState();
}

class _ExplorerViewState extends State<ExplorerView> {
  @override
  Widget build(BuildContext context) {
    List files = widget.wFile.value.files;

    widget.wFile.listen((p0) {
      setState(() {});
    });

    return Scaffold(
      drawer: (widget.withDrawer)
          ? WiiDrawerView(
              rxSettings: Singleton().rxSettings!,
              rxFile: Singleton().rxRoot!,
              rxProfile: Singleton().rxProfile!,
            )
          : null,
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: WiiFab(
        wFile: widget.wFile,
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title: Text(widget.wFile.value.title), //Text(dirModel.value.title),
        ),
        FutureBuilder(
            future: DBTool.loadAllFilesFromFS(files),
            builder: (BuildContext context, AsyncSnapshot<List<WFile?>> snapshot) {
              if (snapshot.hasData) {
                return SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    var wFiles = snapshot.data;
                    print("1-> $index " + wFiles.toString());
                    var file = wFiles?[index];
                    print("2->" + file.toString());
                    return ElementGridView(rxmodel: file!.obs, rxParent: widget.wFile);
                  }, childCount: snapshot.data!.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                    childAspectRatio: 1.0, // Verhältnis von Breite zu Höhe
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(
                    color: Colors.grey,
                  ),
                );
              }
            }),
      ]),
    );
  }
}

// return CustomScrollView(
// slivers: [
// SliverAppBar(
// title: Text(widget.wFile.value.title), //Text(dirModel.value.title),
// ),
// SliverGrid(
// delegate: SliverChildBuilderDelegate(
// (context, index) => FutureBuilder(
// future: DBTool.loadFileFromFS(files[index]),
// builder: (BuildContext context, AsyncSnapshot<WFile?> snapshot) {
// if (snapshot.hasData) {
// var data = snapshot.data;
// var obs = data!.obs;
// return ElementGridView(
// rxmodel: obs,
// rxParent: widget.wFile,
// );
// }
// return Container();
// }),
// childCount: files.length),
// gridDelegate: elementGridDelegate(2),
// ),
// ],
// );
