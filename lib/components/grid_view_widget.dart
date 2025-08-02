import 'package:books_tracker/models/book.dart';
import 'package:books_tracker/utils/book_details_arguments.dart';
import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required List<Book> books,
  }) : _books = books;

  final List<Book> _books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: _books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          Book book = _books[index];
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/bookdetails",
                  arguments: BookDetailsArguments(itemBook: book),
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.network(
                      book.imageLinks["thumbnail"]?.replaceFirst(
                            "http://",
                            "https://",
                          ) ??
                          "",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      book.title,
                      style: Theme.of(context).textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      book.authors.join(", "),
                      style: Theme.of(context).textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
