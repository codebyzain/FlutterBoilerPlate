import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/config_main.dart';
import 'package:flutter_application_1/states/global/global_bloc.dart';
import 'package:flutter_application_1/views/shared/app_debugger/widgets/widget_error_item.dart';
import 'package:flutter_application_1/views/shared/app_debugger/widgets/widget_network_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NetworkRequestList extends StatelessWidget {
  const NetworkRequestList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Map>(MainConfig.appName).listenable(),
      builder: (context, box, widget) {
        final networkResponse = box.get("network-debugger");
        return ListView.builder(
          clipBehavior: Clip.antiAlias,
          itemCount: networkResponse?["data"].length ?? 0,
          itemBuilder: (context, index) {
            return AppDebuggerNetworkItem(
              data: networkResponse?["data"][index],
              index: index,
            );
          },
        );
      },
    );
  }
}

class ErrorList extends StatelessWidget {
  const ErrorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Map>(MainConfig.appName).listenable(),
      builder: (context, box, widget) {
        final errorData = box.get("error-debugger");
        return ListView.builder(
          clipBehavior: Clip.antiAlias,
          itemCount: errorData?["data"].length ?? 0,
          itemBuilder: (context, index) {
            return AppDebuggerErrorItem(
              data: errorData?["data"][index],
              index: index,
            );
          },
        );
      },
    );
  }
}

class InAppDebuggerSharedWidget extends StatelessWidget {
  const InAppDebuggerSharedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Container(
            height: state.isShowDebugger
                ? MediaQuery.of(context).size.height / 2
                : 0,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
              children: [
                SwipeDetector(
                  onSwipeDown: (offset) {
                    context
                        .read<GlobalBloc>()
                        .add(const EventShowDebugger(false));
                  },
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: TabBar(
                      dividerColor: Colors.white54.withOpacity(0.2),
                      tabs: [
                        Tab(
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.public,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "HTTP Requests",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.bug_report,
                              size: 20,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Captured Errors",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        // Tab(
                        //   child: TextButton.icon(
                        //     onPressed: () {},
                        //     icon: const Icon(
                        //       Icons.data_object,
                        //       size: 20,
                        //       color: Colors.white,
                        //     ),
                        //     label: const Text(
                        //       "Sessions",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 12,
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      const NetworkRequestList(),
                      const ErrorList(),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().slideY(
                begin: -MediaQuery.of(context).size.height / 2,
                end: 0,
              ),
        );
      },
    );
  }
}
