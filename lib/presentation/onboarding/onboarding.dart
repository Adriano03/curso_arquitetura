import 'package:curso_arquitetura/presentation/onboarding/widgets/on_boarding_page.dart';
import 'package:curso_arquitetura/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:curso_arquitetura/presentation/resources/assets_manager.dart';
import 'package:curso_arquitetura/presentation/resources/color_manager.dart';
import 'package:curso_arquitetura/presentation/resources/strings_manager.dart';
import 'package:curso_arquitetura/presentation/resources/values_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final List<SliderObject> _list = _getSliderData();

  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  List<SliderObject> _getSliderData() => [
        SliderObject(
          title: AppStrings.onBoardingTitle1,
          subTitle: AppStrings.onBoardingSubTitle1,
          image: ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle2,
          subTitle: AppStrings.onBoardingSubTitle2,
          image: ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle3,
          subTitle: AppStrings.onBoardingSubTitle3,
          image: ImageAssets.onBoardingLogo3,
        ),
        SliderObject(
          title: AppStrings.onBoardingTitle4,
          subTitle: AppStrings.onBoardingSubTitle4,
          image: ImageAssets.onBoardingLogo4,
        ),
      ];

  Widget _getBottomSheetWidget() {
    return Expanded(
      child: Container(
        color: ColorManager.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (_currentIndex != 0) {
                  _pageControllerFunction(_currentIndex--);
                }
              },
              icon: _currentIndex == 0 ? const SizedBox() : SvgPicture.asset(ImageAssets.leftArrow),
            ),
            Row(
              children: [
                for (int i = 0; i < _list.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: _getProperCircle(i),
                  )
              ],
            ),
            IconButton(
              onPressed: () {
                if (_currentIndex != 3) {
                  _pageControllerFunction(_currentIndex++);
                }
              },
              icon: _currentIndex == 3 ? const SizedBox() : SvgPicture.asset(ImageAssets.rightArrow),
            ),
          ],
        ),
      ),
    );
  }

  void _pageControllerFunction(int calcIndex) {
    calcIndex; //Recebe valor com soma ou subtração;

    _pageController.animateToPage(
      _currentIndex,
      duration: const Duration(milliseconds: DurationConstant.m400),
      curve: Curves.easeInOut,
    );
  }

  Widget _getProperCircle(int index) {
    if (index == _currentIndex) {
      return SvgPicture.asset(ImageAssets.solidCircle);
    } else {
      return SvgPicture.asset(ImageAssets.hollowCircle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _list.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return OnBoardingPage(
            sliderObject: _list[index],
          );
        },
      ),
      bottomSheet: BottomSheet(
        enableDrag: false,
        onClosing: () {},
        builder: (context) {
          return Container(
              color: ColorManager.white,
              height: AppSize.s100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.loginRoute);
                      },
                      child: Text(
                        AppStrings.skip,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                  // Meu modo
                  _getBottomSheetWidget(),

                  // Modo do Professor
                  // _getBottomSheetWidget2(),
                ],
              ));
        },
      ),
    );
  }

// Metódos do Professor para exibir bottomSheet;

// Widget _getBottomSheetWidget2() {
//   return Expanded(
//     child: Container(
//       color: ColorManager.primary,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(AppPadding.p14),
//             child: GestureDetector(
//               child: SizedBox(
//                 height: AppSize.s20,
//                 width: AppSize.s20,
//                 child: SvgPicture.asset(ImageAssets.leftArrow),
//               ),
//               onTap: () {
//                 _pageController.animateToPage(
//                   _getPreviousIndex(),
//                   duration:
//                       const Duration(milliseconds: DurationConstant.m400),
//                   curve: Curves.easeInOut,
//                 );
//               },
//             ),
//           ),
//           Row(
//             children: [
//               for (int i = 0; i < _list.length; i++)
//                 Padding(
//                   padding: const EdgeInsets.all(AppPadding.p8),
//                   child: _getProperCircle(i),
//                 ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(AppPadding.p14),
//             child: GestureDetector(
//               child: SizedBox(
//                 height: AppSize.s20,
//                 width: AppSize.s20,
//                 child: SvgPicture.asset(ImageAssets.rightArrow),
//               ),
//               onTap: () {
//                 _pageController.animateToPage(
//                   _getNextIndex(),
//                   duration:
//                       const Duration(milliseconds: DurationConstant.m400),
//                   curve: Curves.easeInOut,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// int _getPreviousIndex() {
//   int previousIndex = _currentIndex--;
//   if (previousIndex == 0) {
//     _currentIndex = _list.length - 1;
//   }
//   return _currentIndex;
// }

// int _getNextIndex() {
//   int nextIndex = _currentIndex++;
//   if (nextIndex == 3) {
//     _currentIndex = 0;
//   }
//   return _currentIndex;
// }
}

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject({
    required this.title,
    required this.subTitle,
    required this.image,
  });
}
