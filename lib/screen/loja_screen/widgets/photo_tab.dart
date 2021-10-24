import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:topxadrez/controllers/loja_controller.dart';

class PhotoTab extends StatelessWidget {
  const PhotoTab({Key? key}) : super(key: key);

  Widget generateClipedPhoto(String image) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Image(
            image: CachedNetworkImageProvider(image),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: context
          .read<LojaController>()
          .currentProduc!
          .images!
          .map((e) => generateClipedPhoto(e))
          .toList(),
    );
  }
}
