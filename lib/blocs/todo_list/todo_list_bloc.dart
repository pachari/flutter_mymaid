// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import '../../services/todo_service.dart';
part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<RemoveTodoEvent>(_removeTodo);
    on<SaveTodoEvent>(_saveTodo);
  }
  void _addTodo(AddTodoEvent event, Emitter<TodoListState> emit) {
    final newTodo = Todo(desc: event.todoDesc);
    final newTodos = [...state.todos, newTodo];
    emit(state.copyWith(todos: newTodos));
  }

  void _editTodo(EditTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          desc: event.todoDesc,
          completed: todo.completed,
        );
      }
      return todo;
    }).toList();
    emit(state.copyWith(todos: newTodos));
  }

  void _toggleTodo(ToggleTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.todos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
          id: event.id,
          desc: todo.desc,
          completed: !todo.completed,
        );
      }

      return todo;
    }).toList();
    emit(state.copyWith(todos: newTodos));
  }

  void _removeTodo(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos =
        state.todos.where((Todo t) => t.id != event.todo.id).toList();
    emit(state.copyWith(todos: newTodos));
  }

  Future<void> _saveTodo(SaveTodoEvent event, Emitter<TodoListState> emit) async {
    //get the collection
    // CollectionReference todolists = FirebaseFirestore.instance.collection('todolists');
    // final user = FirebaseAuth.instance.currentUser;
    var now = DateTime.now();
    var formatter = DateFormat('yyyyMMdd');
    String formattedDate = formatter.format(now);
    for (int i = 0; i < state.todos.length; i++) {
      try {
        if (state.todos[i].completed == true) {
          //// create แบบ ไม่กำหนดชื่อ Document
          // lists.add({
          //   "id": state.todos[i].id,
          //   "detail": state.todos[i].desc,
          //   "active": state.todos[i].completed,
          //   "checllistid": event.id
          // });
          //// create แบบ กำหนดชื่อ Document แต่เราต้องใช้คำสั่ง set แทน add /todolists/blob/27042566-01/list-01
          // await todolists
          //     .doc(user?.uid)
          //     .collection("$formattedDate-${event.id}")
          //     .doc('list-${state.todos[i].id}')
          //     .set({
          //   "id": state.todos[i].id,
          //   "detail": state.todos[i].desc,
          //   "active": state.todos[i].completed,
          //   "checklistid": event.id
          // });
          print('Success');
        }
      } catch (e) {
        // catch all exceptions (not just SocketException)
        // 4. return Error here too
        print(e);
      }
    }
  }
}
