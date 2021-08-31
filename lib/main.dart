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
  final _saved = <WordPair>{};
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
    final alreadSaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadSaved ? Icons.favorite : Icons.favorite_border,
        color: alreadSaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadSaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void _pushSaved() {
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (BuildContext ctx) {
        final tiles = _saved.map((WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        });
        final divided = ListTile.divideTiles(
          context: ctx,
          tiles: tiles,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('Saved suggestions'),
          ),
          body: ListView(children: divided,),
        );
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Startup Name Generator'),
  //     ),
  //     body: _buildSuggestions(),
  //   );
  // }
}

void main() => runApp(Hello());
