import 'dart:io';
import 'package:flutter_challenge/model/dog_breed.dart';
import 'package:flutter_challenge/repository/base_repository.dart';
import 'package:flutter_challenge/repository/dog_breed_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'response/json_reader.dart';
import 'widget_test.mocks.dart';

const allbreedUrl = "https://dog.ceo/api/breeds/list/all";
// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  MockClient? client;
  late final DogBreedRepo dogbreedRepo;
  late final BaseDatasource baseDatasource;
  final Map<String, String> jsonHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  setUpAll(() {
    client = MockClient();
    dogbreedRepo = DogBreedRepo(client: client!);
    baseDatasource = BaseDatasource(client: client!);
  });

  Future<void> setUpMockHttpClientSuccess200(String url, String name) async {
    when(client!.get(Uri.parse(url), headers: jsonHeaders)).thenAnswer(
      (_) async => http.Response(breed('$name.json'), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      }),
    );
  }

  group('getAllBreeds from DogBreedRepo', () {
    test('should verify get method whats called with correct url ', () async {
      // arrange
      await setUpMockHttpClientSuccess200(allbreedUrl, "all_breed");

      // act
      await baseDatasource.sendGet(endpoint: '/breeds/list/all');
      await dogbreedRepo.getAllBreeds();
      // assert
      verify(
        client!.get(
          Uri.parse(allbreedUrl),
          headers: jsonHeaders,
        ),
      );
    });

    test(
      'should return news when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200(allbreedUrl, "all_breed");
        // act
        await baseDatasource.sendGet(
          endpoint: '/breeds/list/all',
        );
        final result = await dogbreedRepo.getAllBreeds();

        DogBreedData news = result.data!;
        // assert
        expect(news, isA<DogBreedData>());
      },
    );
  });
}
