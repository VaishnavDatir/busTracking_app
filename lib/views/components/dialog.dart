import 'package:flutter/material.dart';

import '../../core/locator.dart';
import '../../core/models/dialog_model.dart';
import '../../core/services/dialog_service.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  DialogManager({Key key, this.child}) : super(key: key);

  _DialogManagerState createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListenerFun(_showDialog);
    _dialogService.registerLoadingDialogFun(_showLoadingDialog);
    _dialogService.dialogDismissListenerFun(_dismissDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _dismissDialog() {
    Navigator.of(context).pop();
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: kWhite,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kRadius / 4),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(kXXLSpace),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Please wait...")
                ]),
          ),
        );
      },
    );
  }

  void _showDialog(AlertRequest request) {
    showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kWhite,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kRadius / 4),
            ),
          ),
          title: request.title.isEmpty
              ? null
              : Text(
                  request.title,
                  style: appTheme.primaryTextTheme.headline3,
                ),
          content: Text(
            request.description != null ? request.description : "",
            style: appTheme.textTheme.bodyText2.copyWith(
              color: kTextLightGrey,
            ),
            textAlign: TextAlign.left,
          ),
          actions: <Widget>[
            request.showNegativeButton
                ? TextButton(
                    child: Text(
                      request.buttonNegativeTitle,
                      style: appTheme.textTheme.bodyText1
                          .copyWith(color: kTextLightGrey),
                    ),
                    onPressed: () {
                      _dialogService
                          .dialogComplete(AlertResponse(confirmed: false));
                      Navigator.of(context).pop();
                    },
                  )
                : Container(),
            TextButton(
              child: Text(
                request.buttonTitle,
                style:
                    appTheme.textTheme.subtitle2.copyWith(color: kPrimaryColor),
              ),
              onPressed: () {
                _dialogService.dialogComplete(AlertResponse(confirmed: true));
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
