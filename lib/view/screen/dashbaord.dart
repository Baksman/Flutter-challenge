import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/di.dart';
import 'package:flutter_challenge/model/dog_breed.dart';
import 'package:flutter_challenge/view/style/color_styles.dart';
import 'package:flutter_challenge/view/widgets/custom_button.dart';
import 'package:flutter_challenge/view/widgets/dog_image_widget.dart';
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
                          onTap: () {
                            dogVm.getBreedRandomImage();
                          },
                          color: AppColor.red,
                        ),
                        CustomButton(
                          title: "Images list by breed",
                          onTap: () {
                            dogVm.getRandomBreedImages();
                          },
                          color: AppColor.teal,
                        ),
                        CustomButton(
                          title: "Random image by breed and sub breed",
                          onTap: () {
                            dogVm.getRandomImageByBreed();
                          },
                          color: AppColor.orange,
                        ),
                        CustomButton(
                          title: "Images list by breed and sub breed",
                          onTap: () {
                            dogVm.getImageListByBreed();
                          },
                          color: AppColor.black,
                        ),
                      ]),
            appBar: AppBar(
              key: const Key("app-bar"),
              backgroundColor: AppColor.teal,
              title: const Text(
                "Dog App",
                style: TextStyle(color: AppColor.white),
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
                          color: AppColor.white,
                          child: DropdownButtonFormField<DogBreed>(
                              key: const Key('breed-dropdown'),
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
                          color: AppColor.white,
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
