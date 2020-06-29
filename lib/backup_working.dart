/*
This is a back up copy of the text displayer
* It changes color of the text on each hot reload
*I want it to change color when a button is pressed
*To implement this button we need a stateful widget,which i will try to
make in main .dart
 */

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(new BookBazaar());
}

class BookBazaar extends StatelessWidget {
  changeColor() {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Book App',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Book Bazaar'),
            actions: [
              IconButton(
                icon: Icon(Icons.color_lens), //added Icon on AppBar
                color: Colors.white, //chosen color white
                iconSize: 45.0,
                splashColor: Colors.amberAccent,
                onPressed: changeColor(),
              )
            ], //action
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TestText('Aryendra Singh', UniqueColorGenerator.getColor()),
                  SizedBox(
                    height: 12.0,
                  ),
                  TestText('Utkarsh Sinha', UniqueColorGenerator.getColor()),
                  SizedBox(height: 12.0),
                  TestText('Prateek Pandey', UniqueColorGenerator.getColor()),
                ], //children list ended
              ), //used Wrap instead of Column
            ),
          ),
        )); //MaterialApp
  }
}

class TestText extends StatelessWidget {
  final String text;
  final Color mycolor;

  TestText(this.text, this.mycolor);

  final _largeFonts = TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic);

  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: mycolor),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          text,
          style: _largeFonts,
        ),
      ),
    );
  }
}

class UniqueColorGenerator {
  static Random random = new Random(); //seeding the random method I guess

  static Color getColor() {
    return Color.fromARGB(
        125, random.nextInt(255), random.nextInt(255), random.nextInt(255));
    //ARGB: A is trasparency and RGB are 8 bit values
  }
}

class TextBlocks extends StatefulWidget {
  @override
  _TextBlocksState createState() =>
      _TextBlocksState(); //no need to add anything more in the Stateful widget itself
} //work on the state instead

class _TextBlocksState extends State<TextBlocks> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
