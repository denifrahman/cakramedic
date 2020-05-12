
import 'package:cakramedic/values/values.dart';
import 'package:flutter/material.dart';


class LoginWidget extends StatelessWidget {

  void onButtonPressed(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SizedBox(
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 10,
                      top: 10,
                      child: FlatButton(
                        onPressed: () => this.onButtonPressed(context),
                        color: Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Click me",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryBackground,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 10,
                              height: 18,
                              margin: EdgeInsets.only(left: 23, top: 33),
                              child: Image.asset(
                                "assets/logo.png",
                                fit: BoxFit.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "email@example.com",
                            contentPadding: EdgeInsets.all(0),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          autocorrect: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 24),
                  child: Text(
                    "Login 👋",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 48, 50, 54),
                      fontFamily: "",
                      fontWeight: FontWeight.w700,
                      fontSize: 34,
                      letterSpacing: 0.41,
                      height: 1.20588,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 285,
                  margin: EdgeInsets.only(left: 24, top: 15),
                  child: Text(
                    "Login to existing account or create a new one.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 118, 122, 133),
                      fontFamily: "",
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 327,
                  height: 30,
                  margin: EdgeInsets.only(top: 62),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Email address",
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontFamily: "",
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                    maxLines: 1,
                    autocorrect: false,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 327,
                  height: 30,
                  margin: EdgeInsets.only(top: 35),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontFamily: "",
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                    ),
                    obscureText: true,
                    maxLines: 1,
                    autocorrect: false,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: 327,
                    height: 56,
                    margin: EdgeInsets.only(top: 24),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryElement,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "MASUK",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: "",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 167,
                  height: 20,
                  margin: EdgeInsets.only(left: 99, top: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 18,
                        child: Text(
                          "FORGOT PASSWORD?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.2,
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: AppColors.secondaryElement,
                          ),
                          child: Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 167,
                  height: 20,
                  margin: EdgeInsets.only(left: 99),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 18,
                        margin: EdgeInsets.only(bottom: 2),
                        child: Text(
                          "DAFTAR",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}