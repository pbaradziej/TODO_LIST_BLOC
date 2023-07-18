import 'package:flutter/material.dart';

class ToDoListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ToDoListAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 46);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text('ToDoList'),
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
                createTab('ToDo'),
                createTab('Done'),
              ],
            ),
          ),
        ),
      ),
    );
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
}
