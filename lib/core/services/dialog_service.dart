import 'dart:async';

import 'package:flutter/material.dart';

import '../models/dialog_model.dart';

class DialogService {
  GlobalKey<NavigatorState> _dialogNavigationKey = GlobalKey<NavigatorState>();
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;
  Function _showLoadingDialogListner;
  Function _dialogDismissListener;
  GlobalKey<NavigatorState> get dialogNavigationKey => _dialogNavigationKey;

  void registerDialogListenerFun(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  void registerLoadingDialogFun(Function showLoadingDialog) {
    _showLoadingDialogListner = showLoadingDialog;
  }

  void dialogDismissListenerFun(Function dialogDismissListener) {
    _dialogDismissListener = dialogDismissListener;
  }

  showLoadingDialog() {
    _showLoadingDialogListner();
  }

  dialogDismiss() {
    _dialogDismissListener();
  }

  Future<AlertResponse> showDialog(
      {String title = "",
      String description = "",
      String buttonTitle = 'OK',
      bool showNegativeButton = false,
      String buttonNegativeTitle = 'Cancel'}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(
      AlertRequest(
        title: title,
        description: description,
        buttonTitle: buttonTitle,
        showNegativeButton: showNegativeButton,
        buttonNegativeTitle: buttonNegativeTitle,
      ),
    );
    return _dialogCompleter.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}
