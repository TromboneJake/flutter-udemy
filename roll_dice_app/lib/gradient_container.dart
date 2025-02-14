import 'package:flutter/material.dart';

import 'package:roll_dice_app/dice_roller.dart';
import 'package:roll_dice_app/styled_text.dart';

// import 'package:roll_dice_app/styled_text.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.colors, {super.key});

  final String text = 'You rolled a:';
  final List<Color> colors;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: startAlignment,
          end: endAlignment,
          colors: colors,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StyledText(text),
            DiceRoller(),
          ],
        ),
      ),
    );
  }
}
