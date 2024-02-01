import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:whereitis_2/model/model_element.dart';

class ElementGridView extends StatelessWidget {
  late Rx<ElementModel> rxmodel;
  ElementGridView({required this.rxmodel});

  @override
  Widget build(BuildContext context) {
    var model = rxmodel.value;
    // print("description " + model.description);

    return Container(
      width: 200,
      height: 200,
      color: Colors.red,
      child: Stack(
        children: [
          Align(alignment: Alignment.topRight, child: dw(child: Text(model.title))),
          Align(alignment: Alignment.bottomRight, child: dw(child: Text(model.description))),
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/cubboard_default_1.jpg"),
          ),
        ],
      ),
    );
    // return Container(
    //   child: Stack(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Container(
    //           width: 200,
    //           height: 200,
    //           color: Colors.red,
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}

Widget dw({required Text child}) => Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        child: child,
      ),
    );
