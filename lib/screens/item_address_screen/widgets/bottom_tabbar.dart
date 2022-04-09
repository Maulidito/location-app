import 'package:flutter/material.dart';
import 'package:location_app/screens/item_address_screen/widgets/tab_icon.dart';

class BottomTabbar extends StatefulWidget {
  final TabController tabController;
  const BottomTabbar({Key? key, required this.tabController}) : super(key: key);

  @override
  State<BottomTabbar> createState() => _BottomTabbarState();
}

class _BottomTabbarState extends State<BottomTabbar> {
  @override
  Widget build(BuildContext context) {
    debugPrint("Bottom tabbar generating...");

    return Card(
      elevation: 10,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: TabBar(
          controller: widget.tabController,
          tabs: [
            Tab(
                height: double.infinity,
                icon: TabIcon(
                  index: 0,
                  icon: Icons.image,
                  tabControllerIndex: widget.tabController.index,
                )),
            Tab(
                height: double.infinity,
                icon: TabIcon(
                  index: 1,
                  icon: Icons.my_location,
                  tabControllerIndex: widget.tabController.index,
                )),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
