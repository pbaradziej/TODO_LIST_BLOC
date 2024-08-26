import 'translations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TranslationsEn extends Translations {
  TranslationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'TODO List';

  @override
  String get tab_todo_label => 'To do';

  @override
  String get tab_done_label => 'Done';

  @override
  String get tab_add_placeholder => 'Type text';

  @override
  String get tab_edit_title => 'Edit TODO';

  @override
  String get tab_edit_placeholder => 'Edit text';

  @override
  String get tab_edit_cancel => 'Cancel';

  @override
  String get tab_edit_save => 'Save';

  @override
  String list_item_done_ago(String when) {
    return 'done $when';
  }
}
