import 'package:flutter/material.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:onboarding_flow_builder/main.dart';

List<Page> onGenerateGroceryPages(Grocery grocery, List<Page> pages) {
  return [
    MaterialPage<void>(child: GroceryNameForm()),
    if (grocery.name != null) MaterialPage<void>(child: GroceryAmountForm()),
    if (grocery.amount != null) MaterialPage<void>(child: GroceryPriceForm()),
  ];
}

class GroceryFlow extends StatelessWidget {
  static Route<Grocery> route() {
    return MaterialPageRoute(builder: (_) => GroceryFlow());
  }

  @override
  Widget build(BuildContext context) {
    return const FlowBuilder<Grocery>(
      state: Grocery(),
      onGeneratePages: onGenerateGroceryPages,
    );
  }
}

class GroceryNameForm extends StatefulWidget {
  @override
  _GroceryNameFormState createState() => _GroceryNameFormState();
}

class _GroceryNameFormState extends State<GroceryNameForm> {
  var _name = '';

  void _continuePressed() {
    context.flow<Grocery>().update((profile) => profile.copyWith(name: _name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context
              .flow<Grocery>()
              .complete((profile) => profile.copyWith(name: _name)),
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
                onPressed: _name.isNotEmpty ? _continuePressed : null,
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

  void _continuePressed() {
    context
        .flow<Grocery>()
        .update((profile) => profile.copyWith(amount: _amount));
  }

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
                onPressed: _amount != null ? _continuePressed : null,
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

  void _continuePressed() {
    context
        .flow<Grocery>()
        .complete((profile) => profile.copyWith(price: _price));
  }

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
                onPressed: _price != null ? _continuePressed : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
