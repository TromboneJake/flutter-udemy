import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 3; // Variable to store result of rolling the dice
  var currentDice = 6; // Variable to store the number of sides on the dice
  final List<String> diceOptions = ['D4', 'D6', 'D8', 'D10', 'D12', 'D20'];
  String selected = 'D20';

  void rollDice() {
    setState(() {
      currentDice =
          int.parse(RegExp(r'\d+').firstMatch(selected)?.group(0) ?? '6');
      currentDiceRoll = randomizer.nextInt(currentDice) + 1;
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          // 'assets/images/dice-$currentDiceRoll.png',
          'assets/images/D$currentDice-$currentDiceRoll.png',
          width: 200,
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: rollDice,
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
                fontFamily: 'Inter', fontSize: 20, fontWeight: FontWeight.bold),
          ),
          child: const Text('Roll Dice'),
        ),
        SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: diceOptions.map((dice) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                    label: Text(dice),
                    labelStyle: TextStyle(
                        fontFamily: 'Inter', fontWeight: FontWeight.bold),
                    selected: selected == dice,
                    onSelected: (bool isSelected) {
                      setState(() {
                        selected = isSelected ? dice : 'D20';
                      });
                    }));
          }).toList(),
        ),
      ],
    );
  }
}
