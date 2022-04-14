import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CaraouselListStyle extends StatelessWidget {
  const CaraouselListStyle({
    Key? key,
    required this.exampleData,
  }) : super(key: key);

  final List<String> exampleData;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: exampleData.length,
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return Card(
              child:
                  Center(child: Text("${exampleData[itemIndex]} - $itemIndex")),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)));
        },
        options: CarouselOptions(
          disableCenter: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 2),
          enlargeStrategy: CenterPageEnlargeStrategy.scale,
          enlargeCenterPage: true,
        ));
  }
}
