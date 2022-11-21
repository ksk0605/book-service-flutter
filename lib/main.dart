import 'package:book_store/book_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'book.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();

  String bookName = '';
  int bookNum = 0;

  // 검색 버튼 누를 때
  void search(BookService bookService) {
    setState(() {
      bookName = _textController.text;
    });
    print(bookName);

    if (bookName.isNotEmpty) {
      bookService.getBookList(bookName);
    }
    setState(() {
      print(bookService.bookList.length);
      bookNum = bookService.bookList.length;
    });
    //print(bookNum);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(
      builder: (context, bookService, child) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              backgroundColor: Colors.white,
              title: Text(
                'Book Store',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              bottom: PreferredSize(
                  preferredSize: Size(double.infinity, 80),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'total $bookNum',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: '원하시는 책을 검색해주세요.',
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                onPressed: (() {
                                  search(bookService);
                                }),
                              ),
                            ),
                            controller: _textController,
                            onSubmitted: (_) {
                              search(bookService);
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            body: bookName == ''
                ? _emptyBookNameWidget()
                : ListView.builder(
                    itemCount: bookService.bookList.length,
                    itemBuilder: (context, index) {
                      Book book = bookService.bookList[index];
                      return ListTile(
                        leading: Image.network(
                          book.thumbnail,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 100,
                        ),
                        title: Text(
                          book.title,
                          style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(
                          book.subTitle,
                          style: TextStyle(fontSize: 13),
                        ),
                        onTap: () {
                          Uri uri = Uri.parse(book.previewLink);
                          launchUrl(uri);
                        },
                      );
                    },
                  ));
      },
    );
  }

  Center _emptyBookNameWidget() {
    return Center(
      child: Text(
        '검색어를 입력해주세요',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 24,
        ),
      ),
    );
  }
}
