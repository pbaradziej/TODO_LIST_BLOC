import 'package:flutter/widgets.dart';
import 'package:todo_list_bloc/l10n/generated/translations.dart';

extension AppLocalizationsX on BuildContext {
  Translations get translations => Translations.of(this);
}