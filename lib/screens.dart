import 'package:flutter/material.dart';
import 'components.dart';
import 'model.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage(this.title);

  _askConfirm (BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    print("After confirm screen");
    print(result);
    // Next code ...

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var _firstButton = RaisedButton(
      child: Text("Go to Other Screen"),
      onPressed: (){

        var data = Map<String, dynamic>();
        data['name'] = 'John';
        data['email'] = 'john@gmail.com';
        data['phone'] = '081287737765';

        // Go to other screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtherScreen(data)),
        );
      },
    );

    var _secondButton = RaisedButton(
      child: Text("Named routes"),
      onPressed: () {
        Navigator.pushNamed (
          context,
          DetailScreen.routeName,
          arguments: Profile(
            "John",
            "john@gmail.com",
            "081287736665",
          ),
        );
      },
    );

    var _thirdButton = RaisedButton (
        child: Text("Confirm"),
        onPressed: () {
          _askConfirm(context);
        }
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              children: <Widget>[
                // First Button
                _firstButton,

                // Second Button
                _secondButton,

                // Third Button
                _thirdButton,

              ],
            )
        ),
      ),
    );
  }

}

class OtherScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  OtherScreen(this.data);

  _buildRow (String label, dynamic value) {
    return TextOutput(label, value);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(this.data['name']),
      ),
      body: Center (
        child: Container (
          child: Column (
            children: <Widget>[
              _buildRow("Name", this.data['name']),
              _buildRow("Email", this.data['email']),
              _buildRow("Phone", this.data['phone']),

              RaisedButton(
                child: Text("Go Back"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}


class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final Profile args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Center (
        child: Container (
          child: Column (
            children: <Widget>[
              TextOutput("Name", args.name),
              TextOutput("Email", args.email),
              TextOutput("Phone", args.phone),

              RaisedButton(
                child: Text("Go Back"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),


            ],
          ),
        ),
      ),
    );
  }
}



class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Pop here with "Yep"...
                  Navigator.pop(context,"Y");
                },
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Pop here with "Nope"
                  Navigator.pop(context,"N");
                },
                child: Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}