import 'package:books_tracker/models/book.dart';
import 'package:http/http.dart' as http;

class Network {
  static final String _baseURL = "https://www.googleapis.com/books/v1/volumes";

  // Future<List<Book>> getBooks(String query) async {
  //   var url = Uri.parse("$_baseURL?q=$query");
  //   var response = await http.get(url);
  // }

  Future<void> getBooks(String query) async {
    var url = Uri.parse("$_baseURL?q=$query");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print("Some error occured while loading the books");
    }
  }
}
