import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../theme/colors.dart';
import '../../theme/dimensions.dart';
import '../../theme/themes.dart';

/// The type of dialog to show
enum DialogType { basic, loading }

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    /*  DialogType.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer), */
    DialogType.loading: (context, sheetRequest, completer) =>
        _LoadingDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
/* 
class _BasicDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _BasicDialog({Key? key, this.request, this.completer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: /* Build your dialog UI here */
    );
  }
} */

class _LoadingDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _LoadingDialog({Key? key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kWhite,
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kRadius / 4),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(kXLSpace),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              Text(
                "Please wait...",
                style: appTheme.primaryTextTheme.bodyText1,
              )
            ]),
      ),
    );
  }
}
