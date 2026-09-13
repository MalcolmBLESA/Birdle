import 'package:flutter/material.dart';
import '../models/hit_type.dart';

class Tile extends StatelessWidget {
  const Tile(this.letter, this.hitType, {super.key, this.size = 60.0});

  final String letter;
  final HitType hitType;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: switch (hitType) {
          HitType.hit => Colors.green,
          HitType.miss => Colors.grey,
          HitType.partial => Colors.orange,
          _ => Colors.white,
        },
      ),
      child: Center(
        child: Text(
          letter.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: size * 0.5,
        ),
      ),
    ),
  );
 }
}