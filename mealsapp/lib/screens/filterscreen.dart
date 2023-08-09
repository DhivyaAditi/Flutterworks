import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/filterprovider.dart';
// // enum Filter{
// //   glucosefree,
// //   lactosefree,
// //   vegan,
// //   vegetarian,
// // }
// //gonna import from filterprovider
// class FilterScreen extends ConsumerStatefulWidget {
//   const FilterScreen({super.key,});
// //final Map<Filter,bool> appliedfilters;
//   @override
//   ConsumerState<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends ConsumerState<FilterScreen> {

//   var isglutenfree=false;
//   var islactosefree=false;
//   var isvegan=false;
//   var isVegetarian=false;
//   @override
//   void initState() {
    
//     super.initState();
//     final appliedfilters=ref.read(filternotifier);
//     isglutenfree=appliedfilters[Filter.glucosefree]!;
//     islactosefree=appliedfilters[Filter.lactosefree]!;
//     isvegan=appliedfilters[Filter.vegan]!;
//     isVegetarian=appliedfilters[Filter.vegetarian]!;
//     // isglutenfree=widget.appliedfilters[Filter.glucosefree]!;
//     // islactosefree=widget.appliedfilters[Filter.lactosefree]!;
//     // isvegan=widget.appliedfilters[Filter.vegan]!;
//     // isVegetarian=widget.appliedfilters[Filter.vegetarian]!;
     
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar: AppBar(
//       title: const Text('Your Filter'),
//      ),
//     //  drawer: TabDrawer(selectedscreen: (identifier){
//     //     Navigator.of(context).pop();
//     //     if(identifier=='meals'){
//     //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>
//     //       const TabsScreen()));
//     //     }
//     //  }),
//      //gonna display drawer, as iam in filterscreen 
//      //wanna goback to mealscreen
//      ///----another approach----////
//      body: WillPopScope(
//          onWillPop: ()async{
//           ref.read(filternotifier.notifier).setFilters({
//             Filter.glucosefree:isglutenfree,
//             Filter.lactosefree:islactosefree,
//             Filter.vegan:isvegan,
//             Filter.vegetarian:isVegetarian
//             // 'gluten-free':isglutenfree,
//             // 'lactose-free':islactosefree,
//             // 'vegan':isvegan,
//             // 'vegetarian':isVegetarian
//           },
//           );
//           return true;
//           //this helps to get data while popping back 
//           // Navigator.of(context).pop({
//           //   Filter.glucosefree:isglutenfree,
//           //   Filter.lactosefree:islactosefree,
//           //   Filter.vegan:isvegan,
//           //   Filter.vegetarian:isVegetarian
//           //   // 'gluten-free':isglutenfree,
//           //   // 'lactose-free':islactosefree,
//           //   // 'vegan':isvegan,
//           //   // 'vegetarian':isVegetarian
//           // },
//           // );
//           // return false;
//           //tells whether it should popback
//           //as we are doing it manually, doesn't make sense of returning true
//           //as it is future<bool> making the method async
//          },
//          child:Column(
//           children: [
//             SwitchListTile(
//               value: isglutenfree, 
//               onChanged: (value){
//                 setState(() {
//                   isglutenfree=value;
//                 });
//               },
//             title: Text('Gluten-free',
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onBackground
//             ),),
//             subtitle: Text('Only include gluten-free meals',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onBackground
//             ),),
//             activeColor: Theme.of(context).colorScheme.tertiary,
//             contentPadding: const EdgeInsets.only(left:34,right:22),
//             ),
//             SwitchListTile(
//               value: islactosefree, 
//               onChanged: (value){
//                 setState(() {
//                   islactosefree=value;
//                 });
//               },
//             title: Text('Lactose-free',
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onBackground
//             ),),
//             subtitle: Text('Only include lactose-free meals',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onBackground
//             ),),
//             activeColor: Theme.of(context).colorScheme.tertiary,
//             contentPadding: const EdgeInsets.only(left:34,right:22),
//             ),
//             SwitchListTile(
//               value: isvegan, 
//               onChanged: (value){
//                 setState(() {
//                   isvegan=value;
//                 });
//               },
//             title: Text('Vegan-free',
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onBackground
//             ),),
//             subtitle: Text('Only include vegan meals',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onBackground
//             ),),
//             activeColor: Theme.of(context).colorScheme.tertiary,
//             contentPadding: const EdgeInsets.only(left:34,right:22),
//             ),
//             SwitchListTile(
//               value: isVegetarian, 
//               onChanged: (value){
//                 setState(() {
//                   isVegetarian=value;
//                 });
//               },
//             title: Text('Vegetarian',
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onBackground
//             ),),
//             subtitle: Text('Only include vegitarian meals',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//               color: Theme.of(context).colorScheme.onBackground
//             ),),
//             activeColor: Theme.of(context).colorScheme.tertiary,
//             contentPadding: const EdgeInsets.only(left:34,right:22),
//             )
//           ],
//          ),
//      ),
//     );
//   }
// }

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var activefilters=ref.watch(filternotifier);
    //getting empty list from the filternotifier provider
    return Scaffold(
     appBar: AppBar(
      title: const Text('Your Filter'),
     ),
     body:Column(
          children: [
            SwitchListTile(
              value: activefilters[Filter.glucosefree]!, 
              onChanged: (value){
                   ref.watch(filternotifier.notifier).setFilter(Filter.glucosefree, value);
              },
            title: Text('Gluten-free',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),),
            subtitle: Text('Only include gluten-free meals',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left:34,right:22),
            ),
            SwitchListTile(
               value: activefilters[Filter.lactosefree]!, 
                  //setting the value from activefilter (from filternotifier)
              onChanged: (value){
                   ref.watch(filternotifier.notifier).setFilter(Filter.glucosefree, value);
                },
            title: Text('Lactose-free',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),),
            subtitle: Text('Only include lactose-free meals',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left:34,right:22),
            ),
            SwitchListTile(
               value: activefilters[Filter.vegan]!, 
              onChanged: (value){
                   ref.watch(filternotifier.notifier).setFilter(Filter.vegan, value);
              },
            title: Text('Vegan-free',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),),
            subtitle: Text('Only include vegan meals',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left:34,right:22),
            ),
            SwitchListTile(
              value: activefilters[Filter.vegetarian]!, 
              onChanged: (value){
                   ref.watch(filternotifier.notifier).setFilter(Filter.vegetarian, value);
              },
            title: Text('Vegetarian',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),),
            subtitle: Text('Only include vegitarian meals',style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            ),),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left:34,right:22),
            )
          ],
         ),
     );
    
  }
}


