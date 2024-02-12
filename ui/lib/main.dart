import 'package:authentication_repository/authentication_repository.dart';
import 'package:beamer/beamer.dart';
import 'package:design/design.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamebase_ui/bloc/authentication/authentication_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_repository/user_repository.dart';

import 'beamer_locations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(
    MyApp(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.authenticationRepository,
    required this.userRepository,
  });

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: const _AppView(),
      ),
    );
  }
}

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  final routerDelegate = BeamerDelegate(
    guards: [
      // Guard /logged_in_page by beaming to /login if the user is unauthenticated:
      BeamGuard(
        pathPatterns: [
          "/collections",
          "/logs",
          "/settings",
        ],
        check: (context, state) =>
            context.read<AuthenticationBloc>().isAuthenticated(),
        beamToNamed: (origin, target) => "/login",
      ),
      BeamGuard(
        pathPatterns: ["/login"],
        check: (context, state) =>
            context.read<AuthenticationBloc>().isAuthenticated() == false,
        beamToNamed: (origin, target) => "/collections",
      ),
    ],
    initialPath: "/collections",
    transitionDelegate: const NoAnimationTransitionDelegate(),
    locationBuilder: (routeInformation, _) => BeamerLocations(routeInformation),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        routerDelegate.update();
      },
      child: MaterialApp.router(
        title: 'gamebase.io',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: MyColors.primary,
            background: Colors.white,
          ),
          useMaterial3: true,
        ),
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
      ),
    );
  }
}
