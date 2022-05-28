import 'package:first_flutter/clean_architecture_app/data/network/failure.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/color_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/font_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/strings_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/styles_manager.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

enum StateRendererType {
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE,
  EMPTY_SCREEN_STATE
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  Failure failure;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer(
      {Key? key,
      required this.stateRendererType,
      Failure? failure,
      String? message,
      String? title,
      required this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? '',
        failure = failure ?? DefaultFailure(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopupLoadingStateWidget();
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopupErrorStateWidget();
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn([_getAnimatedImage(), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([_getAnimatedImage(), _getMessage(failure.message), _getRetryButton(AppStrings.retryAgain)]);
      case StateRendererType.CONTENT_SCREEN_STATE:
        return _getContentScreenStateWidget();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getEmptyScreenStateWidget();
      default:
        return Container();
    }
  }

  Widget _getAnimatedImage() {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: ,
    );
  }

  Widget _getMessage(String message) {
    return Text(message, style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),);
  }

  Widget _getRetryButton(String buttonTitle) {
    return ElevatedButton(onPressed: () {}, child: Text(buttonTitle));
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
