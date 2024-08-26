import 'translations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class TranslationsPl extends Translations {
  TranslationsPl([String locale = 'pl']) : super(locale);

  @override
  String get title => 'Lista TODO';

  @override
  String get tab_todo_label => 'Do zrobienia';

  @override
  String get tab_done_label => 'Zrobione';

  @override
  String get tab_add_placeholder => 'Wpisz tekst';

  @override
  String get tab_edit_title => 'Edytuj TODO';

  @override
  String get tab_edit_placeholder => 'Edytuj tekst';

  @override
  String get tab_edit_cancel => 'Anuluj';

  @override
  String get tab_edit_save => 'Zapisz';

  @override
  String list_item_done_ago(String when) {
    return 'done $when';
  }
}
