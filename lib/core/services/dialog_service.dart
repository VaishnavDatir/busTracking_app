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

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  void registerLoadingDialog(Function showLoadingDialog) {
    _showLoadingDialogListner = showLoadingDialog;
  }

  void dialogDismissListener(Function dialogDismissListener) {
    _dialogDismissListener = dialogDismissListener;
  }

  showLoadingDialog() {
    _showLoadingDialogListner();
  }

  dialogDismiss() {
    _dialogDismissListener();
  }

  Future<AlertResponse> showDialog(
      {String title,
      String description = "",
      String buttonTitle = 'OK',
      String buttonNegativeTitle = 'Cancel'}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(
      AlertRequest(
        title: title,
        description: description,
        buttonTitle: buttonTitle,
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
