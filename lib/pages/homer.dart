import 'package:flutter/material.dart';
import 'package:kwikee1/themes/apptheme.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,  this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title.toString(),
          style: TextStyle(
            color: theme.accentColor,
          ),
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.brightness_4_rounded),
          //   onPressed: () {
          //     currentTheme.toggleTheme;
          //   },
          // ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Fluter Themes Demo',
            ),
          ],
        ),
      ),
    );
  }
}
