import 'package:flutter/material.dart';
import 'package:flutter_application_1/states/global/global_bloc.dart';
import 'package:flutter_application_1/utils/util_http_request.dart';
import 'package:flutter_application_1/utils/util_logger.dart';
import 'package:flutter_application_1/utils/util_modal.dart';
import 'package:flutter_application_1/views/shared/button/widget_button.dart';
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
    AppLogger.log("Here are the log");
    await AppNetworkRequest.post("/",
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
                  AppModal(context).open();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
