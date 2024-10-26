import 'package:flutter_application_1/views/features/auth/view_auth.dart';
import 'package:flutter_application_1/views/features/home/view_home.dart';
import 'package:go_router/go_router.dart';

final mainRouters = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ViewHome(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const ViewAuth(),
    ),
  ],
);
