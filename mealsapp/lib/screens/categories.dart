import 'package:flutter/material.dart';
import 'package:mealsapp/Data/dummydata.dart';
import 'package:mealsapp/model/category.dart';
import 'package:mealsapp/model/meals.dart';
import 'package:mealsapp/screens/mealsscreen.dart';
import 'package:mealsapp/widget/categoryitem.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availablemeals});
  final List<Meal> availablemeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        //to add vysnc parameter(requires tickerprrovider parameter)
        //done by adding with SingleTickerProviderMixin
        vsync: this,
        duration: const Duration(
          milliseconds: 300,
        ),
        lowerBound: 0,
        upperBound: 1
        //after the animation execution of execution for 300 seconds
        //value will be 1(that is how bound value works)
        //animation lies between these values
        );
        _animationController.forward();
  }

//final void Function(Meal meal) favouritemeals;
  void _selectedCategory(BuildContext context, Category category) {
    final filteredmeals = widget.availablemeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    //this method should accept parameter type category
    //so importing category class from model file
    //to display that category's title and meals list
    //to display meals, import dummydata
    //Navigator.push(context,route)
    //the above one can also be used
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredmeals,
        ),
      ),
    );
  }

  @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//         animation: _animationController,
//         child: GridView(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 3 / 2,
//                 crossAxisSpacing: 20,
//                 mainAxisSpacing: 20),
//             children: //availableCategories.map((e) => CategoryItem(e)).toList()
//                 [
//               //list won't allow set brackets
//               for (final category in availableCategories)
//                 CategoryItem(
//                     category: category,
//                     onselected: () {
//                       _selectedCategory(context, category);
//                     })
//             ]),
//         builder: (context, child) => Padding(
//               padding: EdgeInsets.only(
//                   top: 100 - _animationController.upperBound * 100),
//               child: child,
//             ));
//   }
// }

 Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            children: //availableCategories.map((e) => CategoryItem(e)).toList()
                [
              //list won't allow set brackets
              for (final category in availableCategories)
                CategoryItem(
                    category: category,
                    onselected: () {
                      _selectedCategory(context, category);
                    })
            ]),
        builder: (context, child) => SlideTransition(
          // position:_animationController.drive(
          //   Tween(
          //     begin: const Offset(0, 0.3),
          //     end:const Offset(0, 0),
          //   )
          // ) ,
           position:
            Tween(
              begin: const Offset(0, 0.3),
              end:const Offset(0, 0),
            ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
          
          child: child,)
          );
  }
}
