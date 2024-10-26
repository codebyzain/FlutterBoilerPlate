import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/global/global_bloc.dart';
import 'package:flutter_application_1/utils/util_http_request.dart';
import 'package:flutter_application_1/utils/util_logger.dart';
import 'package:flutter_application_1/utils/util_modal.dart';
import 'package:flutter_application_1/views/shared/button/widget_button.dart';
import 'package:flutter_application_1/views/shared/text/widget_text.dart';
import 'package:flutter_application_1/views/shared/text/widget_text_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ViewHome extends StatelessWidget {
  const ViewHome({Key? key}) : super(key: key);

  Future _getData() async {
    AppNetworkResponse data = await AppNetworkRequest.get("/api/user");
    return data.body;
  }

  login(context) async {
    // throw Exception('Another simulated error');
    // assert(EditableText.debugDeterministicCursor, "wdwd");
    AppLogger.log("Here are the log");
    await AppNetworkRequest.post("/apdwqdqi/qwdqwd/loginWithPassword",
        data: {
          "username": "123",
          "password": "222",
        },
        onLoad: (isLoading) => print("loading $isLoading"));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ListItem(
              //   "Change My Password",
              //   onPress: () => AppModal(context).open(
              //     child: ListItem(
              //       "Change My Password",
              //       onPress: () => AppModal(context)
              //           .open(child: const ListItem("Change My Password")),
              //       marginHorizontal: 25,
              //       description:
              //           "Apply your new theme, use the Theme.of(context) method when specifying a widget's styling properties. These can include, but are not limited to, style and color.",
              //     ),
              //   ),
              //   marginHorizontal: 25,
              //   description:
              //       "Google Fonts makes it easy to bring personality and performance to your websites and products. Our robust catalog of open-source fonts and icons makes it easy to integrate expressive type and icons seamlessly — no matter where you are in the world.",
              // ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: TextInput(
                  placeholder: "Type Username",
                  iconName: Icons.edit_calendar_outlined,
                  // mode: TextInputMode.fill,
                  label:
                      "Please type your username before register new account",
                ),
              ),
              Button(
                "Open Debugger",
                marginVertical: 10,
                shape: ButtonShape.round,
                iconName: Icons.opacity,
                marginHorizontal: 20,
                onPress: () {
                  context.read<GlobalBloc>().add(const EventShowDebugger(true));
                },
              ),
              Button(
                "Change Theme",
                marginVertical: 10,
                shape: ButtonShape.smoothEdge,
                iconName: Icons.dark_mode,
                width: 250,
                onPress: () {
                  bool isDarkMode = context.read<GlobalBloc>().state.isDarkMode;
                  context.read<GlobalBloc>().add(EventSetDarkMode(!isDarkMode));
                },
              ),
              Button(
                "Change Page",
                marginVertical: 10,
                shape: ButtonShape.smoothEdge,
                iconName: Icons.arrow_right_alt,
                width: 250,
                onPress: () {
                  context.go("/auth");
                },
              ),
              Button(
                "Open SnackBar",
                marginVertical: 10,
                shape: ButtonShape.smoothEdge,
                iconName: Icons.message_sharp,
                width: 250,
                onPress: () {
                  AppModal(context).openSnackBar(
                    "Your account has been saved",
                    description:
                        "Unless stated otherwise, the documentation on this site reflects the latest stable version of Flutter.",
                    onPress: () {},
                  );
                },
              ),
              Button(
                "Open Modal",
                marginVertical: 10,
                shape: ButtonShape.smoothEdge,
                iconName: Icons.open_in_browser,
                width: 250,
                onPress: () {
                  AppModal(context).open(
                      child: TextString(
                          "Device binding is attaching an application instance to a particular mobile device. This method detects a transfer of an application instance to another device. A new install of the application (e.g. in case of buying a new device and transfer the apps) is not detected. The deviceID detects, whether the device identifier has been changed. It is triggered after reinstallation of the application if there are no other applications from the same vendor installed. The value can also change when installing test builds using Xcode or when installing an app on a device using ad-hoc distribution. Below are code snippets demonstrating device binding detection across various platforms Device binding is attaching an application instance to a particular mobile device. This method detects a transfer of an application instance to another device. A new install of the application (e.g. in case of buying a new device and transfer the apps) is not detected. The deviceID detects, whether the device identifier has been changed. It is triggered after reinstallation of the application if there are no other applications from the same vendor installed. The value can also change when installing test builds using Xcode or when installing an app on a device using ad-hoc distribution. Below are code snippets demonstrating device binding detection across various platforms Device binding is attaching an application instance to a particular mobile device. This method detects a transfer of an application instance to another device. A new install of the application (e.g. in case of buying a new device and transfer the apps) is not detected. The deviceID detects, whether the device identifier has been changed. It is triggered after reinstallation of the application if there are no other applications from the same vendor installed. The value can also change when installing test builds using Xcode or when installing an app on a device using ad-hoc distribution. Below are code snippets demonstrating device binding detection across various platforms Device binding is attaching an application instance to a particular mobile device. This method detects a transfer of an application instance to another device. A new install of the application (e.g. in case of buying a new device and transfer the apps) is not detected. The deviceID detects, whether the device identifier has been changed. It is triggered after reinstallation of the application if there are no other applications from the same vendor installed. The value can also change when installing test builds using Xcode or when installing an app on a device using ad-hoc distribution. Below are code snippets demonstrating device binding detection across various platforms"));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
