import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/di.dart';
import 'package:flutter_challenge/model/dog_breed.dart';
import 'package:flutter_challenge/ui/widgets/custom_button.dart';
import 'package:flutter_challenge/viewmodel/base_viewmodel.dart';
import 'package:flutter_challenge/viewmodel/base_vm_builder.dart';
import 'package:flutter_challenge/viewmodel/dog_breed_vm.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewBuilder<DogBreedVm>(
        model: getIt(),
        initState: (dVm) {
          dVm.getAllDogBreeds();
        },
        builder: (dogVm, child) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: dogVm.allDogBreed == null
                ? const Offstage()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        CustomButton(
                          title: "Random image by breed",
                          onTap: () {},
                          color: Colors.red,
                        ),
                        CustomButton(
                          title: "Images list by breed",
                          onTap: () {
                            dogVm.getRandomBreedImages();
                          },
                          color: Colors.teal,
                        ),
                        CustomButton(
                          title: "Random image by breed and sub breed",
                          onTap: () {},
                          color: Colors.orange,
                        ),
                        CustomButton(
                          title: "Images list by breed and sub breed",
                          onTap: () {},
                          color: Colors.black,
                        ),
                      ]),
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: const Text(
                "Dog App",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: dogVm.allDogBreed == null
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          // height: 60,
                          color: Colors.white,
                          child: DropdownButtonFormField<DogBreed>(
                              isExpanded: true,
                              items: dogVm.allDogBreed!.message!.breed
                                  .map((DogBreed value) {
                                return DropdownMenuItem<DogBreed>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              hint: const Text("Kindly select dog breed"),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              onChanged: (val) {
                                dogVm.selectDogBreed(val!);
                              }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white,
                          child: DropdownButtonFormField<String>(
                              value: dogVm.selectedSubBreed,
                              hint: (dogVm.dogSubBreed?.subBreeds.isEmpty ??
                                      true)
                                  ? const Text("This dog has no sub breed")
                                  : const Text("Kindly select dog sub-breed"),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              items: dogVm.dogSubBreed?.subBreeds.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value ?? ""),
                                );
                              }).toList(),
                              onChanged: dogVm.selectDogSubBreed),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DogBreedImageHolder(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )),
          );
        });
  }
}

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
      return const Center(
        child: Offstage(),
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
