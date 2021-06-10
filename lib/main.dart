import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String msecText = "";
  Color myColor = Color(0);
  GameState gameState = GameState.ReadyToStart;
  Timer? waitingTimer;
  Timer? stoppableTimer;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff282e3d),
      body: Stack(
        children: [
          Align(alignment: const Alignment(0, -0.8),child: Text("Test your \nreaction speed",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.white),
          )
          ),
          Align(alignment: Alignment.center,
            child: ColoredBox(
              color: Color(0xff6d6d6d),
              child: SizedBox(
                height: 160,
                width: 250,
                child: Center(
                  child: Text(msecText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Align
            (alignment: const Alignment(0, 0.8),
              child: GestureDetector(
                onTap: () => setState((){
                  switch(gameState){
                    case GameState.ReadyToStart:

                      gameState = GameState.Waiting;
                      msecText = "";
                      _startWaitingTimer();
                      break;
                    case GameState.Waiting:

                      break;
                    case GameState.StopIt:

                      gameState = GameState.ReadyToStart;
                      stoppableTimer?.cancel();
                      break;}
                }),
                child: ColoredBox(
                  color: _mycolor(),
                  child: SizedBox(
                    height: 110,
                    width: 170,
                    child: Center(
                      child: Text(
                        _getButtonText(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
          )],
      ),

    );
  }
  String _getButtonText()
  {
    switch(gameState){
      case GameState.ReadyToStart:
        return "START";
        break;
      case GameState.Waiting:
        return "WAIT";
        break;
      case GameState.StopIt:
        return "STOP";
        break;}
  }

  void _startWaitingTimer() {
    final int randomMlscs = Random().nextInt(4000) + 1000;
    waitingTimer =  Timer(Duration(milliseconds: randomMlscs), (){
      setState(() {
        gameState = GameState.StopIt;
      });
      _startStoppableTimer();
    });
  }

  void _startStoppableTimer() {
    stoppableTimer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        msecText = "${timer.tick * 16} ms";
      });

    });
  }

  @override
  void dispose() {
    waitingTimer?.cancel();
    stoppableTimer?.cancel();
    super.dispose();
  }
  Color _mycolor() {
    switch (gameState) {
      case GameState.ReadyToStart:
        return Color(0xFF40CA88);

      case GameState.Waiting:
        return Color(0xFFE0982D);

      case GameState.StopIt:
        return Color(0xFFE02D47);
    }
  }

}

enum GameState { ReadyToStart, Waiting, StopIt}
