import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/domain/repositories/to_do_repository.dart';
import 'package:todo_list_bloc/domain/usecases/to_do_actions.dart';

class MockToDoRepository extends Mock implements ToDoRepository {}

void main() {
  late ToDoRepository mockToDoRepository;
  late ToDoActions usecase;

  setUp(() {
    mockToDoRepository = MockToDoRepository();
    usecase = ToDoActions(repository: mockToDoRepository);
  });

  final ToDoItem toDoItem = ToDoItem(text: 'test');

  test('should get todos from the repository', () async {
    // arrange
    when(() => mockToDoRepository.getToDoItems()).thenAnswer((_) async => <ToDoItem>[toDoItem, toDoItem]);

    // act
    final List<ToDoItem> result = await usecase.getToDoItems();

    // assert
    expect(result, <ToDoItem>[toDoItem, toDoItem]);
    verify(() => mockToDoRepository.getToDoItems());
    verifyNoMoreInteractions(mockToDoRepository);
  });

  test('should set todos in the repository', () async {
    // arrange
    when(() => mockToDoRepository.getToDoItems()).thenAnswer((_) async => <ToDoItem>[toDoItem]);
    when(() => mockToDoRepository.setToDoItems(<ToDoItem>[toDoItem])).thenAnswer((_) async {});

    // act
    await usecase.setToDoItems(<ToDoItem>[toDoItem]);

    // assert
    final List<ToDoItem> result = await usecase.getToDoItems();
    expect(result, <ToDoItem>[toDoItem]);
    verify(() => mockToDoRepository.setToDoItems(<ToDoItem>[toDoItem]));
    verify(() => mockToDoRepository.getToDoItems());
    verifyNoMoreInteractions(mockToDoRepository);
  });
}
