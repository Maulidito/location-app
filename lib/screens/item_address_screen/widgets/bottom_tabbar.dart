import 'package:flutter/material.dart';
import 'package:location_app/screens/item_address_screen/widgets/tab_icon.dart';

class Bottom_tabbar extends StatefulWidget {
  final TabController tabController;
  const Bottom_tabbar({Key? key, required this.tabController})
      : super(key: key);

  @override
  State<Bottom_tabbar> createState() => _Bottom_tabbarState();
}

class _Bottom_tabbarState extends State<Bottom_tabbar> {
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
