import 'package:copy_movie/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) { // Use dialogContext here
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                    style: AppStyles.medium16Grey,
                  ),
                )
              ],
            ),
          );
        });
  }

  static void hideLoading(BuildContext context) {
    // It's crucial that this context is still valid.
    // Consider adding a check if the widget is mounted, though less common for hideLoading
    // If context is already gone, this might fail.
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  static void showMessage(
      {required BuildContext context, // This is the context from the calling screen
        required String message,
        String? title,
        String? posActionName,
        Function? posAction,
        String? negActionName,
        Function? negAction}) {

    // IMPORTANT: Actions should be defined *inside* the builder to capture the dialogContext
    // But since posAction/negAction need the *original* context for navigation,
    // we'll pass the original context to the onPressed.

    showDialog(
        context: context, // The context from the calling screen
        builder: (dialogContext) { // This is the context specific to the AlertDialog itself
          List<Widget> actions = [];

          if (posActionName != null) {
            actions.add(TextButton(
                onPressed: () {
                  // 1. Execute the positive action using the ORIGINAL context
                  // It's vital that 'context' (from the calling widget) is still valid here.
                  posAction?.call();

                  // 2. Dismiss the dialog using its OWN context ('dialogContext')
                  // This ensures the dialog itself is popped, regardless of the original screen's state.
                  if (Navigator.of(dialogContext, rootNavigator: true).canPop()) {
                    Navigator.of(dialogContext, rootNavigator: true).pop();
                  }
                },
                child: Text(
                  posActionName,
                  style: AppStyles.medium16Grey,
                )));
          }
          if (negActionName != null) {
            actions.add(TextButton(
                onPressed: () {
                  negAction?.call();
                  if (Navigator.of(dialogContext, rootNavigator: true).canPop()) {
                    Navigator.of(dialogContext, rootNavigator: true).pop();
                  }
                },
                child: Text(negActionName, style: AppStyles.medium16Grey)));
          }

          return AlertDialog(
            content: Text(
              message,
              style: AppStyles.medium16Grey,
            ),
            title: Text(
              title ?? '',
              style: AppStyles.medium16Grey,
            ),
            actions: actions,
          );
        });
  }
}