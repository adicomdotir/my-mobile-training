import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(Login());
}

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text.rich(TextSpan(
                      text: 'bear',
                      style: TextStyle(
                          color: Color(0xFF9D7C60),
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: '.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 60,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                  Text(
                    'Log in on bear',
                    style: TextStyle(
                        color: Color(0xFF9D7C60),
                        fontSize: 20,),
                  ),
                  SizedBox(height: 30,),
                  Image.asset('assets/images/logo.png', height: 120,),
                  SizedBox(height: 30,),
                  _buildTextFormField(),
                  SizedBox(height: 20,),
                  _buildTextFormFieldPassword(),
                  SizedBox(height: 20,),
                  _buildButton(),
                  SizedBox(height: 10,),
                  Text('forget password ? ',
                    style: TextStyle(
                      color: Color(0xff9d7c60)
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        isDense: true,
        fillColor: Color(0xff9d7c60).withOpacity(0.3),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(50)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff9d7c60), width: 1.5),
          borderRadius: BorderRadius.circular(50)
        ),
        prefixIcon: Icon(Icons.mail, color: Color(0xff9d7c60),),
        hintText: 'Username'
      ),
    );
  }

  Widget _buildTextFormFieldPassword() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        isDense: true,
        fillColor: Color(0xff9d7c60).withOpacity(0.3),
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(50)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff9d7c60), width: 1.5),
          borderRadius: BorderRadius.circular(50)
        ),
        prefixIcon: Icon(Icons.lock, color: Color(0xff9d7c60),),
        hintText: 'Password'
      ),
    );
  }

  Widget _buildButton() {
    return MaterialButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50)
      ),
      height: 45,
      minWidth: double.infinity,
      color: Color(0xff9d7c60),
      child: Text('LOGIN WHIT EMAIL',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
