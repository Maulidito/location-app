import 'package:flutter/material.dart';

class FrameImage extends StatelessWidget {
  const FrameImage({Key? key, required this.child}) : super(key: key);
  final Widget child;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 250,
        height: 200,
        child: Card(
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: child,
        )
      );
  }
}
