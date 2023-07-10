import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list_bloc/data/models/to_do_item_model.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';

void main() {
  final ToDoItemModel toDoItemModel = ToDoItemModel(
    text: 'todoItem',
    guid: 'uniqueGuid',
    isComplete: true,
  );

  test('should be a subclass of ToDoItemModel entity', () async {
    expect(toDoItemModel, isA<ToDoItemModel>());
  });

  test('should correctly copy todoItem', () async {
    // arrange
    final ToDoItem updatedToDoItem = ToDoItem(
      text: 'copiedText',
      guid: 'uniqueGuid',
      isComplete: false,
    );
    // act
    final ToDoItem copiedToDoItem = toDoItemModel.copyWith(
      text: 'copiedText',
      isComplete: false,
    );
    // assert
    expect(copiedToDoItem, updatedToDoItem);
  });

  group('todo item json operations', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, Object> jsonMap = <String, Object>{
        'text': 'todoItem',
        'guid': 'uniqueGuid',
        'isComplete': true,
      };
      // act
      final ToDoItemModel result = ToDoItemModel.fromJson(jsonMap);
      // assert
      expect(result, toDoItemModel);
    });

    test('should return a valid model from JSON with default value', () async {
      final ToDoItemModel toDoItemModel = ToDoItemModel(
        text: 'todoItem',
        guid: 'uniqueGuid',
      );

      // arrange
      final Map<String, Object> jsonMap = <String, Object>{
        'text': 'todoItem',
        'guid': 'uniqueGuid',
      };
      // act
      final ToDoItemModel result = ToDoItemModel.fromJson(jsonMap);
      // assert
      expect(result, toDoItemModel);
    });

    test('should return a valid map from model', () async {
      final Map<String, Object> jsonMap = <String, Object>{
        'text': 'todoItem',
        'guid': 'uniqueGuid',
        'isComplete': false,
      };

      // arrange
      final ToDoItemModel toDoItemModel = ToDoItemModel(
        text: 'todoItem',
        guid: 'uniqueGuid',
      );
      // act
      final Map<String, Object> result = ToDoItemModel.toMap(toDoItemModel);
      // assert
      expect(result, jsonMap);
    });
  });
}
