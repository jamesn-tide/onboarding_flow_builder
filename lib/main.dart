import 'package:flutter/material.dart';
import 'package:onboarding_flow_builder/add_grocery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Grocery> groceryList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groceries'),
      ),
      body: ListView(
        children: List.generate(
          groceryList.length,
          (index) {
            final grocery = groceryList[index];
            return ListTile(
              title: Text(
                grocery.amount.toString() + ' ' + grocery.name,
              ),
              subtitle: Text('Each cost: \$' + grocery.price.toString()),
              trailing:
                  Text('\$' + (grocery.price * grocery.amount).toString()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return GroceryNameForm();
            },
          ));
        },
      ),
    );
  }
}

class Grocery {
  final String name;
  final int amount;
  final int price;

  const Grocery({this.name, this.amount, this.price});

  Grocery copyWith({String name, int amount, int price}) {
    return Grocery(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      price: price ?? this.price,
    );
  }
}
