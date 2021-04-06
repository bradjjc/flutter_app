import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  var _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '복잡한 UI',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,

        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '이용서비스',
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            label: '내정보',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final dummyItems = [
    'https://www.topdaily.kr/news/photo/202008/73063_40289_292.jpg',
    'https://spnimage.edaily.co.kr/images/photo/files/NP/S/2020/10/PS20100800026.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/4/4a/191215_tvN_%EC%A6%90%EA%B1%B0%EC%9B%80%EC%A0%84_%ED%98%B8%ED%85%94%EB%8D%B8%EB%A3%A8%EB%82%98_%ED%86%A0%ED%81%AC%EC%84%B8%EC%85%98_%EC%95%84%EC%9D%B4%EC%9C%A0_%286%29.jpg',
    'https://img9.yna.co.kr/etc/inner/KR/2020/01/03/AKR20200103136600005_01_i_P4.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildTop(),
        _buildMiddle(),
        _buildBottom(),
      ],
    );
  }

  Widget _buildTop() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                print('클릭');
                _showDialog();
              },
              child: Column(children: [
                Image.network(
                  'https://image.flaticon.com/icons/png/512/89/89131.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Text('택시'),
              ]),
            ),
            Column(children: [
              Image.network(
                'https://image.flaticon.com/icons/png/512/89/89131.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Text('택시'),
            ]),
            Column(children: [
              Image.network(
                'https://image.flaticon.com/icons/png/512/89/89131.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Text('택시'),
            ]),
            Column(children: [
              Image.network(
                'https://image.flaticon.com/icons/png/512/89/89131.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Text('택시'),
            ]),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                print('클릭');
              },
              child: Column(children: [
                Image.network(
                  'https://image.flaticon.com/icons/png/512/89/89131.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                Text('택시'),
              ]),
            ),
            Column(children: [
              Image.network(
                'https://image.flaticon.com/icons/png/512/89/89131.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Text('택시'),
            ]),
            Column(children: [
              Image.network(
                'https://image.flaticon.com/icons/png/512/89/89131.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Text('택시'),
            ]),
            Opacity(
              opacity: 0.0,
              child: Column(
                children: [
                  Image.network(
                    'https://image.flaticon.com/icons/png/512/89/89131.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  Text('택시'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMiddle() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 350.0,
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
      ), // 높이 400
      items: dummyItems.map((url) {
        // 5페이지
        return Builder(
          builder: (BuildContext context) {
            //context사용
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildBottom() {
    final items = List.generate(10, (i) {
      return ListTile(
        leading: Icon(Icons.notifications_none),
        title: Text('[이벤트] 이것은 공지사항입니다'),
      );
    });

    return ListView(
      physics: NeverScrollableScrollPhysics(),  // 이 리스트의 스크롤 동작금지
      shrinkWrap: true,   // 이 리스트가 다른 스크롤 객체 안에 있다면 true로 설정해야함
      children: items,
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Click Close!"),
          actions: <Widget>[
            TextButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '이용서비스',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '내 정보',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
