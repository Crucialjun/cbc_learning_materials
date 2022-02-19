import 'package:cbc_learning_materials/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({Key? key}) : super(key: key);

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            children: [
              _page("page_view_image1", "Onboarding Page One",
                  "This is the descriotion for the first onboarding screen, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at fringilla nisl, quis maximus turpis. Sed diam enim, volutpat nec sagittis nec, mollis a magna. Maecenas id eleifend augue, non consequat elit. Nullam ac nisi eu nisl aliquet viverra. Proin accumsan in nibh placerat suscipit."),
              _page("page_view_image2", "Onboarding Page Two",
                  "This is the descriotion for the Second onboarding screen,Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at fringilla nisl, quis maximus turpis. Sed diam enim, volutpat nec sagittis nec, mollis a magna. Maecenas id eleifend augue, non consequat elit. Nullam ac nisi eu nisl aliquet viverra. Proin accumsan in nibh placerat suscipit."),
              _page("page_view_image3", "Onboarding Page Three",
                  "This is the descriotion for the Third onboarding screen, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at fringilla nisl, quis maximus turpis. Sed diam enim, volutpat nec sagittis nec, mollis a magna. Maecenas id eleifend augue, non consequat elit. Nullam ac nisi eu nisl aliquet viverra. Proin accumsan in nibh placerat suscipit."),
              _page("page_view_image4", "Onboarding Page Four",
                  "This is the descriotion for the Fourth onboarding screen, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse at fringilla nisl, quis maximus turpis. Sed diam enim, volutpat nec sagittis nec, mollis a magna. Maecenas id eleifend augue, non consequat elit. Nullam ac nisi eu nisl aliquet viverra. Proin accumsan in nibh placerat suscipit."),
            ],
          ),
        ),
        const SizedBox(height: 4,),
        Container(
          padding: const EdgeInsets.only(bottom: 16),
          child: SmoothPageIndicator(
              onDotClicked: (index) {
                _pageController.jumpToPage(index);
              },
              controller: _pageController,
              effect: const WormEffect(),
              count: 4),
        ),
      ],
    );
  }
}

Widget _page(String assetName, String title, String description) {
  return Center(
      child: Column(children: [
    Expanded(
      flex: 1,
        child: SvgPicture.asset("assets/svg/$assetName.svg")),
    Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
    ),
    const SizedBox(
      height: 8,
    ),
    Text(
      description,
      textAlign: TextAlign.center,
    ),
  ]));
}
