import 'package:flutter/material.dart';
import 'package:mealsapp/model/meals.dart';
import 'package:mealsapp/widget/mealdetails.dart';
import 'package:mealsapp/widget/mealitem.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,  this.title, required this.meals, });
final  String? title;
final List<Meal> meals;
//final void Function(Meal meal) selectedFavouritemeal;

void navigate(BuildContext context, Meal meal){
  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>
  MealDetailScreen(meal: meal)
  ),);
}
  @override
  Widget build(BuildContext context) {
    Widget content=Center(
        child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Uh..oh......Nothing here',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),
              ),
              const SizedBox(height: 20,),
               Text('Try selecting  a different category',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground
              ),
              ),
            ],
          ),
      );
    
    if(meals.isNotEmpty){
      content=ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx,index)=>
     MealItem(meal: meals[index],selectedmeal:(meal){
      navigate(context, meal);
     } )
      );
    }
     if(title==null){
      return content;
     }

    return Scaffold(
      appBar: AppBar(title: Text(title!),
      //text goes here should be category title
      ),
      body:content
    );
  }
}