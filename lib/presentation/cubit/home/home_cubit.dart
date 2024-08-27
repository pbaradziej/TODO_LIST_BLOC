import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_bloc/domain/usecases/to_do_actions.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ToDoActions toDoActions;

  HomeCubit({
    ToDoActions? toDoActions,
  })  : toDoActions = toDoActions ?? ToDoActions(),
        super(const HomeState(status: HomeStatus.initial));

  Future<void> initializeHome() async {
    final Locale locale = await toDoActions.getTranslations();
    await _emitToDoState(locale);
  }

  Future<void> changeLanguage(Locale locale) async {
    await toDoActions.setTranslations(locale);
    await _emitToDoState(locale);
  }

  Future<void> _emitToDoState(Locale locale) async {
    final HomeState toDoState = HomeState(
      status: HomeStatus.loaded,
      locale: locale,
    );
    emit(toDoState);
  }
}
