// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StartUp Name Generator',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];//suggestion is the main infinite scrolling list
  final _biggerFonts = TextStyle(fontSize: 26.0);
  final _saved = Set<WordPair>();//saved stores the favourite words

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd)//alternatively adding a wordpair and  a divider for aesthetic purposes
            return Divider(
              color: Colors.amber,
            );
          final index = i ~/ 2;// ~/ is the int divide in dart
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));//this widget handles as the when and how many to generate
          }//it works on the itemBuilder to create the infinite scrolling list I suppose
          return _buildRow(_suggestions[index]);//widget itself is returning another widget
        });
  }

  Widget _buildRow(WordPair pair) {//build row takes a index position of the suggestions list which contains a wordPair
    final alreadySaved = _saved.contains(pair);//bool type is true if the pair is in the Set saved
    return ListTile(//List of tiles containing text
      title: Text(//creating the tiles
        pair.asPascalCase,//changing case of the pair
        style: _biggerFonts,//changing font style
      ),
      trailing: /* Trailing means add at the end of the row or tile*/
      Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,//icon type
        // This is like a ternary operation
        //if the pair is already saved then the Icon Favorite is displayed, other wise display Icon favorite_border
        color: alreadySaved//color of icon
            ? Colors.red
            : null, //same ternary logic for filling in the color
        //favorite border probably cannot be filled with color
      ),
      onTap: () {//functionality of when button is pressed
        setState(() {//setState() call build once again
          if (alreadySaved) {//This adds the pair if it is not already saved
            _saved.remove(pair);//and removes it from the set if it was already saved
          } else {
            _saved.add(pair);
          }
        }); //setState() triggers a call to the build() method for the state object,resulting in updating of UI
      },
    );
  }//_buildRow finished

  void _pushSaved() {//functionality for when the next page button is pressed
    Navigator.of(context).push(//navigator maintains a stack of pages, we are pushing a new one on the stack
      MaterialPageRoute<void>(
        builder: (BuildContext context)
        {
          final tiles = _saved.map(//creates a map of the Set
            (WordPair pair) {//I guess it takes a pair from the map
              return ListTile(//and creates a list of tiles out of it
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFonts,
                ),
              );
            }, //(WordPair pair)
          ); //map
          final divided = ListTile.divideTiles(//divide tiles adds one pixel border between each tile
            context: context,//required context
            tiles: tiles,//iterable <Widget> tiles
            color: Colors.red,

          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Startup Name Generator'),
          actions: [
            // NEW lines from here...
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          ], // ... to here.
        ),
        body: SafeArea(
          child: _buildSuggestions(),

        )
    );
  }
}
