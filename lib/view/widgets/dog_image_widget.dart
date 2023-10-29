import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/di.dart';
import 'package:flutter_challenge/viewmodel/base_viewmodel.dart';
import 'package:flutter_challenge/viewmodel/dog_breed_vm.dart';

class DogBreedImageHolder extends StatelessWidget {
  DogBreedImageHolder({super.key});
  final dogBreedVm = getIt.get<DogBreedVm>();
  @override
  Widget build(BuildContext context) {
    if (dogBreedVm.randomDogBreed == null) {
      if (dogBreedVm.viewState == ViewState.busy) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      return const Offstage(
        key: Key('offstage-widget'),
      );
    }
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
        itemCount: dogBreedVm.randomDogBreed?.message?.length ?? 0,
        itemBuilder: (ctx, index) {
          return Container(
            height: 200,
            key: const Key("image-widget"),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        dogBreedVm.randomDogBreed!.message![index].imageUrl)),
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue),
          );
        });
  }
}
