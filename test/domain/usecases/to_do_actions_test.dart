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
    usecase = ToDoActions(mockToDoRepository);
  });

  final ToDoItem toDoItem = ToDoItem(text: 'test');

  test('should get todos from the repository', () async {
    when(() => mockToDoRepository.getToDoItems()).thenAnswer((_) async => <ToDoItem>[toDoItem, toDoItem]);
    final List<ToDoItem> result = await usecase.getToDoItems();
    expect(result, <ToDoItem>[toDoItem, toDoItem]);
    verify(() => mockToDoRepository.getToDoItems());
    verifyNoMoreInteractions(mockToDoRepository);
  });

  test('should add todo to the repository', () async {
    when(() => mockToDoRepository.addToDoItem(toDoItem)).thenAnswer((_) async => <ToDoItem>[toDoItem]);
    final List<ToDoItem> result = await usecase.addToDoItem(toDoItem);
    expect(result, <ToDoItem>[toDoItem]);
    verify(() => mockToDoRepository.addToDoItem(toDoItem));
    verifyNoMoreInteractions(mockToDoRepository);
  });

  test('should edit todo in the repository', () async {
    when(() => mockToDoRepository.editToDoItem('test', 'test')).thenAnswer((_) async => <ToDoItem>[toDoItem]);
    final List<ToDoItem> result = await usecase.editToDoItem('test', 'test');
    expect(result, <ToDoItem>[toDoItem]);
    verify(() => mockToDoRepository.editToDoItem('test', 'test'));
    verifyNoMoreInteractions(mockToDoRepository);
  });

  test('should remove todo from the repository', () async {
    when(() => mockToDoRepository.removeToDoItem('guid')).thenAnswer((_) async => <ToDoItem>[]);
    final List<ToDoItem> result = await usecase.removeToDoItem('guid');
    expect(result, <ToDoItem>[]);
    verify(() => mockToDoRepository.removeToDoItem('guid'));
    verifyNoMoreInteractions(mockToDoRepository);
  });

  test('should change completion of to do item from the repository', () async {
    when(() => mockToDoRepository.changeCompletionOfToDoItem('guid', true)).thenAnswer((_) async => <ToDoItem>[toDoItem]);
    final List<ToDoItem> result = await usecase.changeCompletionOfToDoItem('guid', true);
    expect(result, <ToDoItem>[toDoItem]);
    verify(() => mockToDoRepository.changeCompletionOfToDoItem('guid', true));
    verifyNoMoreInteractions(mockToDoRepository);
  });
}
