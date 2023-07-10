import 'package:todo_list_bloc/domain/entities/to_do_item.dart';

class ToDoItemModel extends ToDoItem {
  ToDoItemModel({
    required String text,
    String? guid,
    bool? isComplete,
  }) : super(
          text: text,
          guid: guid,
          isComplete: isComplete,
        );

  factory ToDoItemModel.fromJson(Map<String, Object?> json) {
    return ToDoItemModel(
      text: json['text'] as String,
      guid: json['guid'] as String?,
      isComplete: json['isComplete'] as bool?,
    );
  }

  static Map<String, Object> toMap(ToDoItem toDoItem) => <String, Object>{
        'text': toDoItem.text,
        'guid': toDoItem.guid,
        'isComplete': toDoItem.isComplete,
      };
}
