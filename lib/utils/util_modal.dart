import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/config_main.dart';

class AppModal {
  final BuildContext context;
  final double heightRatio;

  const AppModal(this.context, {this.heightRatio = 0.6});

  // Open modal
  open({Widget? child}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      elevation: 2,
      scrollControlDisabledMaxHeightRatio: heightRatio,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(bottom: 0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
            color: Theme.of(context).colorScheme.background,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                width: 70,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: child,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // open snackbar
  openSnackBar(
    String? message, {
    String? description,
    Function()? onPress,
    String? actionLabel,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$message",
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              height: 1.7,
            ),
          ),
          if (description != null)
            Text(
              description,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.3,
              ),
            )
        ],
      ),
      duration: const Duration(seconds: MainConfig.snackbarDuration),
      action: onPress != null
          ? SnackBarAction(
              label: actionLabel ?? 'Show',
              onPressed: onPress,
            )
          : null,
    ));
  }
}
