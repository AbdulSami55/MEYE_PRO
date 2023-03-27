import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget apploading(BuildContext context) => Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
        ),
        const Center(child: CircularProgressIndicator()),
      ],
    );

Widget appShimmer(double width, double height) => Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
