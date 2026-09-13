import 'package:flutter/material.dart';
import '../viewmodels/game_viewmodel.dart';
import '../widgets/tile.dart';
import '../widgets/guess_input.dart';
import '../widgets/keyboard_indicator.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameViewModel _game = GameViewModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var guess in _game.guesses)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var letter in guess)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2.5,
                      vertical: 2.5,
                    ),
                    child: Tile(letter.char, letter.type),
                  ),
              ],
            ),
          GuessInput(
            onSubmitGuess: (String guess) {
              setState(() {
                _game.guess(guess);
              });
            },
          ),
          KeyboardIndicator( getLetterStatus: _game.getLetterStatus, ),
        ],
        
      ),
    );
  }
 
}