import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forms/Data/categorydata.dart';
import 'package:forms/model/categoryfile.dart';
import 'package:forms/model/groceryfile.dart';
import 'package:http/http.dart' as http;

class NewItem extends StatefulWidget {
  const NewItem({super.key});
  @override
  State<NewItem> createState() {
    return _NewItem();
  }
}

class _NewItem extends State<NewItem> {
  final _formkey = GlobalKey<FormState>();
  var entertedTitle = '';
  int enteredAmount = 1;
  var _selectedcategory = categories[Categories.fruit]!;
  var issending = false;

  void addItem() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      setState(() {
        issending = true;
      });
      final url = Uri.https('supple-snow-379905-default-rtdb.firebaseio.com',
          'grocery-list.json');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': entertedTitle,
            'quantity': enteredAmount,
            'category': _selectedcategory.itemname
          },
        ),
      );
      final Map<String, dynamic> restdata = json.decode(response.body);

      if (context.mounted) {
        Navigator.of(context).pop(GroceryItem(
            id: restdata['name'],
            name: entertedTitle,
            quantity: enteredAmount,
            category: _selectedcategory));
      }
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new item'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text('title')),
                    maxLength: 50,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.trim().length <= 1 ||
                          value.trim().length > 50) {
                        return 'Value must be between 1 and 50 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      entertedTitle = value!;
                      //no need of setstate as validator.save is there
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: enteredAmount.toString(),
                          decoration:
                              const InputDecoration(label: Text('quantity')),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value)! <= 0) {
                              return 'Must be a valid positive number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            enteredAmount = int.parse(value!);
                          },
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                          child: DropdownButtonFormField(
                              value: _selectedcategory,
                              items: [
                                for (final category in categories.entries)
                                  DropdownMenuItem(
                                    value: category.value,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.rectangle,
                                          color: category.value.color,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(category.value.itemname),
                                      ],
                                    ),
                                  ),
                              ],
                              onChanged: (value) {
                                //as we don't use onsaved we use setstate
                                setState(() => _selectedcategory = value!);
                              }))
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: issending
                              ? null
                              : () {
                                  _formkey.currentState!.reset();
                                },
                          child: const Text('Reset')),
                      ElevatedButton(
                          onPressed: issending ? null : addItem,
                          child: issending
                              ? const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text('Add Item'))
                    ],
                  )
                ],
              )),
        ));
  }
}
