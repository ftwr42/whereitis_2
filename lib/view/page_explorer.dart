import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:whereitis_2/model/DBTool.dart';
import 'package:whereitis_2/model/db/wii_file.dart';
import 'package:whereitis_2/singleton.dart';
import 'package:whereitis_2/view/specials/drawer/view_drawer.dart';
import 'package:whereitis_2/view/specials/fab/view_fab.dart';

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
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: WiiFab(
        wFile: widget.wFile,
      ),
      drawer: (Singleton().rxRoot == null || Singleton().rxProfile == null)
          ? WiiDrawerView(
              rxFile: Singleton().rxRoot!,
              rxProfile: Singleton().rxProfile!,
            )
          : null,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(widget.wFile.value.title), //Text(dirModel.value.title),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
                (context, index) => FutureBuilder(
                    future: DBTool.loadFileFromFS(files[index]),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      Widget w = const Text("HAS NO DATA");
                      if (snapshot.hasData) {
                        w = ExplorerView(wFile: snapshot.data);
                      }
                      return w;
                    }),
                childCount: files.length),
            gridDelegate: elementGridDelegate(2),
          ),
        ],
      ),
    );
  }

  SliverGridDelegateWithFixedCrossAxisCount elementGridDelegate(int crossAxisCount) =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
        childAspectRatio: 1.0, // Verhältnis von Breite zu Höhe
      );
}
