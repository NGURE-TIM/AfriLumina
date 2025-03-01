import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final String imageAltText;
  final double height;
  final double width;
  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    required this.imageAltText,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          height: height,
          width: width,
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child:
                  Container(height: height, width: width, color: Colors.white),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: height,
              width: double.infinity,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: imageAltText.isNotEmpty
                  ? Text(
                      imageAltText,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    )
                  : const Icon(Icons.image_not_supported,
                      color: Colors.black45, size: 40),
            );
          },
        ),
      ],
    );
  }
}
