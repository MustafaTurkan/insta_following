import 'package:flutter/material.dart';
import 'package:insta_following/helpers/app_img.dart';

class NetworkImgWithLoading extends StatelessWidget {
  const NetworkImgWithLoading({Key key, this.width = 120, this.height = 120, @required this.imageUrl})
      : super(key: key);

  final double width;
  final double height;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      fit: BoxFit.cover,
      width: 110,
      height: 110,
      placeholder: AppImage.loadingNetworkImage,
      image: imageUrl,
    );
  }
}
