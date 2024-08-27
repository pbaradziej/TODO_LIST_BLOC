part of 'home_cubit.dart';

enum HomeStatus {
  initial,
  loaded,
}

@immutable
class HomeState extends Equatable {
  final HomeStatus status;
  final Locale locale;

  const HomeState({
    required this.status,
    this.locale = const Locale('en'),
  });

  @override
  List<Object> get props => <Object>[
        UniqueKey(),
        status,
        locale,
      ];
}
