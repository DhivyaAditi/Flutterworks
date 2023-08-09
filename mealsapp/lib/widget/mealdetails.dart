import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/model/meals.dart';
import 'package:mealsapp/providers/favourite_meal_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;
  //final void Function(Meal meal) favouriteMeal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouritemeals=ref.watch(favouritemealprovider);
    final isfavourite=favouritemeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                // favouriteMeal(meal);
                final wasAdded = ref
                    .read(favouritemealprovider.notifier)
                    .favouriteStateToggling(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(wasAdded
                        ? 'Added to favourite!'
                        : 'No longer your favourite:('),
                  ),
                );
              },
              icon: AnimatedSwitcher(duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return RotationTransition(
                        // turns: animation,
                        //if you're not happy with this animation
                        turns: Tween(begin: 5.0, end:1.0).animate(animation),
                      child:child);
                    },
                    child:Icon(isfavourite?Icons.star:Icons.star_border,key:ValueKey(isfavourite)),
                    //with key flutter identifies the changes and trigget
              )
               ,
              )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag:meal.id,
              child:Container(
                  margin: const EdgeInsets.all(5),
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(meal.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              
            ),
            const SizedBox(height: 15),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            for (final ingredient in meal.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                child: Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            const SizedBox(height: 15),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
