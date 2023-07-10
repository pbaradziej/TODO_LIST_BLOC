import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/domain/repositories/to_do_repository.dart';

class ToDoActions {
  final ToDoRepository repository;

  ToDoActions(this.repository);

  Future<List<ToDoItem>> getToDoItems() async {
    return repository.getToDoItems();
  }

  Future<List<ToDoItem>> addToDoItem(ToDoItem item) async {
    return repository.addToDoItem(item);
  }

  Future<List<ToDoItem>> editToDoItem(String guid, String updatedText) async {
    return repository.editToDoItem(guid, updatedText);
  }

  Future<List<ToDoItem>> removeToDoItem(String guid) async {
    return repository.removeToDoItem(guid);
  }

  Future<List<ToDoItem>> changeCompletionOfToDoItem(String guid, bool isComplete) async {
    return repository.changeCompletionOfToDoItem(guid, isComplete);
  }
}
