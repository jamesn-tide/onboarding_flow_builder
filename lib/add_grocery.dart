import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_flow_builder/main.dart';

class GroceryFlow extends StatelessWidget {
  const GroceryFlow({Key key}) : super(key: key);

  static Route<Grocery> route() {
    return MaterialPageRoute(
      builder: (context) {
        return GroceryFlow();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      state: Grocery(),
      onGeneratePages: onGeneratePages,
    );
  }

  List<Page> onGeneratePages(Grocery grocery, pages) {
    return [
      MaterialPage(child: GroceryNameForm()),
      if (grocery.name != null) MaterialPage(child: GroceryAmountForm()),
      if (grocery.amount != null) MaterialPage(child: GroceryPriceForm()),
    ];
  }
}

class GroceryNameForm extends StatefulWidget {
  @override
  _GroceryNameFormState createState() => _GroceryNameFormState();
}

class _GroceryNameFormState extends State<GroceryNameForm> {
  var _name = '';

  void handleFlow() {
    context.flow<Grocery>().update((grocery) {
      return grocery.copyWith(name: _name);
    });
  }

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
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: _name.isNotEmpty ? handleFlow : null,
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

  void handleFlow() {
    context.flow<Grocery>().update((grocery) {
      return grocery.copyWith(amount: _amount);
    });
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
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: _amount != null ? handleFlow : null,
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

  void handleFlow() {
    context.flow<Grocery>().complete((grocery) {
      return grocery.copyWith(price: _price);
    });
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
              ElevatedButton(
                child: const Text('Continue'),
                onPressed: _price != null ? handleFlow : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
