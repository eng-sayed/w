import 'package:easy_localization/easy_localization.dart';

class OnboardingContents {
  final String title;
  final String image;

  OnboardingContents({
    required this.title,
    required this.image,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: 'onboard1',
    image: 'assets/images/onboard1.gif',
  ),
  OnboardingContents(
    title: 'onboard2',
    image: "assets/images/onboard2.gif",
  ),
  OnboardingContents(title: 'onboard3', image: 'assets/images/onboard3.gif'),
];
