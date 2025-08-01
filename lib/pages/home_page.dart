import 'package:books_tracker/components/grid_view_widget.dart';
import 'package:books_tracker/models/book.dart';
import 'package:books_tracker/network.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> _books = [];
  Network network = Network();

  void _searchBooks(String query) async {
    try {
      List<Book> books = await network.getBooks(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      print(e);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Book Title",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onSubmitted: (query) => _searchBooks(query),
              ),
            ),
            GridViewWidget(books: _books),
          ],
        ),
      ),
    );
  }
}

