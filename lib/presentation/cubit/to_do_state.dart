part of 'to_do_cubit.dart';

enum ToDoStatus {
  initial,
  loaded,
}

@immutable
class ToDoState extends Equatable {
  final ToDoStatus status;
  final List<ToDoItem> toDoItems;

  const ToDoState({
    required this.status,
    this.toDoItems = const <ToDoItem>[],
  });

  @override
  List<Object> get props => <Object>[
        UniqueKey(),
        status,
        toDoItems,
      ];
}
