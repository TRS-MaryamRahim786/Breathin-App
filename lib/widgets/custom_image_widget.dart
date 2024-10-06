import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:breathin_app/widgets/basic_circular_progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utilities/helpers/app_fonts.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const CustomImageWidget({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? "",
        placeholder: (context, url) => const Center(
          child: BasicCircularProgressIndicator(height: 19, width: 19),
        ),
        filterQuality: FilterQuality.high,
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          color: AppColors.grey,
          size: 30,
        ),
        width: width,
        fit: BoxFit.cover,
        height: height,
      ),
    );
  }
}
