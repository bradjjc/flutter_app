import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class Todo{   // 할 일 클래스
  bool isDone;
  String title;

  Todo(this.title, {this.isDone = false});
}

class MyApp extends StatelessWidget {   // 시작 클래스
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '할 일 관리',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {   // todolistpage 클래스
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {    // todListPage 의 State 클래스
  final _items =<Todo>[];   // 할일 목록을 저장할 리스트


  var _todoControllor = TextEditingController();
  
  @override
  void dispose(){
    _todoControllor.dispose();    // 사용이 끝나면 해제
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Query query =
    FirebaseFirestore.instance.collection('brad todo list');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('남은 할일'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _todoControllor,
                  ),
                ),
                ElevatedButton(
                  child: Text('추가'),
                  onPressed: () => _addTodo(Todo(_todoControllor.text)),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
              stream: query.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                final documents = snapshot.data.docs;
                return Expanded(
                    child: ListView(
                      children: documents.map((doc) => _buildItemWidget(doc)).toList(),
                    ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildItemWidget(DocumentSnapshot doc){  // 할 일 객체를 ListTile 형태로 변경하는 메서드
    final todo = Todo(doc['title'], isDone: doc['isDone']);
    return ListTile(
      onTap: () => _toggleTodo(todo),     // 완료/미완료
    title: Text(
      todo.title,
      style: todo.isDone    // 완료일때는 스타일 적용
        ? TextStyle(
        decoration: TextDecoration.lineThrough,   // 취소선
        fontStyle: FontStyle.italic,    // 이텔릭체
      )
          : null,     // 아무 스타일도 적용안함
    ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(todo), //삭제
      ),
    );
  }
  void _addTodo(Todo todo){   // 할 일 추가 메서드
    setState(() {
      _items.add(todo);
      _todoControllor.text = '';  // 할 일 입력 필드를 비움
    });
  }
  
  void _deleteTodo(Todo todo){    // 할 일 삭제 메서드
    setState(() {
      _items.remove(todo);
    });
  }
  
  void _toggleTodo(Todo todo){    // 할 일 완료/미완료 메서드
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}
