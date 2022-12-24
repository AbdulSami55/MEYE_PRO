import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    Key? key,
    required this.press,
  }) : super(key: key);
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 236,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: const Offset(0, 7),
                        blurRadius: 7,
                        spreadRadius: 3)
                  ]),
            ),
            Positioned.fill(
              top: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.arrow_right),
                  const SizedBox(width: 8),
                  Text(
                    "Let's Start",
                    style: Theme.of(context).textTheme.button,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
