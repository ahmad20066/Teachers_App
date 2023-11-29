import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teachers_app/features/auth/register/screens/permission_screen.dart';
import 'package:teachers_app/features/auth/register/screens/register_screen.dart';
import 'package:teachers_app/features/auth/register/widgets/avatar.dart';
import 'package:teachers_app/features/main/tabs/tab_screen.dart';
import 'package:teachers_app/router.dart';

import '../../auth/profile/cubit/user_cubit.dart';
import '../../auth/register/screens/role_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).fetchCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoaded) {
            Navigator.pushReplacement(context,
                generateRoute(RouteSettings(name: TabsScreen.routeName)));
          } else if (state is UserExpired) {
            Navigator.pushReplacement(context,
                generateRoute(RouteSettings(name: RoleScreen.routeName)));
          } else if (state is UserError) {
            Navigator.pushReplacement(context,
                generateRoute(RouteSettings(name: RoleScreen.routeName)));
          }
        },
        builder: (context, state) {
          return Center(
            child: Avatar(isTeacher: true),
          );
        },
      ),
    );
  }
}
