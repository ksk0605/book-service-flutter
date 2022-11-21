import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'book.dart';

class BookService extends ChangeNotifier {
  // 책 목록
  List<Book> bookList = [];

  void getBookList(String bookName) async {
    // 기존 데이터 지우기
    bookList.clear();

    // API로 데이터 불러오기
    Response response = await Dio().get(
        "https://www.googleapis.com/books/v1/volumes?q=$bookName&startIndex=0&maxResults=40");

    List items = response.data['items'];

    for (var i = 0; i < items.length; i++) {
      // 책 목록에 책 데이터 넣어주기
      String title = items[i]['volumeInfo']['title'] ?? '';
      String subTitle = items[i]['volumeInfo']['subtitle'] ?? '';
      String thumbnail = items[i]['volumeInfo']['imageLinks']['thumbnail'] ??
          'https://i.ibb.co/2ypYwdr/no-photo.png';
      String previewLink = items[i]['volumeInfo']['previewLink'] ?? '';
      //print(previewLink);
      Book book = Book(
          title: title,
          subTitle: subTitle,
          thumbnail: thumbnail,
          previewLink: previewLink);
      bookList.add(book);
    }
    notifyListeners();
  }
}
