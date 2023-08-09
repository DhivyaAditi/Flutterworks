import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/model/meals.dart';

//statenotifier is of generic type
//should return List<Meal>
class FavoriteStateNotifier extends StateNotifier<List<Meal>>{
  //calling the constructor super to invoke statenotifierparentclass
  //as it requires the type of List<meal> am passing the emptylist here
  FavoriteStateNotifier():super([]);

 bool favouriteStateToggling(Meal meal){
  //with state we can access the list
  final isFavourite=state.contains(meal);

  if(isFavourite){
    //state.remove is not supported we should reassign
    state=state.where((element) =>element.id!=meal.id ).toList();
    return false;
  }else{
    state=[...state,meal];
    return true;
  }
 }
}

final favouritemealprovider =StateNotifierProvider<FavoriteStateNotifier,List<Meal>>((ref) {
//will return List<Meal> by instantiating class here
   return FavoriteStateNotifier();
}
);