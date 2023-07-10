import 'package:todo_list_bloc/domain/entities/to_do_item.dart';

abstract class ToDoRepository {
  Future<List<ToDoItem>> getToDoItems();

  Future<List<ToDoItem>> addToDoItem(ToDoItem item);

  Future<List<ToDoItem>> editToDoItem(String guid, String updatedText);

  Future<List<ToDoItem>> removeToDoItem(String guid);

  Future<List<ToDoItem>> changeCompletionOfToDoItem(String guid, bool isComplete);
}
