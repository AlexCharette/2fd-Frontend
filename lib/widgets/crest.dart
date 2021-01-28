import 'package:flutter/material.dart';
import 'package:regimental_app/config/routes.dart';

class Crest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Image(
            image: AssetImage('assets/images/crest_md.png'),
            width: 40,
            fit: BoxFit.cover,
          ),
        ),
        onTap: () => Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (Route<dynamic> route) => false));
  }
}
