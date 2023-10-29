import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_challenge/di.dart';
import 'package:flutter_challenge/main.dart';
import 'package:flutter_challenge/view/widgets/custom_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized(); // NEW

  ServiceLocator.registerSl();
  testWidgets('Confirm app title and appbar on the dashaboard ',
      (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text("Dog App"), findsOneWidget);
    expect(find.byKey(const Key("app-bar")), findsOneWidget);
  });

  testWidgets('Confirm the buttons to get the apis shows after fetching  ',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    final randomImageButtonTitle = find.text("Random image by breed");
    await pumpUntilFound(tester, randomImageButtonTitle);
    expect(randomImageButtonTitle, findsOneWidget);

    final imageListButtonTitle = find.text("Images list by breed");
    await pumpUntilFound(tester, imageListButtonTitle);
    expect(imageListButtonTitle, findsOneWidget);

    final randomImageBreedBtnTitle =
        find.text("Random image by breed and sub breed");
    await pumpUntilFound(tester, randomImageBreedBtnTitle);
    expect(randomImageBreedBtnTitle, findsOneWidget);

    final randomImageBreedSubbreedBtnTitle =
        find.text("Images list by breed and sub breed");
    await pumpUntilFound(tester, randomImageBreedSubbreedBtnTitle);
    expect(randomImageBreedSubbreedBtnTitle, findsOneWidget);

    // i.e no image is displayed yet unless its btn is tapped
  });

  testWidgets(
      'Confirm no image is displayed before dropdown is displayed and image displayed after',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    final offStage = find.byKey(const Key('offstage-widget'));
    await pumpUntilFound(tester, offStage);
    expect(offStage, findsOneWidget);

    // find dropdown
    final dropdown = find.byKey(const Key('breed-dropdown'));
    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    //  and click on dropdown
    final dropdownItem = find.byType(Text).last;

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    // click on  first to fetch dog image
    final randomBreedBtn = find.byType(CustomButton).first;
    await tester.tap(randomBreedBtn);

    // expect to find image
    final imageWidget = find.byKey(const Key("image-widget"));
    await pumpUntilFound(tester, imageWidget);
    expect(imageWidget, findsOneWidget);
  });
}

// make API call to complete
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  bool timerDone = false;
  final timer = Timer(timeout, () => timerDone = true);
  while (timerDone != true) {
    await tester.pump();

    final found = tester.any(finder);
    if (found) {
      timerDone = true;
    }
  }
  timer.cancel();
}
