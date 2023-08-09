
import 'package:mealsapp/Data/dummydata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealprovider= Provider((ref){
  //provider requires a function that accepts the parameter
  //of type providerref
 return meals;
});