// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class DogBreedData {
  Message? message;

  DogBreedData({this.message});

  DogBreedData.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (message != null) {
      data['message'] = message!.toJson();
    }
    return data;
  }
}

class Message {
  List<DogBreed> breed = [];
  Map<DogBreed, DogSubBreed> subBreed = {};

  Message.fromJson(Map<String, dynamic> json) {
    (json).forEach((key, value) {
      breed.add(DogBreed(name: key));
      subBreed[DogBreed(name: key)] = DogSubBreed(subBreeds: value);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['breed'] = breed;
    return data;
  }
}

class DogBreed {
  final String name;

  DogBreed({required this.name});

  @override
  bool operator ==(covariant DogBreed other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class DogSubBreed {
  final List<dynamic> subBreeds;

  DogSubBreed({required this.subBreeds});

  @override
  bool operator ==(covariant DogSubBreed other) {
    if (identical(this, other)) return true;

    return listEquals(other.subBreeds, subBreeds);
  }

  @override
  int get hashCode => subBreeds.hashCode;
}
