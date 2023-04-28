import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const Text(
          //   "LOGIN",
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // ),
          // const SizedBox(height: kDefaultPedding * 1),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: SvgPicture.asset(
                  "assets/icons/login.svg",
                  // height: 100.0,
                  // width: 100.0,
                  // allowDrawingOutsideViewBox: true,
                ),
              ),
              const Spacer(),
            ],
          ),
          // const SizedBox(height: kDefaultPedding * 1),
        ],
      ),
    );
  }
}
