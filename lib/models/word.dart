import 'dart:collection';
import 'dart:math';
import '../data/dictionary.dart';
import 'hit_type.dart';
import 'letter.dart';

/// Un mot de 5 lettres composé d'objets [Letter].
class Word with IterableMixin<Letter> {
  Word(this._letters);

  factory Word.empty() =>
      Word(List<Letter>.filled(5, (char: '', type: HitType.none)));

  factory Word.fromString(String guess) {
    if (guess.length != 5) {
      throw ArgumentError.value(
        guess,
        'guess',
        'Must be exactly 5 characters long.',
      );
    }
    final letters = guess
        .toLowerCase()
        .split('')
        .map((char) => (char: char, type: HitType.none))
        .toList();
    return Word(letters);
  }

  factory Word.random() {
    final random = Random();
    final nextWord = legalWords.toList()[random.nextInt(legalWords.length)];
    return Word.fromString(nextWord);
  }

  factory Word.fromSeed(int seed) =>
      Word.fromString(legalWords.toList()[seed % legalWords.length]);

  final List<Letter> _letters;

  @override
  Iterator<Letter> get iterator => _letters.iterator;

  @override
  bool get isEmpty => every((letter) => letter.char.isEmpty);

  @override
  int get length => _letters.length;

  Letter operator [](int i) => _letters[i];

  @override
  String toString() => _letters.map((letter) => letter.char).join().trim();

  String toStringVerbose() => _letters
      .map((letter) => '${letter.char} - ${letter.type.name}')
      .join('\n');
}

extension WordUtils on Word {
  
  Word evaluateGuess(Word hiddenWord) {
    final result = List<Letter>.filled(length, (char: '', type: HitType.none));
    final unmatchedHiddenLetterCounts = <String, int>{};

    for (var i = 0; i < length; i++) {
      final guessChar = this[i].char;
      final hiddenChar = hiddenWord[i].char;

      if (guessChar == hiddenChar) {
        result[i] = (char: guessChar, type: HitType.hit);
      } else {
        final unmatchedCount = unmatchedHiddenLetterCounts[hiddenChar] ?? 0;
        unmatchedHiddenLetterCounts[hiddenChar] = unmatchedCount + 1;
      }
    }

    for (var i = 0; i < length; i++) {
      if (result[i].type == HitType.hit) continue;

      final guessChar = this[i].char;
      final unmatchedCount = unmatchedHiddenLetterCounts[guessChar] ?? 0;
      final isPartial = unmatchedCount > 0;

      if (isPartial) {
        unmatchedHiddenLetterCounts[guessChar] = unmatchedCount - 1;
      }

      result[i] = (
        char: guessChar,
        type: isPartial ? HitType.partial : HitType.miss,
      );
    }
    return Word(result);
  }
}