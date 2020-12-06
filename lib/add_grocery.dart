import 'package:flutter/material.dart';

class GroceryNameForm extends StatefulWidget {
  @override
  _GroceryNameFormState createState() => _GroceryNameFormState();
}

class _GroceryNameFormState extends State<GroceryNameForm> {
  var _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Name'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) => setState(() => _name = value),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Banana',
                ),
              ),
              RaisedButton(
                child: const Text('Continue'),
                onPressed: () {
                  if (_name.isEmpty) return null;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GroceryAmountForm(),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GroceryAmountForm extends StatefulWidget {
  @override
  _GroceryAmountFormState createState() => _GroceryAmountFormState();
}

class _GroceryAmountFormState extends State<GroceryAmountForm> {
  int _amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Amount')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() => _amount = int.tryParse(value));
                },
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: '42',
                ),
                keyboardType: TextInputType.number,
              ),
              RaisedButton(
                child: const Text('Continue'),
                onPressed: () {
                  if (_amount == null) return null;
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => GroceryPriceForm(),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GroceryPriceForm extends StatefulWidget {
  @override
  _GroceryPriceFormState createState() => _GroceryPriceFormState();
}

class _GroceryPriceFormState extends State<GroceryPriceForm> {
  int _price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() => _price = int.tryParse(value));
                },
                decoration: const InputDecoration(
                  labelText: 'Price (\$SGD)',
                  hintText: '\$170',
                ),
                keyboardType: TextInputType.number,
              ),
              RaisedButton(
                child: const Text('Continue'),
                onPressed: () {
                  if (_price == null) return null;
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
