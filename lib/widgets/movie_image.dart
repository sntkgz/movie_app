import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

Widget movieImage(String? url) {
  try {
    return ExtendedImage.network(
      url ?? '',
      fit: BoxFit.cover,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Center(
              child: CircularProgressIndicator(),
            );

          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              fit: BoxFit.cover,
            );

          case LoadState.failed:
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/images/placeholder.png'),
                    fit: BoxFit.fill),
              ),
            );
        }
      },
    );
  } catch (e) {
    debugPrint('error :$e');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage('assets/images/placeholder.png'),
            fit: BoxFit.cover),
      ),
    );
  }
}
