import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class Hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'welcome to flutter', home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20);
  @override
  // ignore: override_on_non_overriding_member
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemBuilder: (ctx, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  @override
  // ignore: override_on_non_overriding_member
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Startup Name Generator'),
    ),
    body: _buildSuggestions(),
  );
}
}

void main() => runApp(Hello());
