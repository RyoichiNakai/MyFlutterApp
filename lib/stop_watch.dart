import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  String _stopTimeToDisplay = '00:00';
  Stopwatch swatch = new Stopwatch();
  final dur = const Duration(milliseconds: 1);

  void _startTimer() {
    Timer(dur, _keepRunning);
  }

  void _keepRunning() {
    if (swatch.isRunning) {
      _startTimer();
    }
    setState(() {
      _stopTimeToDisplay =
          (swatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') + '.' +
              ((swatch.elapsed.inMilliseconds % 1000) / 10).floor().toString().padLeft(2, '0');
    });
  }

  void _startStopWatch() {
    swatch.start();
    _startTimer();
  }

  void _stopStopWatch() {
    swatch.stop();
  }

  void _resetStopWatch() {
    swatch.reset();
    setState(() {
      _stopTimeToDisplay = '00:00';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('stopwatch Test')),
      body: Align(
        alignment: Alignment(0, 0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                child: Text('$_stopTimeToDisplay',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                child: Text(
                  'start',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  _startStopWatch();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                child: Text('stop',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  _stopStopWatch();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                child: Text('reset',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                color: Colors.blue,
                onPressed: () {
                  _resetStopWatch();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
