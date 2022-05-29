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
          break;
        }
      case ErrorState:
        {
          break;
        }
      case ContentState:
        {
          break;
        }
      case EmptyState:
        {
          break;
        }
      default:
        {
          break;
        }
    }
  }
}
