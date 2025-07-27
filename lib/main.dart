import 'package:books_tracker/pages/favorites_page.dart';
import 'package:books_tracker/pages/home_page.dart';
import 'package:books_tracker/pages/saved_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _currentSelectedItem = 0;

  final List<Widget> _pages = [HomePage(), SavedPage(), FavoritesPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Books Tracker"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_currentSelectedItem],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedItem,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Saved"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (value) => {
          setState(() {
            _currentSelectedItem = value;
          }),
        },
      ),
    );
  }
}
