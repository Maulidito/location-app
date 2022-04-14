import 'package:flutter/material.dart';
import 'package:location_app/providers/provider_place.dart';
import 'package:location_app/screens/home_screen/widgets/delete_system.dart';
import 'package:location_app/screens/item_address_screen/item_address_screen.dart';
import 'package:provider/provider.dart';

import '../../../models/place.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Place data;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(data.id),
      direction: DismissDirection.up,
      background: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            child:
                Icon(Icons.delete, color: Theme.of(context).colorScheme.error)),
      ),
      confirmDismiss: (direction) => DeleteSystem().showDeleteDialog(
          context, Provider.of<AllPlaces>(context, listen: false), data),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.file(
                  data.image,
                  fit: BoxFit.cover,
                ),
                Material(
                  color: Colors.white.withOpacity(0.0),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        ItemAddressScreen.routeName,
                        arguments: data.id),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 25, left: 40),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      data.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                  ),
                )
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
