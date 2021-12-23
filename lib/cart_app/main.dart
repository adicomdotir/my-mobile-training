import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'cart.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      home: Login(),
    )
  );
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _txtEmailCtrl = TextEditingController();
  final TextEditingController _txtPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF8500FF),
        body: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      )),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 50,
                          color: Color(0xFF8500FF)),
                    ),
                    TextFormFieldWidget(
                        controller: _txtEmailCtrl, name: 'Email'),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldWidget(
                        controller: _txtPasswordCtrl, name: 'Password'),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) => Cart()));
                        },
                        minWidth: double.infinity,
                        height: 50,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        color: Color(0xFF8500FF),
                        child: Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
    );
  }
}

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String name;

  const TextFormFieldWidget(
      {Key? key, required this.controller, required this.name})
      : super(key: key);

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        style: TextStyle(fontSize: 12),
        textAlignVertical: TextAlignVertical.bottom,
        controller: widget.controller,
        textInputAction: TextInputAction.go,
        autofocus: false,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
            fillColor: Colors.red,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: widget.name,
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }
}
