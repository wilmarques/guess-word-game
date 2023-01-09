import 'package:flutter/widgets.dart';

import 'models/word.dart';
import 'repositories/word_repository.dart';

class AppState {
  const AppState({
    required this.loadedWords,
    required this.loading,
    this.currentWord,
  });

  final Set<Word> loadedWords;
  final bool loading;
  final Word? currentWord;

  AppState copyWith({
    Set<Word>? loadedWords,
    bool? loading,
    Word? currentWord,
  }) {
    return AppState(
      loadedWords: loadedWords ?? this.loadedWords,
      loading: loading ?? this.loading,
      currentWord: currentWord ?? this.currentWord,
    );
  }
}

class AppStateScope extends InheritedWidget {
  const AppStateScope(this.data, {Key? key, required Widget child})
      : super(key: key, child: child);

  final AppState data;

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data != oldWidget.data;
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget({required this.child, Key? key}) : super(key: key);

  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  AppStateWidgetState createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  final _wordRepository = const WordRepository();

  AppState _data = const AppState(
    loadedWords: {},
    loading: true,
  );

  Future<void> loadWord() async {
    if (_data.loading == false) {
      setState(() {
        _data = _data.copyWith(loading: true);
      });
    }

    // TODO (next): Randomize next word based on some API
    const word = 'child';
    final wordDefinition = await _wordRepository.loadWord(word);

    final Set<Word> loadedWords = Set<Word>.from(_data.loadedWords);
    loadedWords.add(wordDefinition);

    setState(() {
      _data = _data.copyWith(
        loadedWords: loadedWords,
        currentWord: wordDefinition,
        loading: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppStateScope(
      _data,
      child: widget.child,
    );
  }
}
