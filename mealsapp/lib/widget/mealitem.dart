import 'package:flutter/material.dart';
import 'package:mealsapp/model/meals.dart';
import 'package:mealsapp/widget/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal,required this.selectedmeal});
  final Meal meal;
final void Function(Meal meal) selectedmeal;

String get affordable{
  return meal.affordability.name[0].toUpperCase()+meal.affordability.name.substring(1);
}

String get cmplexity{
  return meal.complexity.name[0].toUpperCase()+meal.complexity.name.substring(1);
}
  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //as border radius and shape won't apply to stack element
      clipBehavior: Clip.hardEdge,
      //clipbehaviour helps with it
      child: InkWell(
        //to navigate once the card is pressed
        onTap: (){
           selectedmeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag:meal.id,
              child:
                //fadeinImage displays you the faded in image
                FadeInImage(
                  placeholder: MemoryImage(
                      //memory tells memory how to load image from memory
                      kTransparentImage
                      //gives a dummy image that will be transparent
                      ),
                  image: NetworkImage(meal.imageUrl),
                  fit: BoxFit.cover,
                  height: 200,
                  //once the height of the image is set to 200, it shrinks the width
                  width: double.infinity,
                  //so to take entire width of the screen , it is double.infinity
                ),),
                Positioned(
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Container(
                      padding:
                          const EdgeInsets.symmetric(vertical: 6, horizontal: 22),
                      color: const Color.fromARGB(132, 0, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            meal.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            softWrap: true,
                            //makes sure the text is looking good
                            overflow: TextOverflow.ellipsis,
                            //tells overflow
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MealItemTrait(Icons.schedule, '${meal.duration} min'),
                              const SizedBox(width: 20),
                              MealItemTrait(Icons.work,cmplexity),
                              const SizedBox(width:20),
                              MealItemTrait(Icons.attach_money, affordable),
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
          
        ),
      
    );
  }
}
