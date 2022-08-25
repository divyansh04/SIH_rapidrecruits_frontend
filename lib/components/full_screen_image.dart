import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String url;
  const FullScreenImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.clear_rounded,
                  size: 30,
                  color: Colors.black,
                ))
          ],
        ),
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Hero(
              tag: 'hero',
              child: PhotoView(
                  backgroundDecoration:
                  const BoxDecoration(color: Colors.white),
                  imageProvider: NetworkImage(url))),
        ));
  }
}