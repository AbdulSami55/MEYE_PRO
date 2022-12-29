import 'dart:ui';

import 'package:flutter/material.dart';

import 'components/animated_btn.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({super.key});

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  bool isShowSignInDialog = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/Backgrounds/logo.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          // const RiveAnimation.asset(
          //   "assets/RiveAssets/shapes.riv",
          // ),
          // Positioned.fill(
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          //     child: const SizedBox(),
          //   ),
          // ),
          Positioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(
                        children: const [
                          Text(
                            "MEYE PRO WITH \nTIMETABLE",
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    const AnimatedBtn(),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
