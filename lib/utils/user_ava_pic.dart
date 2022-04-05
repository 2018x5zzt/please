
import 'package:flutter/material.dart';

import '../UserId_global.dart';

class UserAvatarImage extends StatelessWidget {
  final double size;
  final Color iconColor;

  UserAvatarImage(
      {required this.size,
        this.iconColor = const Color.fromRGBO(98, 103, 124, 1)});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Color.fromRGBO(98, 103, 124, 1),
      backgroundImage: NetworkImage(User_heading),
      child: SizedBox(width: size, height: size),
    );
  }
}