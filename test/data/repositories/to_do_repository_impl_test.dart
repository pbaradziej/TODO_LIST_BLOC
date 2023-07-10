import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list_bloc/data/datasources/to_do_provider.dart';
import 'package:todo_list_bloc/data/models/to_do_item_model.dart';
import 'package:todo_list_bloc/data/repositories/to_do_repository_impl.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';

class MockToDoProvider extends Mock implements ToDoProvider {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late ToDoProvider toDoProvider;
  late ToDoRepositoryImpl repository;
  final ToDoItemModel toDoItemModel = ToDoItemModel(
    text: 'todoItem',
    guid: 'uniqueGuid',
    isComplete: true,
  );

  setUp(() {
    toDoProvider = MockToDoProvider();
    repository = ToDoRepositoryImpl(
      toDoProvider: toDoProvider,
    );
  });

  group('to do item list operations', () {
    test('should get items list', () async {
      // arrange
      final List<ToDoItem> toDoItemsData = <ToDoItem>[toDoItemModel];
      mockItemsData(toDoItemsData, toDoProvider);

      // act
      final List<ToDoItem> toDoItems = await repository.getToDoItems();
      // assert
      expect(toDoItems, <ToDoItem>[toDoItemModel]);
    });

    test('should add one item to the list', () async {
      // arrange
      final List<ToDoItem> toDoItemsData = <ToDoItem>[];
      mockItemsData(toDoItemsData, toDoProvider);

      // act
      final List<ToDoItem> toDoItems = await repository.getToDoItems();
      expect(toDoItems, <ToDoItem>[]);
      final List<ToDoItem> updatedToDoItems = await repository.addToDoItem(toDoItemModel);
      // assert
      expect(updatedToDoItems, <ToDoItem>[toDoItemModel]);
    });

    test('should edit one item to the list', () async {
      // arrange
      final List<ToDoItem> toDoItemsData = <ToDoItem>[toDoItemModel];
      mockItemsData(toDoItemsData, toDoProvider);

      // arrange
      final ToDoItem updatedToDoItem = ToDoItem(
        text: 'updatedText',
        guid: 'uniqueGuid',
        isComplete: true,
      );

      // act
      final List<ToDoItem> toDoItems = await repository.getToDoItems();
      expect(toDoItems, <ToDoItem>[toDoItemModel]);
      final List<ToDoItem> updatedToDoItems = await repository.editToDoItem(toDoItemModel.guid, 'updatedText');
      // assert
      expect(updatedToDoItems, <ToDoItem>[updatedToDoItem]);
    });

    test('should remove one item to the list', () async {
      // arrange
      final List<ToDoItem> toDoItemsData = <ToDoItem>[toDoItemModel];
      mockItemsData(toDoItemsData, toDoProvider);

      // act
      final List<ToDoItem> toDoItems = await repository.getToDoItems();
      expect(toDoItems, <ToDoItem>[toDoItemModel]);
      final List<ToDoItem> updatedToDoItems = await repository.removeToDoItem(toDoItemModel.guid);
      // assert
      expect(updatedToDoItems, <ToDoItem>[]);
    });

    test('should change completion of one item to the list', () async {
      // arrange
      final ToDoItem updatedToDoItem = ToDoItem(
        text: 'todoItem',
        guid: 'uniqueGuid',
        isComplete: false,
      );
      final List<ToDoItem> toDoItemsData = <ToDoItem>[toDoItemModel];
      mockItemsData(toDoItemsData, toDoProvider);

      // act
      final List<ToDoItem> toDoItems = await repository.getToDoItems();
      expect(toDoItems, <ToDoItem>[toDoItemModel]);
      final List<ToDoItem> updatedToDoItems = await repository.changeCompletionOfToDoItem(toDoItemModel.guid, false);
      // assert
      expect(updatedToDoItems, <ToDoItem>[updatedToDoItem]);
    });
  });
}

void mockItemsData(List<ToDoItem> toDoItems, ToDoProvider toDoProvider) {
  final List<Map<String, Object>> mappedToDoItems = toDoItems.map<Map<String, Object>>(ToDoItemModel.toMap).toList();
  final String encodedItems = json.encode(mappedToDoItems);
  when(() => toDoProvider.getToDoItems()).thenAnswer((_) async => encodedItems);
  when(() => toDoProvider.setToDoItems(any())).thenAnswer((_) async {});
}
