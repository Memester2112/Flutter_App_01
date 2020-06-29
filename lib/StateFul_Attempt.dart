/*
This is a back up copy of the text displayer
* It changes color of the text on each hot reload
*I want it to change color when a button is pressed
*To implement this button we need a stateful widget,which i will try to
make in main .dart
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math'; //for the random function used in UniqueColorgenerator

void main() {
  runApp(new TrialApp());
}

var name = [
  'Aryendra Singh',
  'Utkarsh Sinha',
  'Prateek Pandey',
  'Parth Mall',
  'Arnesh Issar',
  'Ayush Akarsh'
];
final name1 = 'Aryendra Singh';
final name2 = 'Utkarsh Sinha';
final name3 = 'Prateek Pandey';
final name4 = 'Parth Mall';
final name5 = 'Arnesh Issar';
final name6 = 'Ayush Akarsh';

class TrialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trial App',
      theme: ThemeData(
        primaryColor: Colors.indigoAccent,
      ),
      debugShowCheckedModeBanner: false,
      home: TextBlocks(),
    );
  }
}

class TestText extends StatelessWidget {
  final String text;
  final Color mycolor = UniqueColorGenerator.getColor();

  TestText(this.text);

  final _largeFonts = TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(color: mycolor),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: _largeFonts,
              ),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
        ],
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
  Widget displayNames() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [for (String x in name) TestText(x)],
    );
  }

  void changeColor() {
    setState(() {});
  }

  String result = 'Ooops!\nYou have not entered anything!';

  void userName() {
    setState(() {});
    myFocusNode.requestFocus();
  }

  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  void openChatBox() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('CHATBOX'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  //user name text field
                  autofocus: true,
                  onEditingComplete: userName,
                  onSubmitted: (String str) {
                    setState(() {
                      result = str;
                    });
                  },
                  decoration: InputDecoration(
                    enabled: true, //enables/disables the writing field
                    focusColor: Colors.orange,
                    hintText: 'Enter your name',
                    icon: Icon(
                      Icons.perm_identity,
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextField(
                  //password text field
                  focusNode: myFocusNode,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Enter your password",
                      icon: Icon(
                        Icons.security,
                        color: Colors.blueAccent,
                      )),
                ),
                Text('The User name chosen by you is :'),
                Text(result),
              ],
            ),
          );
        },
      ),
    );
  }

  Drawer drawerMethod() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'This is the Drawer Head',
              style: TextStyle(fontSize: 55.0),
            ),
            decoration: BoxDecoration(
              color: Colors.greenAccent,
            ),
            duration: const Duration(milliseconds: 5000),
            curve: Curves.decelerate,
          ),
          ListTile(
            title: TestText(name[0]),
            onTap: () {
              Navigator.pop(context);
            },
            onLongPress: () {
              setState(() {});
            },
          ),
          ListTile(
            title: TestText(name[1]),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: TestText(name[2]),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: TestText(name[3]),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  String comicUrl;

  String getUrl() {
    String url = 'http://images.ucomics.com/comics/ga/';
    final random = new Random();
    int year =
        random.nextInt(41) + 1979; //gives a random year between 1979 and 2019
    //Although the comic began in 1978 19th June but it will be a task to fill that special case:
    url = url + year.toString() + '/ga';
    year = year % 100;
    if (year == 0)
      url = url + '00';
    else if (year >= 1 && year <= 9)
      url = url + '0' + year.toString();
    else
      url = url + year.toString();

    var arr = [
      0,
      31,
      28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ]; //corresponding months, the 0 is to off set by the month number as[1-12]
    int month = random.nextInt(12) + 1; //gives numbers in the ranges 1 to 12
    int day = random.nextInt(arr[month]) + 1;
    if (month <= 9)
      url = url + '0' + month.toString();
    else
      url = url + month.toString();
    if (day <= 9)
      url = url + '0' + day.toString();
    else
      url = url + day.toString();

    url = url + '.gif';

    return url;
  }

  void refresh() {
    Navigator.of(context).pop();
    displayImage();
  }

  void displayImage() {
    comicUrl = getUrl();

    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return Scaffold(
          floatingActionButton: IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.purpleAccent,
              size: 45.0,
            ),
            onPressed: refresh,
          ),
          appBar: AppBar(
            title: Text('COMICS:'),
            bottom: PreferredSize(
              child: TestText('RANDOM GARFIELD COMIC FROM [1979-2019]'),
              preferredSize: Size.fromHeight(60.0),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (Image(
                height: 400.0,
                width: 400.0,
                image: NetworkImage(comicUrl),
              )),
              Text(
                'Image URL IS :\n' + comicUrl,
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
          icon: Icon(
            Icons.account_circle,
          ),
          color: Colors.pink[200],
          onPressed: openChatBox,
        ),
        appBar: AppBar(
          title: Text('Trial App'),
          actions: [
            IconButton(
                icon: Icon(Icons.whatshot),
                color: Colors.amber,
                iconSize: 45.0,
                splashColor: Colors.amberAccent,
                onPressed: changeColor),
            IconButton(
              icon: Icon(Icons.image),
              color: Colors.red,
              iconSize: 30.0,
              splashColor: Colors.pinkAccent,
              onPressed: displayImage,
            ),
          ],
        ),
        drawer: drawerMethod(),
        body: SafeArea(
          child: Center(
            child: displayNames(),
          ),
        ));
  }
}
