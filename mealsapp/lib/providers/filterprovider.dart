import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/meals_provider.dart';
enum Filter{
  glucosefree,
  lactosefree,
  vegan,
  vegetarian,
}
class FilterNotifier extends StateNotifier<Map<Filter,bool>>{
  FilterNotifier():super({
    Filter.glucosefree:false,
    Filter.lactosefree:false,
    Filter.vegan:false,
    Filter.vegetarian:false
  });
  void  setFilters(Map<Filter,bool> chosenfilters){
    state=chosenfilters;
  }
  void setFilter(Filter filter, bool isselected){
    state={
      ...state,
      filter:isselected
    };
  }
}

final filternotifier=StateNotifierProvider<FilterNotifier,Map<Filter,bool>>((ref){
  return FilterNotifier();
});

final filteredMealsProvider=Provider((ref) {
  final filteredmeals=ref.watch(mealprovider);
  final selectedFilters=ref.watch(filternotifier);
  return filteredmeals.where((meal) {
      if(selectedFilters[Filter.glucosefree]!&&meal.isGlutenFree==true){
        return false;
      }
      if(selectedFilters[Filter.lactosefree]!&&!meal.isLactoseFree){
        return false;
      }
      if(selectedFilters[Filter.vegan]!&&!meal.isVegan){
        return false;
      }
      if(selectedFilters[Filter.vegetarian]!&&!meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();
});