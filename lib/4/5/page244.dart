import 'package:flutter/material.dart';

void main() => runApp(MyApp()); // MyApp을 실행

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown, // 상단 색상
      ),
      home: BmiMain(),
    );
  }
}

class BmiMain extends StatefulWidget {
  @override
  _BmiMainState createState() {
    return _BmiMainState();
  }
}

class _BmiMainState extends State<BmiMain> {
  final _formKey = GlobalKey<FormState>(); // 폼의 상태를 얻기위한 키

  final _heightController = TextEditingController();  //입력 준비
  final _weightController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();    // 사용한 컨트롤러와 인스턴스는 화면이종료될때 반드시 dispose로 해제
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Container(
        color: Colors.yellow[50],
        padding: const EdgeInsets.all(16.0),
        child: Form(      // 키와몸무게를 받는 양식 전채를 form으로 감싼다
          key: _formKey,  // 키할당
          child: Column(
            children: <Widget>[
              TextFormField(
                cursorHeight: 30.0,
                cursorColor: Colors.red,
                decoration: InputDecoration(    // 클래스를설정 외곽선,힌트 등을 설정
                  border: OutlineInputBorder(),
                  hintText: '키',
                ),
                controller: _heightController,    // TextEditingController 인스턴스를 설정, 텍스트 필드를 소작할때 사용
                keyboardType: TextInputType.number,   // 입력타입을 제한
                validator: (value) {          // 입력값을 검증하고 에러메세지를 반환하도록 작성, 에러가없을경우 null을 반환
                  if (value.trim().isEmpty) {   //입력된값을 검증
                    return '키를 입력하세요';    // 에러메세지
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                cursorHeight: 30.0,
                cursorColor: Colors.red,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '몸무게',
                ),
                controller: _weightController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.trim().isEmpty) {
                    return '몸무게를 입력하세요';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 15.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // 키와 몸무계 값이 검증되었다면 화면이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BmiResult(
                                double.parse(_heightController.text.trim()),      // 입력된문자열을 double타입으로 변환
                                double.parse(_weightController.text.trim()))),
                      );
                    }
                  },
                  child: Text('결과'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BmiResult extends StatelessWidget {
  final double height;
  final double weight;

  BmiResult(this.height, this.weight);  // 키와몸무게르 생성자

  @override
  Widget build(BuildContext context) {
    final bmi = weight / ((height / 100) * (height / 100)); // BMI 값
    print('bmi : $bmi'); // 함수로 계산된 BMI값을 미리 확인할수있음

    return Scaffold(
      appBar: AppBar(title: Text('비만도 계산기')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _calcBmi(bmi), // 계산 결과에 따른 결과 문자열
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(
              height: 16,
            ),
            _buildIcon(bmi), // 결과에 따른 icon
          ],
        ),
      ),
    );
  }

  String _calcBmi(double bmi) {
    var result = '저체중';
    if (bmi >= 35) {
      result = '고도비만';
    } else if (bmi >= 30) {
      result = '2단계 비만';
    } else if (bmi >= 25) {
      result = '1단계 비만';
    } else if (bmi >= 23) {
      result = '과체중';
    } else if (bmi >= 18.5) {
      result = '정상';
    }
    return result;
  }

  Widget _buildIcon(double bmi) {
    if (bmi >= 23) {
      return Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 100,
      );
    } else if (bmi >= 18.5) {
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,
      );
    } else {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.orange,
        size: 100,
      );
    }
  }
}
