import 'package:books_tracker/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DB extends StatefulWidget {
  const DB({super.key});

  @override
  State<DB> createState() => _DBState();
}

class _DBState extends State<DB> {
  String _currStatus = "";

  void onStatus(String msg) {
    setState(() {
      _currStatus = msg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Database Status")),
      body: Column(
        children: [
          GridView.count(
            crossAxisCount: 3, // 3 buttons per row
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,
            padding: EdgeInsets.all(5),
            children: [
              ElevatedButton(
                onPressed: () async {
                  var db = DatabaseHelper.instance;
                },
                child: Text("Create dB"),
              ),
              ElevatedButton(
                onPressed: () async {
                  var db = DatabaseHelper.instance;
                  await db.deleteDb(onStatus);
                },
                child: Text("Delete dB"),
              ),

              ElevatedButton(
                onPressed: () async {
                  var db = DatabaseHelper.instance;
                  await db.createTable(onStatus);
                },
                child: Text("Create Table"),
              ),

              ElevatedButton(
                onPressed: () async {
                  var db = DatabaseHelper.instance;
                  await db.deleteTable(onStatus);
                },
                child: Text("Delete Table"),
              ),

              ElevatedButton(
                onPressed: () async {
                  var db = DatabaseHelper.instance;
                  await db.showTable(onStatus);
                },
                child: Text("Show Table"),
              ),
            ],
          ),

          SizedBox(height: 10),

          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              child: Text(_currStatus),
            ),
          ),
        ],
      ),
    );
  }
}
