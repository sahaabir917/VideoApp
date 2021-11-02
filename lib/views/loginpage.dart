import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videotutorial/bloc/loginbloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    obscureText: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: "Enter Your Email",
                        hintStyle: TextStyle(color: Colors.white70)
                        ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter Your Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        hintStyle: TextStyle(color: Colors.white70),
                        ),
                  ),
                  RaisedButton(
                      child: Text("login"),
                      color: Colors.redAccent,
                      onPressed: () {
                        var email = emailController.text;
                        var password = passwordController.text;
                        BlocProvider.of<LoginBloc>(context)
                            .add(FetchLoginInfo(email, password));
                      }),
                  BlocBuilder<LoginBloc, LoginState>(
                    bloc: BlocProvider.of<LoginBloc>(context),
                    builder: (context, loginState) {
                      if(loginState is LoginInitial){
                        return Container();
                      }
                      else if(loginState is LoginInOperationSuccess){
                        Navigator.pushNamed(context, "/video_page");
                        return Container();
                      }
                      else if(loginState is LoginFailed){
                        return Container(
                          child: Text("Wrong Email Or Password"),
                        );
                      }
                      else{
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
