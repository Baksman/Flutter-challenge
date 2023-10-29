import 'package:http/http.dart' as http;
import 'package:flutter_challenge/repository/dog_breed_repository.dart';
import 'package:flutter_challenge/viewmodel/dog_breed_vm.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void registerSl() {
    // client is injected via dependency injection so it can be unit tested
    final httpClient = http.Client();
    getIt.registerSingleton<DogBreedRepo>(DogBreedRepo(client: httpClient));

    getIt.registerSingleton<DogBreedVm>(DogBreedVm());
  }
}
