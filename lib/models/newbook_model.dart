class NewBookModel {

  NewBookModel(this.image);
  String image;
}

List<NewBookModel> newbooks =
    newBookData.map((item) => NewBookModel(item['image']!)).toList();

List<Map<String, String>> newBookData = [
  {'image': 'assets/images/img_newbook1.png'},
  {'image': 'assets/images/img_newbook2.png'},
  {'image': 'assets/images/img_newbook1.png'},
  {'image': 'assets/images/img_newbook2.png'},
  {'image': 'assets/images/img_newbook1.png'},
  {'image': 'assets/images/img_newbook2.png'},
  {'image': 'assets/images/img_newbook1.png'},
  {'image': 'assets/images/img_newbook2.png'},
];
