import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:forms/Data/categorydata.dart';
import 'package:forms/model/groceryfile.dart';
import 'package:forms/widget/newgroceryitem.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<GroceryItem> _groceryitems = [];
  var isloading=true;
  String? error;
  @override
  void initState() {
     _loadItem();
    super.initState();
   
  }
  //this should get run initially
  //so calling this method inside initstate
  void _loadItem() async {
    final url = Uri.https(
        'supple-snow-379905-default-rtdb.firebaseio.com','grocery-list.json');
        try{
          final response = await http.get(url);
           if(response.statusCode>=400){
      setState(() {
       error='Failed to fetch data,please try again later';
      });
    }
    
    if(response.body=='null'){
      setState(() {
        isloading=false;
      });
      return;
      //to make sure that won't executes the below following code
    }

    final Map<String,  dynamic> listdata =json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
     for (final item in listdata.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.itemname == item.value['category'])
          .value;
      loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
     }
    setState(() {
      _groceryitems=loadedItems;
      isloading=false;
    });
        }catch(err){
           setState(() {
          error='something went wrong, please try again later';
          isloading=false;
        });
          //if any of the above things went wrong,this catch would execute
          //if no try catch block here, the app might get crash
       
        }
    
   
  }



  void addItem()  async{
    final newitem=await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );
    //_loadItem();
    //by this loaditem won't be invoked unneccessarily
    if (newitem == null) {
      return;
    }
    setState(() {
      _groceryitems.add(newitem);
    });
  }

  void deleteItem(GroceryItem grocery) {
    //final index = _groceryitems.indexOf(grocery);
    setState(() {
      _groceryitems.remove(grocery);
    });
    final url=Uri.https('supple-snow-379905-default-rtdb.firebaseio.com','grocery-list/${grocery.id}.json');
    //telling we delete by grocery id
      http.delete(url);
    //  if(responsedelete.statusCode>=400){
    //   setState(() {
    //     groceryItems.insert(index, grocery);
    //   });
     
    // }
  }

  @override
  Widget build(BuildContext context) {

    Widget content=const Center(child: Text('Try adding a Grocery!'));

    if(_groceryitems.isNotEmpty){
      content=ListView.builder(
                itemCount: _groceryitems.length,
                itemBuilder: (ctx, index) => Dismissible(
                    key: ValueKey(_groceryitems[index]),
                    onDismissed: (direction) {
                      deleteItem(_groceryitems[index]);
                    },
                    child: ListTile(
                      leading: Icon(Icons.rectangle,
                          color: _groceryitems[index].category.color),
                      title: Text(_groceryitems[index].name),
                      trailing: Text(_groceryitems[index].quantity.toString()),
                    )));
    }
    if(error!=null){
      content=Center(child: Text(error!),);
    }
    if(isloading){
      content=const Center(child: CircularProgressIndicator(),);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(
                onPressed: () {
                  addItem();
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: content
        // ListView(
        //     children: [
        //       for (final grocery in groceryItems)
        //       Column(
        //         children: [
        //           InkWell(
        //             onTap: (){},
        //              child: ListTile(
        //               leading: Icon(Icons.rectangle,color:grocery.category.color),
        //               title: Text(grocery.name),
        //               trailing: Text(grocery.quantity.toString()),
        //               ),
        //            ),
        //         ],
        //       )
        //     ],
        //   ),
        );
  }
}
