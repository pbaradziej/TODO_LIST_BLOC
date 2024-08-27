import 'package:get_it/get_it.dart';
import 'package:todo_list_bloc/presentation/cubit/home/home_cubit.dart';
import 'package:todo_list_bloc/presentation/cubit/to_do/to_do_cubit.dart';

final GetIt sl = GetIt.instance;

void init() {
  sl.registerFactory(HomeCubit.new);
  sl.registerFactory(ToDoCubit.new);
}
