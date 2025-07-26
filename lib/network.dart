import 'package:books_tracker/models/book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  static final String _baseURL = "https://www.googleapis.com/books/v1/volumes";

  // Future<List<Book>> getBooks(String query) async {
  //   var url = Uri.parse("$_baseURL?q=$query");
  //   var response = await http.get(url);
  // }

  Future<List<Book>> getBooks(String query) async {
    var url = Uri.parse("$_baseURL?q=$query");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var booksData = data["items"];

      if (booksData != null && booksData is List<dynamic>) {
        List<Book> books = booksData
            .map((book) => Book.fromJson(book as Map<String, dynamic>))
            .toList();
        return books;
      } else {
        return [];
      }
    } else {
      throw Exception("Some error occured while loading the books!");
    }
  }
}
