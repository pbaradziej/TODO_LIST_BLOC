import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_bloc/data/datasources/shared_preferences_provider.dart';

class ToDoProvider extends SharedPreferencesProvider {
  static const String _itemsKey = 'TO_DO_ITEMS';
  static const String _translationKey = 'LANGUAGE_CODE';

  Future<String> getToDoItems() async {
    return withPreferences<String>((SharedPreferences preferences) async {
      return preferences.getString(_itemsKey) ?? '[]';
    });
  }

  Future<void> setToDoItems(final String items) async {
    await withPreferences<void>((final SharedPreferences preferences) async {
      await preferences.setString(_itemsKey, items);
    });
  }

  Future<String?> getTranslations() async {
    return withPreferences<String?>((SharedPreferences preferences) async {
      return preferences.getString(_translationKey);
    });
  }

  Future<void> setTranslations(final String items) async {
    await withPreferences<void>((final SharedPreferences preferences) async {
      await preferences.setString(_translationKey, items);
    });
  }
}
