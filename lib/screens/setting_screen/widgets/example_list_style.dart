import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:location_app/constant/constants.dart';
import 'package:location_app/providers/provider_list_style.dart';
import 'package:provider/provider.dart';

import 'caraousel_list_style.dart';

class ExampleListStyle extends StatelessWidget {
  ExampleListStyle({
    Key? key,
    required this.exampleData,
  }) : super(key: key);

  final List<String> exampleData;

  final ScrollController _controllerList = ScrollController();
  final GlobalKey ListKey = GlobalKey();

  void runAnimationList(double? toPosition) async {
    debugPrint("Check aniamtion");

    await Future.delayed(Duration(milliseconds: 150));
    if (ListKey.currentContext?.findRenderObject() == null) {
      return;
    }
    await _controllerList
        .animateTo(toPosition ?? _controllerList.position.maxScrollExtent,
            duration: Duration(seconds: 4), curve: Curves.easeInOut)
        .then((value) {
      if (toPosition == 0.0) {
        runAnimationList(
          _controllerList.position.maxScrollExtent,
        );
        return;
      }
      runAnimationList(0.0);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    runAnimationList(null);
    return AnimatedList(
      physics: ScrollPhysics(parent: null),
      key: ListKey,
      controller: _controllerList,
      itemBuilder: (context, index, animation) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white)),
        child: ListTile(
          leading: CircleAvatar(
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(Icons.image),
          ),
          title: Text("${exampleData[index]} - $index"),
          style: ListTileStyle.list,
        ),
      ),
      initialItemCount: exampleData.length,
    );
  }
}
