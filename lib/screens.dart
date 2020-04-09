import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

var urlVersion = 'https://flutter-backend-training.herokuapp.com';
var urlLogin = 'https://flutter-backend-training.herokuapp.com/login';

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

    var _fourthButton = RaisedButton (
        child: Text("Try stateful Screen"),
        onPressed: () {
          Navigator.pushNamed (
            context, '/stateful'
          );
        }
    );

    var _fifthButton = RaisedButton (
        child: Text("Login Now"),
        onPressed: () {
          Navigator.pushNamed (
              context, '/login'
          );
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

                _fourthButton,

                _fifthButton,

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

class SimpleStatefulScreen extends StatefulWidget {

  @override
  _SimpleStatefulScreenState createState() => _SimpleStatefulScreenState();
}

class _SimpleStatefulScreenState extends State<SimpleStatefulScreen> {

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Simple Stateful"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Counter: ${_count}"),
            RaisedButton(
              child: Text("Click me"),
              onPressed: _buttonClick,
            )
          ],
        ),
      ),
    );
  }

  void _buttonClick() {
     setState((){
       _count++;
     });
  }
}


class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LocalStorage storage = new LocalStorage('myapp');
  String appVersion = "-";

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'username': null, 'password': null};

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Username',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
            onSaved: (String value) {
              formData['username'] = value;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onSaved: (String value) {
              formData['password'] = value;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {

                // This will trigger onSaved
                _formKey.currentState.save();
                print(formData);

                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // Process data.
                  doLogin().then( // function
                      (value){
                          print("Then. value: ${value}");
                          if(value == 'success') {
                              print('Login success');
                          } else {
                              print('Login fail');
                          }
                      });
                }
              },
              child: Text('Login'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(100.0),
        child: buildForm(),
      )
    );
  }

  @override
  void initState() {
    // inisialisasi
    loadVersion();
  }

  void loadVersion() async {
    var response = await http.get(urlVersion);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var obj = json.decode(response.body); // Map <String, dynamic>
    print(obj['version']);

    // Set state
    setState(() {
      appVersion = obj['version'];
    });
  }

  Future<String> doLogin() async {
    var response = await http.post(urlLogin, headers: { 'Content-Type': 'application/json' }, body: json.encode(formData))
      .then((response){
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        var content = json.decode(response.body);
        if (response.statusCode == 200) {
          if (content['success']) {
            storage.setItem("access_token", content['accessToken']);
            return "success";
          }
        }
        return "fail";
    });
    return response;
  }
}
