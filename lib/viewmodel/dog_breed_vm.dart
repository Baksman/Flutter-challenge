import 'package:flutter_challenge/di.dart';
import 'package:flutter_challenge/model/dog_breed.dart';
import 'package:flutter_challenge/model/random_dog_breed.dart';
import 'package:flutter_challenge/repository/dog_breed_repository.dart';
import 'package:flutter_challenge/ui/widgets/toast.dart';
import 'package:flutter_challenge/viewmodel/base_viewmodel.dart';

class DogBreedVm extends BaseViewModel {
  final dogbreedRepo = getIt.get<DogBreedRepo>();

  DogBreedData? allDogBreed;
  DogSubBreed? dogSubBreed;
  Future<void> getAllDogBreeds() async {
    // Proxy design pattern
    setState(viewState: ViewState.busy);
    final result = await dogbreedRepo.getAllBreeds();
    if (result.hasError) {
      ToastUtils.showToast(result.error.toString());
      setState(
          viewState: ViewState.error, viewMessage: result.error.toString());
    } else {
      allDogBreed = result.data!;
      setState(viewState: ViewState.done);
    }
  }

  DogBreed? selectedBreed;
  void selectDogBreed(DogBreed breed) {
    dogSubBreed = null;
    selectedSubBreed = null;
    selectedBreed = breed;
    dogSubBreed = allDogBreed!.message!.subBreed[selectedBreed!];
    setState();
  }

  String? selectedSubBreed;
  void selectDogSubBreed(subbreed) {
    selectedSubBreed = subbreed;
    setState();
  }

  RandomDogBreed? randomDogBreed;
  Future<void> getRandomBreedImages() async {
    randomDogBreed = null;
    if (selectedBreed == null) {
      ToastUtils.showToast("Kindly select image breed");
      return;
    }

    setState(viewState: ViewState.busy);
    final res = await dogbreedRepo.getRandomBreedImages(selectedBreed!.name);

    if (res.hasError) {
      ToastUtils.showToast(res.error.toString());
      setState(viewState: ViewState.error);
    } else {
      randomDogBreed = res.data!;
      setState(viewState: ViewState.done);
    }
  }
}
