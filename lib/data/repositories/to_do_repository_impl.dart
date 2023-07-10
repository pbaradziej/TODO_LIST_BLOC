import 'dart:convert';

import 'package:todo_list_bloc/data/datasources/to_do_provider.dart';
import 'package:todo_list_bloc/data/models/to_do_item_model.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/domain/repositories/to_do_repository.dart';

class ToDoRepositoryImpl implements ToDoRepository {
  final ToDoProvider toDoProvider;

  ToDoRepositoryImpl({
    ToDoProvider? toDoProvider,
  }) : toDoProvider = toDoProvider ?? ToDoProvider();

  @override
  Future<List<ToDoItem>> getToDoItems() async {
    final String toDoItems = await toDoProvider.getToDoItems();
    final List<Object?> decodedItems = json.decode(toDoItems) as List<Object?>;

    return decodedItems
        .map<ToDoItem>(
          (Object? item) => ToDoItemModel.fromJson(item as Map<String, Object?>),
        )
        .toList();
  }

  @override
  Future<List<ToDoItem>> addToDoItem(ToDoItem item) async {
    final List<ToDoItem> toDoItems = await getToDoItems();
    toDoItems.add(item);
    await _setToDoItems(toDoItems);

    return toDoItems;
  }

  @override
  Future<List<ToDoItem>> editToDoItem(String guid, String updatedText) async {
    final List<ToDoItem> toDoItems = await getToDoItems();
    final int toDoItemIndex = toDoItems.indexWhere((ToDoItem item) => item.guid == guid);
    final ToDoItem toDoItem = toDoItems.elementAt(toDoItemIndex);
    final ToDoItem updatedToDoItem = toDoItem.copyWith(text: updatedText);
    toDoItems[toDoItemIndex] = updatedToDoItem;
    await _setToDoItems(toDoItems);

    return toDoItems;
  }

  @override
  Future<List<ToDoItem>> removeToDoItem(String guid) async {
    final List<ToDoItem> toDoItems = await getToDoItems();
    toDoItems.removeWhere((ToDoItem item) => item.guid == guid);
    await _setToDoItems(toDoItems);

    return toDoItems;
  }

  @override
  Future<List<ToDoItem>> changeCompletionOfToDoItem(String guid, bool isComplete) async {
    final List<ToDoItem> toDoItems = await getToDoItems();
    final int toDoItemIndex = toDoItems.indexWhere((ToDoItem item) => item.guid == guid);
    final ToDoItem toDoItem = toDoItems.elementAt(toDoItemIndex);
    final ToDoItem updatedToDoItem = toDoItem.copyWith(isComplete: isComplete);
    toDoItems[toDoItemIndex] = updatedToDoItem;
    await _setToDoItems(toDoItems);

    return toDoItems;
  }

  Future<void> _setToDoItems(List<ToDoItem> toDoItems) async {
    final List<Map<String, Object>> mappedToDoItems = toDoItems.map<Map<String, Object>>(ToDoItemModel.toMap).toList();
    final String encodedItems = json.encode(mappedToDoItems);
    await toDoProvider.setToDoItems(encodedItems);
  }
}
