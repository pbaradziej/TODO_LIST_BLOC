import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/l10n/generated/translations.dart';
import 'package:todo_list_bloc/l10n/l10n.dart';
import 'package:todo_list_bloc/presentation/cubit/home/home_cubit.dart';

class ChangeLanguageDialogContent extends StatefulWidget {
  final Locale locale;

  const ChangeLanguageDialogContent({required this.locale, super.key});

  @override
  State<ChangeLanguageDialogContent> createState() => _ChangeLanguageDialogContentState();
}

class _ChangeLanguageDialogContentState extends State<ChangeLanguageDialogContent> {
  late String languageCode;
  late HomeCubit homeCubit;

  @override
  void initState() {
    super.initState();
    languageCode = widget.locale.languageCode;
    homeCubit = context.read();
  }

  @override
  Widget build(BuildContext context) {
    const List<Locale> supportedLocales = Translations.supportedLocales;
    return AlertDialog(
      title: Text(context.translations.translation_button),
      content: SizedBox(
        width: 400,
        height: 200,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: supportedLocales.length,
          itemBuilder: (BuildContext context, int count) {
            return InkWell(
              child: Row(
                children: <Widget>[
                  radioButton(supportedLocales[count].languageCode),
                  Text(supportedLocales[count].toLanguageTag()),
                ],
              ),
            );
          },
        ),
      ),
      actions: <Widget>[
        dialogActions(context),
      ],
    );
  }

  Widget radioButton(String code) {
    return Radio<bool>(
      value: code == languageCode,
      groupValue: true,
      onChanged: (_) => setState(() => languageCode = code),
      toggleable: true,
    );
  }

  Widget dialogActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(context.translations.tab_edit_cancel),
        ),
        ElevatedButton(
          onPressed: () {
            changeLanguage();
            Navigator.of(context).pop();
          },
          child: Text(context.translations.tab_edit_save),
        ),
      ],
    );
  }

  void changeLanguage() {
    final Locale locale = Locale(languageCode);
    homeCubit.changeLanguage(locale);
  }
}
