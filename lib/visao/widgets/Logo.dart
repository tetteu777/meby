import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      fit: BoxFit.fitHeight,
      image: AssetImage('assets/images/MeetBy-PNG-azul_horizontal.png', ),
    );
  }
}
