import 'package:flutter/material.dart';
import 'dudos.dart';
import 'shopping_list.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.green,
      ),
      //home: new RandomWords(),
      //home: new ListHttp(),
      home: new Main(),
     /*  home: new ShoppingList(
      products: <Product>[
        new Product(name: 'Eggs'),
        new Product(name: 'Flour'),
        new Product(name: 'Chocolate chips'),
      ],
    ), */
    );
  }
}
