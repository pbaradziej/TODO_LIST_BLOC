import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list_bloc/data/models/to_do_item_model.dart';
import 'package:todo_list_bloc/domain/entities/to_do_item.dart';
import 'package:todo_list_bloc/domain/usecases/to_do_actions.dart';
import 'package:todo_list_bloc/presentation/cubit/to_do_cubit.dart';

class MockToDoActions extends Mock implements ToDoActions {}

class FakeToDoItem extends Fake implements ToDoItem {}

void main() {
  late ToDoCubit cubit;
  late ToDoActions toDoActions;
  late List<ToDoItem> toDoItemsData;

  final ToDoItemModel toDoItemModel = ToDoItemModel(
    text: 'todoItem',
    guid: 'uniqueGuid',
    isComplete: true,
  );

  setUpAll(() {
    registerFallbackValue(FakeToDoItem());
  });

  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() {
    toDoActions = MockToDoActions();
    cubit = ToDoCubit(
      toDoActions: toDoActions,
    );
    toDoItemsData = <ToDoItem>[toDoItemModel];
  });

  test('should have initial state', () {
    // assert
    const ToDoState toDoState = ToDoState(status: ToDoStatus.initial);
    expect(cubit.state, toDoState);
  });

  group('to do items actions', () {
    blocTest<ToDoCubit, ToDoState>(
      'emits loaded state for getToDoItems',
      build: () => cubit,
      act: (ToDoCubit cubit) async {
        when(() => toDoActions.getToDoItems()).thenAnswer((_) async => toDoItemsData);
        await cubit.initializeToDoItems();
      },
      expect: () => <TypeMatcher<ToDoState>>[
        isA<ToDoState>()
            .having(
              (ToDoState state) => state.status,
              'state.loaded',
              ToDoStatus.loaded,
            )
            .having(
              (ToDoState state) => state.toDoItems,
              'state.toDoItems',
              toDoItemsData,
            ),
      ],
    );

    final List<ToDoItem> expectedAddedToDoItems = <ToDoItem>[toDoItemModel, toDoItemModel];

    blocTest<ToDoCubit, ToDoState>(
      'emits loaded state for addToDoItem',
      build: () => cubit,
      act: (ToDoCubit cubit) async {
        when(() => toDoActions.getToDoItems()).thenAnswer((_) async => toDoItemsData);
        await cubit.initializeToDoItems();
        when(() => toDoActions.setToDoItems(any())).thenAnswer((_) async {});
        await cubit.addToDoItem(toDoItemModel);
      },
      expect: () => <TypeMatcher<ToDoState>>[
        isA<ToDoState>()
            .having(
              (ToDoState state) => state.status,
              'state.loaded',
              ToDoStatus.loaded,
            )
            .having(
              (ToDoState state) => state.toDoItems,
              'state.toDoItems',
              expectedAddedToDoItems,
            ),
        isA<ToDoState>()
            .having(
              (ToDoState state) => state.status,
              'state.loaded',
              ToDoStatus.loaded,
            )
            .having(
              (ToDoState state) => state.toDoItems,
              'state.toDoItems',
              expectedAddedToDoItems,
            ),
      ],
    );

    final ToDoItem updatedEditedToDoItemModel = toDoItemModel.copyWith(text: 'updatedText');
    final List<ToDoItem> expectedEditedToDoItems = <ToDoItem>[updatedEditedToDoItemModel];

    blocTest<ToDoCubit, ToDoState>(
      'emits loaded state for editToDoItem',
      build: () => cubit,
      act: (ToDoCubit cubit) async {
        when(() => toDoActions.getToDoItems()).thenAnswer((_) async => toDoItemsData);
        await cubit.initializeToDoItems();
        when(() => toDoActions.setToDoItems(any())).thenAnswer((_) async {});
        await cubit.editToDoItem('uniqueGuid', 'updatedText');
      },
      expect: () => <TypeMatcher<ToDoState>>[
        isA<ToDoState>()
            .having(
              (ToDoState state) => state.status,
              'state.loaded',
              ToDoStatus.loaded,
            )
            .having(
              (ToDoState state) => state.toDoItems,
              'state.toDoItems',
              expectedEditedToDoItems,
            ),
        isA<ToDoState>()
            .having(
              (ToDoState state) => state.status,
              'state.loaded',
              ToDoStatus.loaded,
            )
            .having(
              (ToDoState state) => state.toDoItems,
              'state.toDoItems',
              expectedEditedToDoItems,
            ),
      ],
    );

    blocTest<ToDoCubit, ToDoState>(
      'emits loaded state for removeToDoItem',
      build: () => cubit,
      act: (ToDoCubit cubit) async {
        when(() => toDoActions.getToDoItems()).thenAnswer((_) async => toDoItemsData);
        await cubit.initializeToDoItems();
        when(() => toDoActions.setToDoItems(any())).thenAnswer((_) async {});
        await cubit.removeToDoItem(toDoItemModel);
      },
      expect: () => <TypeMatcher<ToDoState>>[
        isA<ToDoState>()
            .having(
          (ToDoState state) => state.status,
          'state.loaded',
          ToDoStatus.loaded,
        )
            .having(
          (ToDoState state) => state.toDoItems,
          'state.toDoItems',
          <ToDoItem>[],
        ),
        isA<ToDoState>()
            .having(
          (ToDoState state) => state.status,
          'state.loaded',
          ToDoStatus.loaded,
        )
            .having(
          (ToDoState state) => state.toDoItems,
          'state.toDoItems',
          <ToDoItem>[],
        ),
      ],
    );

    final ToDoItem updatedChangedToDoItemModel = toDoItemModel.copyWith(isComplete: false);
    final List<ToDoItem> expectedChangedToDoItems = <ToDoItem>[updatedChangedToDoItemModel];

    blocTest<ToDoCubit, ToDoState>(
      'emits loaded state for changeCompletionOfToDoItem',
      build: () => cubit,
      act: (ToDoCubit cubit) async {
        when(() => toDoActions.getToDoItems()).thenAnswer((_) async => toDoItemsData);
        await cubit.initializeToDoItems();
        when(() => toDoActions.setToDoItems(any())).thenAnswer((_) async {});
        await cubit.changeCompletionOfToDoItem(toDoItemModel);
      },
      expect: () => <TypeMatcher<ToDoState>>[
        isA<ToDoState>()
            .having(
              (ToDoState state) => state.status,
              'state.loaded',
              ToDoStatus.loaded,
            )
            .having(
              (ToDoState state) => state.toDoItems,
              'state.toDoItems',
              expectedChangedToDoItems,
            ),
        isA<ToDoState>()
            .having(
              (ToDoState state) => state.status,
              'state.loaded',
              ToDoStatus.loaded,
            )
            .having(
              (ToDoState state) => state.toDoItems,
              'state.toDoItems',
              expectedChangedToDoItems,
            ),
      ],
    );
  });
}
