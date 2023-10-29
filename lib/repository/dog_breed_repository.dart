import 'package:flutter_challenge/model/dog_breed.dart';
import 'package:flutter_challenge/model/random_dog_breed.dart';
import 'package:flutter_challenge/repository/api_response.dart';
import 'package:flutter_challenge/repository/base_repository.dart';
// https://dog.ceo/api/breeds/image/random
class DogBreedRepo extends BaseDatasource {
  Future<ApiResponse<RandomDogBreed>> getRandomBreedImages(String breed) async {
    final res = await sendGet(endpoint: "/breed/$breed/images");
    return res.transform((data) => RandomDogBreed.fromJson(data!));
  }

  Future<ApiResponse<DogBreedData>> getAllBreeds() async {
    final res = await sendGet(endpoint: "/breeds/list/all");
    return res.transform((data) => DogBreedData.fromJson(data!));
  }

  Future<ApiResponse<RandomDogBreed>> getRandomDomDogBreedImageList(
      String breed) async {
    final res = await sendGet(endpoint: "/breeds/$breed/images/random");
    return res.transform((data) => RandomDogBreed.fromJson(data!));
  }

  Future<ApiResponse<RandomDogBreed>> getImageByBreed(String breed) async {
    final res = await sendGet(endpoint: "/breeds/$breed/images/random");
    return res.transform((data) => RandomDogBreed.fromJson(data!));
  }
}
