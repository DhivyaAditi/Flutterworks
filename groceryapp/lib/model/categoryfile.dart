import 'package:flutter/material.dart';
enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}
class Category{
  final String itemname;
  final Color color;
  const Category(this.itemname,this.color);
}