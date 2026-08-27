import 'dart:collection';
import '../models/word.dart';
import '../models/hit_type.dart';

/// Gère l'état et la logique de la partie
class GameViewModel {
  static const int defaultMaxGuesses = 5;

  GameViewModel({this.maxGuesses = defaultMaxGuesses, this.seed})
      : _wordToGuess = _generateInitialWord(seed),
        _guesses = List<Word>.filled(maxGuesses, Word.empty());

  final int maxGuesses;
  final int? seed;
  Word _wordToGuess;
  List<Word> _guesses;

  Word get hiddenWord => _wordToGuess;
  UnmodifiableListView<Word> get guesses => UnmodifiableListView(_guesses);

  Word get previousGuess {
    final index = _guesses.lastIndexWhere((word) => word.isNotEmpty);
    return index == -1 ? Word.empty() : _guesses[index];
  }

  int get activeIndex => _guesses.indexWhere((word) => word.isEmpty);

  int get guessesRemaining {
    if (activeIndex == -1) return 0;
    return maxGuesses - activeIndex;
  }

  bool get didWin {
    if (_guesses.first.isEmpty) return false;
    for (final letter in previousGuess) {
      if (letter.type != HitType.hit) return false;
    }
    return true;
  }

  bool get didLose => guessesRemaining == 0 && !didWin;

  void resetGame() {
    _wordToGuess = _generateInitialWord(seed);
    _guesses = List<Word>.filled(maxGuesses, Word.empty());
  }

  Word guess(String guess) {
    final result = matchGuessOnly(guess);
    addGuessToList(result);
    return result;
  }

  

  Word matchGuessOnly(String guess) =>
      Word.fromString(guess).evaluateGuess(_wordToGuess);

  void addGuessToList(Word guess) {
    final guessIndex = activeIndex;
    if (guessIndex == -1) {
      throw StateError('No guesses remaining.');
    }
    _guesses[guessIndex] = guess;
  }

  static Word _generateInitialWord(int? seed) =>
      seed == null ? Word.random() : Word.fromSeed(seed);
}