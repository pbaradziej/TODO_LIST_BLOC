import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list_bloc/domain/usecases/to_do_actions.dart';
import 'package:todo_list_bloc/presentation/cubit/home/home_cubit.dart';

class MockToDoActions extends Mock implements ToDoActions {}

class FakeLocale extends Fake implements Locale {}

void main() {
  late HomeCubit cubit;
  late ToDoActions toDoActions;
  late Locale data;

  setUpAll(() {
    registerFallbackValue(FakeLocale());
  });

  setUp(TestWidgetsFlutterBinding.ensureInitialized);

  setUp(() {
    toDoActions = MockToDoActions();
    cubit = HomeCubit(
      toDoActions: toDoActions,
    );
    data = const Locale('en');
  });

  test('should have initial state', () {
    // assert
    const HomeState homeState = HomeState(status: HomeStatus.initial);
    expect(cubit.state, homeState);
  });

  group('home actions', () {
    blocTest<HomeCubit, HomeState>(
      'emits loaded state for initializeHome',
      build: () => cubit,
      act: (HomeCubit cubit) async {
        when(() => toDoActions.getTranslations()).thenAnswer((_) async => data);
        await cubit.initializeHome();
      },
      expect: () => <TypeMatcher<HomeState>>[
        isA<HomeState>()
            .having(
              (HomeState state) => state.status,
              'state.loaded',
              HomeStatus.loaded,
            )
            .having(
              (HomeState state) => state.locale,
              'state.locale',
              data,
            ),
      ],
    );

    const Locale updatedLocale = Locale('pl');

    blocTest<HomeCubit, HomeState>(
      'emits loaded state for changeLanguage',
      build: () => cubit,
      act: (HomeCubit cubit) async {
        when(() => toDoActions.getTranslations()).thenAnswer((_) async => data);
        await cubit.initializeHome();
        when(() => toDoActions.setTranslations(any())).thenAnswer((_) async {});
        await cubit.changeLanguage(updatedLocale);
      },
      expect: () => <TypeMatcher<HomeState>>[
        isA<HomeState>()
            .having(
              (HomeState state) => state.status,
              'state.loaded',
              HomeStatus.loaded,
            )
            .having(
              (HomeState state) => state.locale,
              'state.locale',
              data,
            ),
        isA<HomeState>()
            .having(
              (HomeState state) => state.status,
              'state.loaded',
              HomeStatus.loaded,
            )
            .having(
              (HomeState state) => state.locale,
              'state.locale',
              updatedLocale,
            ),
      ],
    );
  });
}
