import 'package:flutter/material.dart';

class GuessInput extends StatelessWidget {
  GuessInput({super.key, required this.onSubmitGuess});

  final void Function(String) onSubmitGuess;
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _onSummit() {
    onSubmitGuess(_textEditingController.text.trim());
    _textEditingController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          padding: const EdgeInsets.all(8.0),
          icon: const Icon(Icons.arrow_circle_up),
          onPressed: () {
            _onSummit();
          },
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 0.0),
            child: TextField(
              maxLength: 5,
              cursorColor: const Color.fromARGB(255, 51, 142, 6),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 51, 142, 6),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 51, 142, 6),
                    width: 3.0,
                  ),
                ),
              ),
              controller: _textEditingController,
              autofocus: true,
              focusNode: _focusNode,
              onSubmitted: (input) {
                _onSummit();
              },
            ),
          ),
        ),
      ],
    );
  }
}