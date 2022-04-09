import 'package:flutter/material.dart';

import '../../../models/place.dart';

class ItemImageScreen extends StatelessWidget {
  const ItemImageScreen({
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
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Text(data.title,
              style: TextStyle(
                  fontSize: 25,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500)),
          alignment: Alignment.centerLeft,
        )
      ],
    );
  }
}
