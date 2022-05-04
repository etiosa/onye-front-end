
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GenericLoadingContainer extends StatelessWidget {
  final double height;
  final double width;
  const GenericLoadingContainer({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        height: height,
        width: width,
        color: Colors.amberAccent,
      ),
    );
  }
}
