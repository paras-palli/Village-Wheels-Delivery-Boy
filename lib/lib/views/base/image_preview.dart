import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../services/theme.dart';
import 'custom_image.dart';
import 'poster_indicator.dart';

class ListingImagePreview extends StatefulWidget {
  const ListingImagePreview({super.key, required this.images});
  final List<String> images;

  @override
  State<ListingImagePreview> createState() => _ListingImagePreviewState();
}

class _ListingImagePreviewState extends State<ListingImagePreview> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: backgroundDark),
        title: const Text('Images'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 380,
                    viewportFraction: 1,
                    autoPlay: true,
                    enableInfiniteScroll: widget.images.length > 1 ? true : false,
                    onPageChanged: (index, reason) {
                      selectedIndex = index;
                      setState(() {});
                    }),
                items: widget.images.map((selectedImage) {
                  return Builder(
                    builder: (BuildContext context) {
                      return CustomImage(
                        viewFullScreen: true,
                        path: selectedImage,
                        radius: 0,
                        fit: BoxFit.fill,
                        height: 380,
                        width: size.width,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var v = 0; v < widget.images.length; v++)
                  PosterIndicator(
                    isActive: selectedIndex == v ? true : false,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
