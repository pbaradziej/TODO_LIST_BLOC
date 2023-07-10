import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class ToDoItem extends Equatable {
  final String text;
  final String guid;
  final bool isComplete;

  ToDoItem({
    required this.text,
    String? guid,
    bool? isComplete,
  })  : guid = guid ?? const Uuid().v4(),
        isComplete = isComplete ?? false;

  ToDoItem copyWith({
    String? text,
    bool? isComplete,
  }) {
    return ToDoItem(
      text: text ?? this.text,
      guid: guid,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        text,
        guid,
        isComplete,
      ];
}
