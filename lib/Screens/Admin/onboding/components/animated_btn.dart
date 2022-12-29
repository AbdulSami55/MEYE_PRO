import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/Screens/Admin/onboding/components/sign_in_dialog.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showCustomDialog(
        context,
      ),
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
