import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_bloc/data/models/to_do_dropdown_item.dart';
import 'package:todo_list_bloc/l10n/l10n.dart';
import 'package:todo_list_bloc/presentation/components/change_language_dialog.dart';
import 'package:todo_list_bloc/presentation/cubit/home/home_cubit.dart';

class ToDoListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToDoListAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Locale locale = context.select((HomeCubit cubit) => cubit.state.locale);
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(context.translations.title),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton<ToDoDropdownItem>(
            icon: const Icon(Icons.menu),
            items: <DropdownMenuItem<ToDoDropdownItem>>[
              DropdownMenuItem<ToDoDropdownItem>(
                value: ToDoDropdownItem.translation,
                child: Row(
                  children: <Widget>[
                    Text(context.translations.translation_button),
                    const Icon(Icons.translate),
                  ],
                ),
              ),
            ],
            onChanged: (ToDoDropdownItem? item) {
              switch (item) {
                case ToDoDropdownItem.translation:
                  alertDialog(context, locale);
                default:
                  return;
              }
            },
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(46),
        child: Theme(
          data: ThemeData(
            highlightColor: Colors.transparent,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              tabs: <Widget>[
                createTab(context.translations.tab_todo_label),
                createTab(context.translations.tab_done_label),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void alertDialog(BuildContext context, Locale locale) {
    final ChangeLanguageDialog dialog = ChangeLanguageDialog(
      context: context,
      locale: locale,
    );
    dialog.showChangeLanguageDialog();
  }

  Widget createTab(String tabName) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 100),
      child: Tab(
        child: Text(
          tabName,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 46);
}
