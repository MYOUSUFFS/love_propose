import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:love_propose/create_link.dart';
import 'package:love_propose/love_u.dart';

class AppRoots {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(
          child: CreateLink(),
        ),
      ),
      GoRoute(
        name: 'message',
        path: '/message',
        builder: (context, state) => LoveU(
          title: state.uri.queryParameters['title'],
          message: state.uri.queryParameters['message'],
          sno: state.uri.queryParameters['sno'],
          image: int.parse(state.uri.queryParameters['option'] ?? "0"),
        ),
      ),
      GoRoute(
        name: 'go',
        path: '/go',
        builder: (context, state) {
          print(state.uri.queryParameters["data"]);
          return passData(state.uri.queryParameters["data"]);
        },
      ),
    ],
  );
}
