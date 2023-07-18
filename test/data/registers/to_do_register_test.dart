import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_bloc/data/registers/to_do_register.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';

void main() {
  late ToDoRegister toDoRegister;

  setUp(() {
    toDoRegister = ToDoRegister();
  });

  final ToDoItem toDoItem = ToDoItem(text: 'text');

  test('should get no todos from the register', () async {
    // act
    final List<ToDoItem> toDoItems = toDoRegister.toDoItems;

    // assert
    expect(toDoItems, <ToDoItem>[]);
  });

  test('should add todo to the register', () async {
    // act
    toDoRegister.addToDoItem(toDoItem);

    // assert
    final List<ToDoItem> toDoItems = toDoRegister.toDoItems;
    expect(toDoItems, <ToDoItem>[toDoItem]);
  });

  test('should edit todo in the register', () async {
    // arrange
    toDoRegister.addToDoItem(toDoItem);

    // act
    toDoRegister.editToDoItem(toDoItem.guid, 'updatedText');

    // assert
    final List<ToDoItem> updatedToDoItems = toDoRegister.toDoItems;
    final ToDoItem updatedToDoItem = toDoItem.copyWith(text: 'updatedText');
    expect(updatedToDoItems, <ToDoItem>[updatedToDoItem]);
  });

  test('should remove todo from the repository', () async {
    // arrange
    toDoRegister.addToDoItem(toDoItem);

    // act
    toDoRegister.removeToDoItem(toDoItem);

    // assert
    final List<ToDoItem> toDoItems = toDoRegister.toDoItems;
    expect(toDoItems, <ToDoItem>[]);
  });

  test('should change completion of to do item from the repository', () async {
    // arrange
    toDoRegister.addToDoItem(toDoItem);

    // act
    toDoRegister.changeCompletionOfToDoItem(toDoItem);

    // assert
    final List<ToDoItem> updatedToDoItems = toDoRegister.toDoItems;
    final ToDoItem updatedToDoItem = toDoItem.copyWith(isComplete: true);
    expect(updatedToDoItems, <ToDoItem>[updatedToDoItem]);
  });
}
