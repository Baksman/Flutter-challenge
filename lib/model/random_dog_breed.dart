import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RandomDogBreed {
  List<DogImage>? message;
  String? status;

  RandomDogBreed({
    this.message,
    this.status,
  });

  RandomDogBreed.fromJson(Map<String, dynamic> json) {
    // message = json['message'].cast<String>();
    message = [];

    if (json['message'] != null) {
      if (json['message'] is List) {
        for (var element in (json['message'] as List<dynamic>)) {
          message!.add(DogImage(imageUrl: element));
        }
      }

      if (json['message'] is String?) {
        message!.clear();
        message!.add(DogImage(imageUrl: json['message'].toString()));
      }
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class DogImage {
  final String imageUrl;
  DogImage({
    required this.imageUrl,
  });

  DogImage copyWith({
    String? imageUrl,
  }) {
    return DogImage(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
    };
  }

  factory DogImage.fromMap(Map<String, dynamic> map) {
    return DogImage(
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DogImage.fromJson(String source) =>
      DogImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DogImage(imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant DogImage other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => imageUrl.hashCode;
}
