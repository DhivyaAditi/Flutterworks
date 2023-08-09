import 'package:flutter/material.dart';
import 'package:mealsapp/model/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem( {super.key,required this.category,required this.onselected});
  final Category category;
  final  void Function() onselected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onselected,
      borderRadius: BorderRadius.circular(16),
      splashColor: Theme.of(context).primaryColor,
       
      //going to Inkwell for making the widgets ontappable
      //this can be done with gesture detector
      //gesture detector won't provide feedback,Inkwell does
      child: Container(
        margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(0.9)
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(category.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ))),
    );
  }
}
