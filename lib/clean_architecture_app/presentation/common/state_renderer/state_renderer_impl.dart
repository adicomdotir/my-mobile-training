import 'package:first_flutter/clean_architecture_app/data/mapper/mapper.dart';
import 'package:first_flutter/clean_architecture_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:first_flutter/clean_architecture_app/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  String getMessage();
  StateRendererType getStateRendererType();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;
  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;
  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction,
                message: getMessage());
          }
        }
      case ErrorState:
        {
          dimissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            showPopUp(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
                stateRendererType: getStateRendererType(),
                retryActionFunction: retryActionFunction,
                message: getMessage());
          }
        }
      case ContentState:
        {
          dimissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
              message: getMessage());
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dimissDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != false;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance?.addPersistentFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {})));
  }
}
