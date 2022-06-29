import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Image(
                image: AssetImage('assets/images/login_background.jpg'),
                height: MediaQuery.of(context).size.height / 2.5,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Text(
                'FRENZY',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Username',
                      prefixIcon: Icon(
                        Icons.account_box,
                        size: 30,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  alignment: Alignment.center,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    color: Theme.of(context).primaryColor,
                    height: 80,
                    child: Text(
                      'Don\'t have an account? Sign up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
