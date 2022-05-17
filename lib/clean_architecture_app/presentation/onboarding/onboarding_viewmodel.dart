import 'dart:async';

import 'package:first_flutter/clean_architecture_app/domain/model.dart';
import 'package:first_flutter/clean_architecture_app/presentation/base/baseviewmodel.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/assets_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoradingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0;
    }
    _postDataToView();
  }

  @override
  void goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    _postDataToView();
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputsSliderViewObject
  Stream<SliderViewObject> get outputsSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onboardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onboardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onboardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onboardingLogo4),
      ];

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnBoardingViewModelInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}

abstract class OnBoradingViewModelOutputs {
  Stream<SliderViewObject> get outputsSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
