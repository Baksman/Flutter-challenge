import 'package:flutter/material.dart';
import 'package:flutter_challenge/di.dart';
import 'package:flutter_challenge/viewmodel/dog_breed_vm.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final String title;

  CustomButton(
      {super.key,
      required this.color,
      required this.onTap,
      required this.title});
  final dogVm = getIt.get<DogBreedVm>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: color,
            // color: dogVm.isBusy ? color.withOpacity(.5) : color,
            borderRadius: BorderRadius.circular(5)),
        width: 80,
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
