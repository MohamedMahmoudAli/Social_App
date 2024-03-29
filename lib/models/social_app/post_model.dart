class PostModel {
  late String name;
  late String uId;
  late String image;
  late String dateTime;
  late String text;
  late String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['datetime'];
    text = json['text'];
    postImage = json['postimage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'datetime': dateTime,
      'text': text,
      'postimage': postImage,
    };
  }
}
