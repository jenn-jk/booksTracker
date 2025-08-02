import 'package:books_tracker/models/book.dart';
import 'package:books_tracker/utils/book_details_arguments.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatefulWidget {
  const BookDetails({super.key});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;

    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    return Scaffold(
      appBar: AppBar(title: Text(book.title)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              if (book.imageLinks.isNotEmpty)
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
              Column(
                children: [
                  Text(book.title, style: theme.headlineSmall),
                  Text(book.authors.join(", "), style: theme.labelLarge),
                  Text(
                    "Published: ${book.publishedDate}",
                    style: theme.bodySmall,
                  ),
                  Text("Page Count: ${book.pageCount}", style: theme.bodySmall),
                  Text("Language: ${book.language}", style: theme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
