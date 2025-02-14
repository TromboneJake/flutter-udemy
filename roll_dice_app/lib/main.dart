import 'package:flutter/material.dart';

import 'package:roll_dice_app/gradient_container.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: GradientContainer([Color(0xFFC621E5), Color(0xFF7D7CF9)]),
      ),
    ),
  );
}
