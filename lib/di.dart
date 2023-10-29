import 'package:flutter_challenge/repository/dog_breed_repository.dart';
import 'package:flutter_challenge/viewmodel/dog_breed_vm.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void registerSl() {
    getIt.registerSingleton<DogBreedRepo>(DogBreedRepo());
    getIt.registerSingleton<DogBreedVm>(DogBreedVm());
  }
}
