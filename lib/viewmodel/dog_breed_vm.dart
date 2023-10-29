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
    if (selectedBreed == null) {
      ToastUtils.showToast("Kindly select image breed");
      return;
    }
    randomDogBreed = null;

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

  Future<void> getBreedRandomImage() async {
    randomDogBreed = null;
    setState(viewState: ViewState.busy);
    final res = await dogbreedRepo.getBreedRandomImage();

    if (res.hasError) {
      ToastUtils.showToast(res.error.toString());
      setState(viewState: ViewState.error);
    } else {
      randomDogBreed = res.data!;
      setState(viewState: ViewState.done);
    }
  }

  // getBreedRandomImage

  Future<void> getRandomImageByBreed() async {
    if (selectedBreed == null) {
      ToastUtils.showToast("Kindly select image breed");
      return;
    }
    randomDogBreed = null;
    setState(viewState: ViewState.busy);
    final res = await dogbreedRepo.getRandomImageByBreed(selectedBreed!.name);

    if (res.hasError) {
      ToastUtils.showToast(res.error.toString());
      setState(viewState: ViewState.error);
    } else {
      randomDogBreed = res.data!;
      setState(viewState: ViewState.done);
    }
  }

  Future<void> getImageListByBreed() async {
    if (selectedBreed == null) {
      ToastUtils.showToast("Kindly select image breed");
      return;
    }

    if (selectedSubBreed == null &&
        (dogSubBreed?.subBreeds.isNotEmpty ?? true)) {
      ToastUtils.showToast("Kindly select dog subbreed");
      return;
    }

    ToastUtils.showToast(
        "Theres no endpoint for subbreed images according to the doc whats avaialable is and endpoint for for subbreed names which is already gotten from https://dog.ceo/api/breeds/list/all and cached");
  }
}
