import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Login Screen",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('car.png', height: 100, width: 100),
            Text("Login Screen", style: TextStyle(fontSize: 20)),
            Text(
              "Enter username",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(),
            Text(
              "Enter password",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(),
            SizedBox(height: 15),
            MaterialButton(
              onPressed: () {},
              child: Text("Login", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    ),
  );
}
