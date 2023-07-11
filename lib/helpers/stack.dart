import 'dart:collection';
import 'dart:core';
import 'dart:developer';

class Stack<T> {
  final ListQueue<T> _list = ListQueue();

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  void push(T e) {
    _list.addLast(e);
  }

  T pop() {
    if (isEmpty) {
      throw Exception('The stack is empty');
    }
    T e = _list.last;
    _list.removeLast();
    return e;
  }

  T top() {
    if (isEmpty) {
      throw Exception('The stack is empty');
    }
    return _list.last;
  }

  int size() {
    return _list.length;
  }

  int get length => size();

  void print() {
    for (var item in List<T>.from(_list).reversed) {
      log(item.toString());
    }
  }

  void clearStack() {
    while (isNotEmpty) {
      _list.removeLast();
    }
  }

  @override
  String toString() => _list.toString();
}
