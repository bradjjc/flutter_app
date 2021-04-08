import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: StopWatchPage(),
    );
  }
}

class StopWatchPage extends StatefulWidget {
  @override
  _StopWatchPageState createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {
  Timer _timer; // 타이머

  var _time = 0; // 0.01초마다 1씩증가시킬 정수형 변수
  var _isRunning = false; // 현제 시작 상태를 나타낼 불리언 변수

  List<String> _lapTimes = []; // 랩타임에 표시할 시간을 저장할 라스트

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StopWatch'),
      ),
      body: _buildBody(),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black12,
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _clickButton();
        }),
        child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    //내용부분
    var sec = _time ~/ 100; // 초
    var hundredth = '${_time % 100}'.padLeft(2, '0'); // 1/100 초


    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(    // 시간을 표시하는 영역
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      '$sec', // 초
                      style: TextStyle(fontSize: 50.0),
                    ),
                    Text('$hundredth'), // 1/100초
                  ],
                ),
                Container(    // 랩타임을 표시하는 영역
                  width: 100,
                  height: 200,
                  child: ListView(
                    children: _lapTimes.map((time) => Text(time)).toList(),
                  ),
                )
              ],
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: FloatingActionButton(    // 왼쪽아래에 위치한 초기화버튼
                // 왼쪽 아래에 위치한 초기화버튼
                backgroundColor: Colors.blueGrey,
                onPressed: _reset, // reset 메서드 실행
                child: Icon(Icons.rotate_left),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: ElevatedButton(    // 오른쪽아래에 위치한 타임랩 버튼
                onPressed: () {
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
                child: Text('랩타임'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _clickButton() {
    // 시작또는 일시정지 버튼
    _isRunning = !_isRunning;
    if (_isRunning) {
      _start(); // 뒤에서 작성
    } else {
      _pause(); // 뒤에서 작성
    }
  }

  // 1/100초에 한번씩 time 변수를 1 증가
  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      // 할 일
      setState(() {
        _time++;
      });
    });
  }

  // 타이머 취소
  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _lapTimes.clear();
      _time = 0;
    });
  }

  void _recordLapTime(String time) {
    _lapTimes.insert(0, '${_lapTimes.length + 1}등. $time');
  }
}
