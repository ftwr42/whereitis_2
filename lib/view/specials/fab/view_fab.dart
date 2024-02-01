import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

//https://pub.dev/packages/flutter_expandable_fab
class WiiFab extends StatelessWidget {
  final _key = GlobalKey<ExpandableFabState>();

  WiiFab({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: _key,
      pos: ExpandableFabPos.right,
      type: ExpandableFabType.up,
      distance: 80,
      afterOpen: () {},
      children: [
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.edit),
          onPressed: () {
            _key.currentState!.toggle();
          },
        ),
        FloatingActionButton.small(
          heroTag: null,
          child: const Icon(Icons.search),
          onPressed: () {
            _key.currentState!.toggle();
          },
        ),
      ],
    );
  }
}
