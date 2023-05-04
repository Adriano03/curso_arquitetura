import 'package:curso_arquitetura/presentation/onboarding/on_boarding_view_model.dart';
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
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  void _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    int currentIndex = sliderViewObject.currentIndex;
    return Expanded(
      child: Container(
        color: ColorManager.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                if (currentIndex != 0) {
                  _pageControllerFunction(--currentIndex);
                }
              },
              icon: currentIndex == 0
                  ? const SizedBox()
                  : SvgPicture.asset(ImageAssets.leftArrow),
            ),
            Row(
              children: [
                for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: _getProperCircle(i, sliderViewObject.currentIndex),
                  )
              ],
            ),
            IconButton(
              onPressed: () {
                if (currentIndex != 3) {
                  _pageControllerFunction(++currentIndex);
                }
              },
              icon: currentIndex == 3
                  ? const SizedBox()
                  : SvgPicture.asset(ImageAssets.rightArrow),
            ),
          ],
        ),
      ),
    );
  }

  void _pageControllerFunction(int currentIndex) {
    _pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: DurationConstant.m400),
      curve: Curves.easeInOut,
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.solidCircle);
    } else {
      return SvgPicture.asset(ImageAssets.hollowCircle);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
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
          itemCount: sliderViewObject.numOfSlides,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(
              sliderObject: sliderViewObject.sliderObject,
            );
          },
        ),
        bottomSheet: Container(
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
              _getBottomSheetWidget(sliderViewObject),

              // Modo do Professor
              // _getBottomSheetWidget2(sliderViewObject),
            ],
          ),
        ),
      );
    }
  }

// Metódos do Professor para exibir bottomSheet;

  Widget _getBottomSheetWidget2(SliderViewObject sliderViewObject) {
    return Expanded(
      child: Container(
        color: ColorManager.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.leftArrow),
                ),
                onTap: () {
                  _pageController.animateToPage(
                    _viewModel.goPrevious(),
                    duration: const Duration(milliseconds: DurationConstant.m400),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            Row(
              children: [
                for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: _getProperCircle(i, sliderViewObject.currentIndex),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p14),
              child: GestureDetector(
                child: SizedBox(
                  height: AppSize.s20,
                  width: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.rightArrow),
                ),
                onTap: () {
                  _pageController.animateToPage(
                    _viewModel.goNext(),
                    duration: const Duration(milliseconds: DurationConstant.m400),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
