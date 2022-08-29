
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:flutter/material.dart';

class VerticalSlider extends StatefulWidget {
  const VerticalSlider({Key? key, required this.imageSliders, required this.imageList})
      : super(key: key);
  final List<Widget> imageSliders;
  final List<String> imageList;

  @override
  State<VerticalSlider> createState() => _VerticalSliderState();
}

class _VerticalSliderState extends State<VerticalSlider> {
  final CarouselController controller = CarouselController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      current = index;
                    });
                  }
              ),
              items: widget.imageSliders,
            ),
            kSmallHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    controller.animateToPage(entry.key);
                  },
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryColor.withOpacity(current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            )
          ],
        ));
  }
}
