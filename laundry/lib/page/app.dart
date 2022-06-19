import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({ Key? key }) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('App')),
      backgroundColor: Color(0xffF3F2F8),
      body: Center( 
        child: Text('App Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}