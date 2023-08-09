//gonna be stateful widget as some state are gonna maintained in this

import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class AddnewExpense extends StatefulWidget {
  const AddnewExpense({super.key, required this.addnewExpense});
  final void Function(Expense expense) addnewExpense;
  @override
  State<AddnewExpense> createState() => _AddnewExpenseState();
}

class _AddnewExpenseState extends State<AddnewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void datepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

 // void _showDialog() {
    // if (Platform.isIOS) {
    //   showCupertinoDialog(
    //       context: context,
    //       builder: (ctx) => CupertinoAlertDialog(
    //             title: const Text('Invalid Input'),
    //             content: const Text(
    //                 'please make sure that you have entered title, amount, Date and Category'),
    //             actions: [
    //               TextButton(
    //                 onPressed: () {
    //                   Navigator.pop(ctx);
    //                 },
    //                 child: const Text('ok'),
    //               )
    //             ],
    //           ));
    // }
    // else{
    //   showDialog(
    //     context: context,
    //     builder: (ctx) => AlertDialog(
    //       title: const Text('Invalid Input'),
    //       content: const Text(
    //           'please make sure that you have entered title, amount, Date and Category'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.pop(ctx);
    //           },
    //           child: const Text('ok'),
    //         )
    //       ],
    //     ),
    //   );
    // }
 // }

  void _submitExpense() {
    final enteredamount = double.tryParse(_amountController.text);
    final amountIsValid = enteredamount == null || enteredamount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsValid ||
        _selectedDate == null) {
      //_showDialog();
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'please make sure that you have entered title, amount, Date and Category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('ok'),
            )
          ],
        ),
      );
    
      return;
    }
    widget.addnewExpense(
      Expense(
          title: _titleController.text,
          amount: enteredamount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
    //to close automatically without clicking close
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryspace = MediaQuery.of(context).viewInsets.bottom;
    //viewinsets is the object that tells about the UI that might be overlapping
    // to specify the viewinsets to find overlapping, viewInsets.bottom
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          //though we apply singlechid scrollview ,once the kryboard close , it won't take the entire space
          //wrapping it with sizedbox making width as double.infinity
          child: Padding(
            //so specifying it in padding bottom as mediaqueryspace+16
            // padding:const EdgeInsets.fromLTRB(16,16,16,16) ,
            padding: EdgeInsets.fromLTRB(16, 16, 16, mediaQueryspace + 16),
            child: Column(children: [
              if (width >= 600)
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        //onChanged: _gettitle,
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          label: Text('Amount'),
                          //prefixText: '\$'
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  //onChanged: _gettitle,
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
              if (width >= 600)
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (element) => DropdownMenuItem(
                                value: element,
                                //the value will be stored internally but won't be visible to user as child text
                                child: Text(element.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate == null
                            ? 'No Date Found'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: datepicker,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    )),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: const InputDecoration(
                          label: Text('Amount'),
                          //prefixText: '\$'
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Row(
                      children: [
                        Text(_selectedDate == null
                            ? 'No Date Found'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: datepicker,
                          icon: const Icon(Icons.calendar_month),
                        )
                      ],
                    )),
                  ],
                ),
              const SizedBox(width: 16),
              if (width >= 600)
                Row(
                  children: [
                    const Spacer(),
                     OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                        const SizedBox(width:4),
                    ElevatedButton(
                        onPressed: _submitExpense,
                        child: const Text('Save Expense')),
                   
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (element) => DropdownMenuItem(
                                value: element,
                                //the value will be stored internally but won't be visible to user as child text
                                child: Text(element.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        }),
                    const Spacer(),
                    
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // print(_title);
                          // _titleController.clear;
                          // _amountController.clear;
                        },
                        child: const Text('Cancel')),
                        const SizedBox(width:4),
                        ElevatedButton(
                        onPressed: _submitExpense,
                        // onPressed: () {
                        //   // print(_title);
                        //   print(_titleController.text);
                        //   print(_amountController.text);
                        //   print(_selectedDate);
                        //   print(_selectedCategory);
                        //   //submitExpense();
                        // },
                        child: const Text('Save Expense')),
                  ],
                ),
            ]),
          ),
        ),
      );
    });
  }
}
