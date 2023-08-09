
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/favourite_meal_provider.dart';
import 'package:mealsapp/providers/filterprovider.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/filterscreen.dart';
import 'package:mealsapp/screens/mealsscreen.dart';
import 'package:mealsapp/widget/drawer.dart';

// //global variables so i can reuse
// //  Map<Filter,bool> kinitialFilters = {
// //     Filter.glucosefree:false,
// //     Filter.lactosefree:false,
// //     Filter.vegan:false,
// //     Filter.vegetarian:false,
// // };
// class TabsScreen extends ConsumerStatefulWidget {
//   const TabsScreen({super.key});
//   @override
//   ConsumerState<TabsScreen> createState() {
//          return _TabsScreenState();
//   } 
// }
// class _TabsScreenState extends ConsumerState<TabsScreen> {
//  // var selectedFilters =kinitialFilters;
//  // final List<Meal> favouitemeals = [];

//   //to show message if the meal is removed from favourite and added to favourite
//   // void showmessage(String message) {
//   //   ScaffoldMessenger.of(context).clearSnackBars();
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content: Text(message),
//   //     ),
//   //   );
//   // }

//   // void setFavouriteMeals(Meal meal) {
//   //   final existing = favouitemeals.contains(meal);
//   //   if (existing) {
//   //     setState(() {
//   //       favouitemeals.remove(meal);
//   //     });
//   //     showmessage('No longer a favourite:(');
//   //   } else {
//   //     setState(() {
//   //       favouitemeals.add(meal);
//   //     });
//   //     showmessage('Added to favourite:)');
//   //   }
//   // }

//   int selectedindex = 1;

//   void navigateScreen(int index) {
//     setState(() {
//       selectedindex = index;
//     });
//   }

//   void showSelectedScreen(String identifier) {
//     Navigator.of(context).pop();
//     if (identifier == 'filters') {
//       //as push is of type future adding async
//       //user may take many minutes to navigate back so it is type future
//       //as push is a generic type like List<>
//       //we can define the datatype like push<map<Filter,bool>>
//        Navigator.of(context).push<Map<Filter,bool>>(
//         MaterialPageRoute(builder: (ctx) => const FilterScreen()),
//       );
//       // setState(() {
//       //   selectedFilters=filteredvalue ?? kinitialFilters;
//       //}
//       //);


      
      
//       //once I navigate to filterscreen i can't able to come to categories
//       //still the drawer is in open
//       //so to avoid
//     } 
  
//     // else {
//     //   Navigator.of(context).pop();
//     // }
//     //if i have else here when i click meals , it pops first then it comes to if else
//     //if i have else again it will pop
//     //as a result empty scaffold 
//   }

//   @override
//   Widget build(context) {
//     final meal=ref.watch(mealprovider);
//     final selectedFilters=ref.watch(filternotifier);
//     final  availablemeals=meal.where((meal) {
//       if(selectedFilters[Filter.glucosefree]!&&meal.isGlutenFree==true){
//         return false;
//       }
//       if(selectedFilters[Filter.lactosefree]!&&!meal.isLactoseFree){
//         return false;
//       }
//       if(selectedFilters[Filter.vegan]!&&!meal.isVegan){
//         return false;
//       }
//       if(selectedFilters[Filter.vegetarian]!&&!meal.isVegetarian){
//         return false;
//       }
//       return true;
//     }).toList();


//     Widget activescreen = CategoriesScreen(
//       availablemeals: availablemeals
//     );
//     var activescreenTitle = 'Categories';

//     if (selectedindex == 2) {
//       final favouritemeals=ref.watch(favouritemealprovider);
//       //if selectedindex=1, display category screen
//       //if selectedindex=2, display favourite screen, favourite screen gonna route like Meals screen
//       //so mealsscreen
//       // activescreen = const MealsScreen(title: 'Favourites', meals: []);
//       // activescreenTitle = 'Your_Favourite';
//       //the problem in mealsscreen is it will return category of the meal  if meal is not empty, also if meal is empty
//       //am using this widget so, it accepts parameter as title
//       //aslo am passing title in scaffold
//       //two appbars prblm
//       //making title optional
//       //this is resolved by adding? the value can be null, it won't neccessarily ask for title when you invoke mealsscreen
//       activescreen = MealsScreen(
//         meals:favouritemeals,
//       );
//       activescreenTitle = 'Your Favourite';
//     }

//     return Scaffold(
//       appBar: AppBar(
//         //setting title according to the screen
//         title: Text(activescreenTitle),
//       ),
//       drawer: TabDrawer(
//         selectedscreen: showSelectedScreen,
//       ),
//       body: activescreen,
//       bottomNavigationBar: BottomNavigationBar(
//           onTap: (index) {
//             index == 1
//                 ? index = 2
//                 : index == 2
//                     ? index == 1
//                     : index == 1;
//             navigateScreen(index);
//           },
//           items: const [
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.set_meal), label: 'Categories'),
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.star), label: 'Favourites'),
//           ]),
//     );
//   }
// }

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
         return _TabsScreenState();
  } 
}
class _TabsScreenState extends ConsumerState<TabsScreen> {

  int selectedindex = 1;

  void navigateScreen(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  void showSelectedScreen(String identifier) {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
       Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(builder: (ctx) => const FilterScreen()),
      );
    } 
  }

  @override
  Widget build(context) {
    final  availablemeals=ref.watch(filteredMealsProvider);


    Widget activescreen = CategoriesScreen(
      availablemeals: availablemeals
    );
    var activescreenTitle = 'Categories';

    if (selectedindex == 2) {
      final favouritemeals=ref.watch(favouritemealprovider);
      //if selectedindex=1, display category screen
      //if selectedindex=2, display favourite screen, favourite screen gonna route like Meals screen
      //so mealsscreen
      // activescreen = const MealsScreen(title: 'Favourites', meals: []);
      // activescreenTitle = 'Your_Favourite';
      //the problem in mealsscreen is it will return category of the meal  if meal is not empty, also if meal is empty
      //am using this widget so, it accepts parameter as title
      //aslo am passing title in scaffold
      //two appbars prblm
      //making title optional
      //this is resolved by adding? the value can be null, it won't neccessarily ask for title when you invoke mealsscreen
      activescreen = MealsScreen(
        meals:favouritemeals,
      );
      activescreenTitle = 'Your Favourite';
    }

    return Scaffold(
      appBar: AppBar(
        //setting title according to the screen
        title: Text(activescreenTitle),
      ),
      drawer: TabDrawer(
        selectedscreen: showSelectedScreen,
      ),
      body: activescreen,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            index == 1
                ? index = 2
                : index == 2
                    ? index == 1
                    : index == 1;
            navigateScreen(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Favourites'),
          ]),
    );
  }
}
