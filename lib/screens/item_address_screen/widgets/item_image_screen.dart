import 'package:flutter/material.dart';

import '../../../models/place.dart';

class item_image_screen extends StatelessWidget {
  const item_image_screen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Place data;

  @override
  Widget build(BuildContext context) {
    debugPrint("item Image Screen generating...");
    return Column(
      children: [
        data != null ? Image.file(data.image) : Text("Not Found"),
      ],
    );
  }
}
