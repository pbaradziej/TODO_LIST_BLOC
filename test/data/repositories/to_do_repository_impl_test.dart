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
  const Locale locale = Locale('en');

  setUp(() {
    toDoProvider = MockToDoProvider();
    repository = ToDoRepositoryImpl(
      toDoProvider: toDoProvider,
    );
  });

  group('to do item list operations', () {
    test('should get items', () async {
      // arrange
      final List<ToDoItem> toDoItemsData = <ToDoItem>[toDoItemModel];
      mockItemsData(toDoProvider, toDoItemsData);

      // act
      final List<ToDoItem> toDoItems = await repository.getToDoItems();

      // assert
      expect(toDoItems, <ToDoItem>[toDoItemModel]);
    });

    test('should set items', () async {
      // arrange
      final List<ToDoItem> toDoItemsData = <ToDoItem>[toDoItemModel];
      mockItemsData(toDoProvider, toDoItemsData);

      // act
      await repository.setToDoItems(toDoItemsData);

      // assert
      final List<ToDoItem> toDoItems = await repository.getToDoItems();
      expect(toDoItems, <ToDoItem>[toDoItemModel]);
    });

    test('should get translations', () async {
      // arrange
      mockItemsData(toDoProvider);

      // act
      final Locale translations = await repository.getTranslations();

      // assert
      expect(translations, locale);
    });

    test('should set translations', () async {
      // arrange
      mockItemsData(toDoProvider);

      // act
      await repository.setTranslations(locale);

      // assert
      final Locale translations = await repository.getTranslations();
      expect(translations, locale);
    });
  });
}

void mockItemsData(ToDoProvider toDoProvider, [List<ToDoItem>? toDoItems]) {
  final List<Map<String, Object>>? mappedToDoItems = toDoItems?.map<Map<String, Object>>(ToDoItemModel.toMap).toList();
  final String encodedItems = json.encode(mappedToDoItems);
  when(() => toDoProvider.getToDoItems()).thenAnswer((_) async => encodedItems);
  when(() => toDoProvider.setToDoItems(any())).thenAnswer((_) async {});
  final String translations = const Locale('en').languageCode;
  when(() => toDoProvider.getTranslations()).thenAnswer((_) async => translations);
  when(() => toDoProvider.setTranslations(any())).thenAnswer((_) async {});
}
