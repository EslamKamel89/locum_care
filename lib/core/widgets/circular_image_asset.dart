import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/themes/theme_cubit.dart';
import 'package:locum_care/core/widgets/custom_fading_widget.dart';

class CircularImageAsset extends StatelessWidget {
  const CircularImageAsset({
    super.key,
    required this.image,
    required this.height,
    this.boxFit,
    this.horizontalPadding,
  });

  final String image;
  final double height;
  final BoxFit? boxFit;
  final double? horizontalPadding;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
        child: Image.asset(image, fit: boxFit ?? BoxFit.fitHeight),
      ),
    );
  }
}

class CircularLogo extends StatelessWidget {
  const CircularLogo({
    super.key,
    required this.image,
    required this.height,
    this.boxFit,
    this.horizontalPadding,
  });

  final String image;
  final double height;
  final BoxFit? boxFit;
  final double? horizontalPadding;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeCubit>().isDarkMode();
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDarkMode ? context.primaryColor : context.primaryColor.withOpacity(0.8),
        ),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0),
        child: Image.asset(image, fit: boxFit ?? BoxFit.fitHeight),
      ),
    );
  }
}

class CircularCachedImage extends StatelessWidget {
  const CircularCachedImage({
    super.key,
    required this.imageUrl,
    required this.imageAsset,
    required this.height,
    this.width,
  });

  final String imageUrl;
  final String imageAsset;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        // padding: EdgeInsets.symmetric(vertical: 5.h),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn),
                ),
              ),
            );
          },
          placeholder: (context, url) => CustomFadingWidget(child: Image.asset(imageAsset)),
          errorWidget: (context, url, error) => Image.asset(imageAsset),
        ),
      ),
    );
  }
}

class CircularImageFile extends StatelessWidget {
  const CircularImageFile({super.key, required this.image, required this.height, this.width});

  final File image;
  final double height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        // padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Image.file(image, fit: BoxFit.cover),
      ),
    );
  }
}
