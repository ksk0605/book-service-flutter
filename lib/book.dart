class Book {
  String title;
  String subTitle;
  String thumbnail;
  String previewLink;

  Book(
      {required this.title,
      required this.subTitle,
      required this.thumbnail,
      required this.previewLink});

  Book getBook() {
    return Book(
        title: title,
        subTitle: subTitle,
        thumbnail: thumbnail,
        previewLink: previewLink);
  }

  // factory Book.fromJson(Map<String, dynamic> volumeInfo) {
  //   return Book(
  //     // title이 없는 경우 빈 문자열 할당
  //     title: volumeInfo["title"] ?? "",
  //     // subtitle이 없는 경우 빈 문자열 할당
  //     subTitle: volumeInfo["subtitle"] ?? "",
  //     // imageLisks 또는 thumbnail이 없을 때 빈 이미지 추가
  //     thumbnail: volumeInfo["imageLinks"]?["thumbnail"] ??
  //         "https://i.ibb.co/2ypYwdr/no-photo.png",
  //     // previewLink가 없는 경우 빈 문자열 할당
  //     previewLink: volumeInfo["previewLink"] ?? "",
  //   );
  // }
}
