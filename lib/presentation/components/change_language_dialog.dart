import 'package:flutter/material.dart';
import 'package:todo_list_bloc/presentation/components/change_language_dialog_content.dart';

class ChangeLanguageDialog {
  final BuildContext context;
  final Locale locale;

  ChangeLanguageDialog({
    required this.context,
    required this.locale,
  });

  void showChangeLanguageDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => ChangeLanguageDialogContent(locale: locale),
    );
  }
}
