// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// void main()  async{
//   WidgetsFlutterBinding.ensureInitialized(); // 사전준비가 필요한 코드 (파이어베이스)
//   await Firebase.initializeApp(); // 초기화를 하는 코드
//   runApp(MyApp());
// }
// //할 일 클래스
// class Todo {
//   bool isDone;
//   String title;
//   Todo(this.title, {this.isDone = false});
// }
// //시작 클래스
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '할 일 관리',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: TodoListPage(),
//     );
//   }
// }
// class TodoListPage extends StatefulWidget {
//   @override
//   _TodoListPageState createState() => _TodoListPageState();
// }
// class _TodoListPageState extends State<TodoListPage> {
//   //할 일 목록을 저장할 리스트
//   final _items = <Todo>[];
// //할 일 문자열 조작을 위한 컨트롤러
//   var _todoController = TextEditingController();
//   @override
//   void dispose() {
//     _todoController.dispose(); //사용이 끝나면 해제
//     super.dispose();
//   }
//   //할 일 추가 메서드
//   Future<void> _addTodo(Todo todo) async {
//     //콜백 callback방식
//     //promise
//     //단점 : 콜백지옥에 빠질수있다.
//     CollectionReference query = FirebaseFirestore.instance.collection('todo');
//     DocumentReference value = await query.add({
//       'title':todo.title,
//       'isDone':todo.isDone
//     });
//     setState(() {
//       _todoController.text = '';
//     });
//   }
//   //할 일 삭제 메서드
//   void _deleteTodo(DocumentSnapshot todo) {
//     CollectionReference query = FirebaseFirestore.instance.collection('todo');
//     query.doc(todo.id).delete()
//         .then((value) => print('성공'))
//         .catchError((error) => print('실패'));
//   }
//   //할 일 완료/미완료 메서드
//   void _toggleTodo(Todo todo) {
//     setState(() {
//       todo.isDone = !todo.isDone;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     Query query = FirebaseFirestore.instance.collection('todo');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('남은 할일'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _todoController,
//                   ),
//                 ),
//                 ElevatedButton(
//                   child: Text('추가'),
//                   onPressed: () => _addTodo(Todo(_todoController.text)),
//                 ),
//               ],
//             ),
//             StreamBuilder<QuerySnapshot>(
//                 stream: query.snapshots(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return CircularProgressIndicator();
//                   }
//                   final documents = snapshot.data.docs;
//                   return Expanded(
//                     child: ListView(
//                       children: documents.map((doc) => _buildItemWidget(doc)).toList(),
//                     ),
//                   );
//                 }
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   Widget _buildItemWidget(DocumentSnapshot doc) {
//     final todo = Todo(doc['title'], isDone: doc['isDone']);
//     return ListTile(
//       onTap: () => _toggleTodo(todo), //완료 미완료
//       title: Text(
//         todo.title,
//         style: todo.isDone
//             ? TextStyle(
//           decoration: TextDecoration.lineThrough, //취소선
//           fontStyle: FontStyle.italic, //이탤릭체
//         )
//             : null, //아무 스타일도 적용 안함
//       ),
//       trailing: IconButton(
//         icon: Icon(Icons.delete_forever),
//         onPressed: () => _deleteTodo(doc), //삭제
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized(); // 사전준비가 필요한 코드 (파이어베이스)
  await Firebase.initializeApp(); // 초기화를 하는 코드
  runApp(MyApp());
}
//할 일 클래스
class Todo {
  bool isDone;
  String title;
  Todo(this.title, {this.isDone = false});
}
//시작 클래스
class MyApp extends StatelessWidget {
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
class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}
class _TodoListPageState extends State<TodoListPage> {
  //할 일 목록을 저장할 리스트
//할 일 문자열 조작을 위한 컨트롤러
  var _todoController = TextEditingController();
  @override
  void dispose() {
    _todoController.dispose(); //사용이 끝나면 해제
    super.dispose();
  }
  //할 일 추가 메서드
  Future<void> _addTodo(Todo todo) async {
    //콜백 callback방식
    //promise
    //단점 : 콜백지옥에 빠질수있다.
    CollectionReference query = FirebaseFirestore.instance.collection('todo');
    DocumentReference value = await query.add({
      'title':todo.title,
      'isDone':todo.isDone
    });
    setState(() {
      _todoController.text = '';
    });
  }
  //할 일 삭제 메서드
  void _deleteTodo(DocumentSnapshot todo) {
    CollectionReference query = FirebaseFirestore.instance.collection('todo');
    query.doc(todo.id).delete()
        .then((value) => print('성공'))
        .catchError((error) => print('실패'));
  }
  //할 일 완료/미완료 메서드
  void _toggleTodo(DocumentSnapshot doc) {
    CollectionReference query = FirebaseFirestore.instance.collection('todo');


    query.doc(doc.id).update({'isDone': !doc['isDone']});
  }

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection('todo');
    return Scaffold(
      appBar: AppBar(
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
                    controller: _todoController,
                  ),
                ),
                ElevatedButton(
                  child: Text('추가'),
                  onPressed: () => _addTodo(Todo(_todoController.text)),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: query.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
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
  Widget _buildItemWidget(DocumentSnapshot doc) {
    final todo = Todo(doc['title'], isDone: doc['isDone']);
    return ListTile(
      onTap: () => _toggleTodo(doc), //완료 미완료
      title: Text(
        todo.title,
        style: todo.isDone
            ? TextStyle(
          decoration: TextDecoration.lineThrough, //취소선
          fontStyle: FontStyle.italic, //이탤릭체
        )
            : null, //아무 스타일도 적용 안함
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () => _deleteTodo(doc), //삭제
      ),
    );
  }
}