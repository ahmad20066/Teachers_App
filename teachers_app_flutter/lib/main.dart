import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/auth/register/cubit/cubit/registerpagecubit_cubit.dart';
import 'package:teachers_app/features/auth/register/cubit/register_cubit.dart';
import 'package:teachers_app/features/main/search/cubit/search_cubit.dart';
import 'package:teachers_app/features/main/search/cubit/subjects_cubit.dart';
import 'package:teachers_app/features/main/tabs/tab_screen.dart';
import 'package:teachers_app/features/splash/screen/splash_screen.dart';
import 'package:teachers_app/router.dart';

import 'constants/global_variables.dart';
import 'features/auth/forgot_password/cubit/forgot_cubit.dart';
import 'features/auth/login/cubit/login_cubit.dart';
import 'features/auth/profile/cubit/user_cubit.dart';
import 'features/auth/register/screens/register_screen.dart';
import 'features/main/home/cubit/home_cubit.dart';
import 'features/main/schedule/cubit/cubit/schedule_cubit.dart';
import 'features/main/schedule/cubit/request_cubit.dart';
import 'features/main/search/cubit/report_cubit.dart';
import 'features/settings/cubit/change_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => RegisterCubit()),
              BlocProvider(create: (context) => LoginCubit()),
              BlocProvider(create: (context) => SearchCubit()),
              BlocProvider(create: (context) => UserCubit()),
              BlocProvider(create: (context) => RequestCubit()),
              BlocProvider(create: (context) => SubjectsCubit()),
              BlocProvider(create: (context) => ScheduleCubit()),
              BlocProvider(create: (context) => ReportCubit()),
              BlocProvider(create: (context) => ForgotCubit()),
              BlocProvider(create: (context) => ChangeCubit()),
              BlocProvider(create: (context) => HomeCubit()),
              BlocProvider(create: (context) => RegisterPageCubit()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: GlobalVariables.base,
              )),
              builder: (context, child) => SafeArea(child: child!),
              onGenerateRoute: generateRoute,
              home: SplashScreen(),
            ),
          );
        });
  }
}
