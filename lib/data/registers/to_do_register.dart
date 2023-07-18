import 'package:todo_list_bloc/domain/entities/to_do_item.dart';

class ToDoRegister {
  final List<ToDoItem> _toDoItems;

  ToDoRegister() : _toDoItems = <ToDoItem>[];

  List<ToDoItem> get toDoItems => _toDoItems;

  void initializeToDoItems(List<ToDoItem> toDoItems) {
    _toDoItems.addAll(toDoItems);
  }

  void addToDoItem(ToDoItem toDoItem) {
    _toDoItems.add(toDoItem);
  }

  void editToDoItem(String guid, String updatedText) {
    final int toDoItemIndex = _toDoItems.indexWhere((ToDoItem item) => item.guid == guid);
    final ToDoItem toDoItem = _toDoItems.elementAt(toDoItemIndex);
    final ToDoItem updatedToDoItem = toDoItem.copyWith(text: updatedText);
    _toDoItems[toDoItemIndex] = updatedToDoItem;
  }

  void removeToDoItem(ToDoItem toDoItem) {
    _toDoItems.remove(toDoItem);
  }

  void changeCompletionOfToDoItem(ToDoItem toDoItem) {
    final int toDoItemIndex = _toDoItems.indexOf(toDoItem);
    final ToDoItem updatedToDoItem = toDoItem.copyWith(isComplete: !toDoItem.isComplete);
    _toDoItems[toDoItemIndex] = updatedToDoItem;
  }
}
