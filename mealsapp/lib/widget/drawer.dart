import 'package:flutter/material.dart';

class TabDrawer extends StatelessWidget {
  const TabDrawer({super.key, required this.selectedscreen});

  final void Function(String identifier) selectedscreen;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Row(
            children: [
              Icon(
                Icons.fastfood,
                size: 50,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 20),
              Text(
                'Cooking Up!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              )
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.restaurant,
              size: 26, color: Theme.of(context).colorScheme.onBackground),
          title: Text(
            'Meals',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
          ),
          onTap: () {
            selectedscreen('meals');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings,
              size: 26, color: Theme.of(context).colorScheme.onBackground),
          title: Text(
            'filters',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 24,
                ),
          ),
          onTap: () {
            selectedscreen('filters');
          },
        ),
      ]),
    );
  }
}
