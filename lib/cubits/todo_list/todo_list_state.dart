part of 'filtered_todos_list.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;

  const TodoListState({required this.todos});

  factory TodoListState.initial() {
    return TodoListState(todos: [
       Todo(id: '1', desc: 'กวาดพื้นห้อง/ดูดฝุ่น/ถูพื้น'),
      Todo(id: '2', desc: 'เช็ดตู้เอกสาร/เครื่องใช้สำนักงาน/เช็ดโต๊ะ'),
      // Todo(id: '3', desc: 'ทำความสะอาด ถังขยะ/เก็บขยะ'),
      // Todo(id: '4', desc: 'ทำความสะอาด ห้องน้ำ'),
      // Todo(id: '5', desc: 'ทำความสะอาด เพดาน'),
      // Todo(id: '6', desc: 'ทำความสะอาด ผนัง'),
      // Todo(id: '7', desc: 'ทำความสะอาด ตู้เย็น'),
      // Todo(id: '8', desc: 'ทำความสะอาด พัดลม'),
      // Todo(id: '9', desc: 'อื่นๆ'),
    ]);
  }

  @override
  List<Object> get props => [todos];

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  @override
  String toString() {
    return 'TodoListState{todos: $todos}';
  }
}
