import 'dart:io';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:flutter/material.dart';

enum ImageSourceType { file, network, asset }

class ViewImageDialog extends StatelessWidget {
  final dynamic image;
  final ImageSourceType sourceType;
  final String? title;

  const ViewImageDialog({
    super.key,
    required this.image,
    required this.sourceType,
    this.title,
  });

  String _getFileName() {
    switch (sourceType) {
      case ImageSourceType.file:
        return (image as File).path.split(Platform.pathSeparator).last;
      case ImageSourceType.network:
        final uri = Uri.tryParse(image as String);
        return uri?.pathSegments.last ?? 'image';
      case ImageSourceType.asset:
        return image.toString().split('/').last;
    }
  }

  ImageProvider _getImageProvider() {
    switch (sourceType) {
      case ImageSourceType.file:
        return FileImage(image as File);
      case ImageSourceType.network:
        return NetworkImage(image as String);
      case ImageSourceType.asset:
        return AssetImage(image as String);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = title ?? _getFileName();

    return Scaffold(
      backgroundColor: ColorsValue.background,
      appBar: AppBarBase(
        title: fileName,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            child: Image(
              image: _getImageProvider(),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showViewImageDialog({
  required BuildContext context,
  required dynamic image,
  required ImageSourceType sourceType,
  String? title,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ViewImageDialog(
        image: image,
        sourceType: sourceType,
        title: title,
      ),
      fullscreenDialog: true,
    ),
  );
}
