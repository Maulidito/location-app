import 'package:flutter/material.dart';

class TabIcon extends StatelessWidget {
  final int index;
  final int tabControllerIndex;
  final IconData icon;
  const TabIcon({
    Key? key,
    required this.tabControllerIndex,
    required this.icon,
    required this.index,
  }) : super(key: key);
  Color? checkIndexColorTab(Color unactive, Color Active) {
    return index == tabControllerIndex ? Active : unactive;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: checkIndexColorTab(
                    Colors.grey.shade300, primaryColor.withOpacity(0.5))!,
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(0, 5.0))
          ],
          shape: BoxShape.circle,
          color: checkIndexColorTab(Colors.grey.shade200, primaryColor)),
      padding: EdgeInsets.all(10),
      child: Icon(
        icon,
        color: checkIndexColorTab(Colors.grey, Colors.white),
      ),
    );
  }
}
