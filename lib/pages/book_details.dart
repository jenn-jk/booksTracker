import 'package:books_tracker/database/database_helper.dart';
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
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    onPressed: () async {
                      try {
                        int bookNum = await DatabaseHelper.instance.insert(
                          book,
                        );
                        SnackBar snackBar = SnackBar(
                          content: Text("Book Saved $bookNum"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } catch (e, stackTrace) {
                        print("Error: $e");
                        print("Staketrace: $stackTrace");
                      }
                    },
                    label: Text("Save"),
                  ),
                  ElevatedButton.icon(
                    icon: Icon(Icons.favorite),
                    onPressed: () async {
                      await DatabaseHelper.instance.readAll().then(
                        (books) => {
                          for (var book in books)
                            {print("Title: ${book.title}")},
                        },
                      );
                    },
                    label: Text("Favorite"),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text("Description", style: theme.titleMedium),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                child: Text(book.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
