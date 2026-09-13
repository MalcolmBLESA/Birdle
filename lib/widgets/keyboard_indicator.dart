import 'package:flutter/material.dart';
import '../models/hit_type.dart';
import 'tile.dart';

class KeyboardIndicator extends StatelessWidget {
  final HitType Function(String) getLetterStatus;

  const KeyboardIndicator({super.key, required this.getLetterStatus});

  Widget _buildKeyboardRow(List<String> letters) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: letters.map((letter) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 3.0),
          child: Tile(
            letter, 
            getLetterStatus(letter),
            size: 32.0,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    const row1 = ['A', 'Z', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
    const row2 = ['Q', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M'];
    const row3 = ['W', 'X', 'C', 'V', 'B', 'N'];

    return Container(
      margin: const EdgeInsets.only(top: 1.0),
      padding: const EdgeInsets.all(0.5),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildKeyboardRow(row1),
          _buildKeyboardRow(row2),
          _buildKeyboardRow(row3),
        ],
      ),
    );
  }
}