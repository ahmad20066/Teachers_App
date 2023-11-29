import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/auth/profile/cubit/user_cubit.dart';
import 'package:teachers_app/features/auth/register/screens/register_screen.dart';
import 'package:teachers_app/features/auth/register/screens/role_screen.dart';
import 'package:teachers_app/features/main/home/widgets/title_container.dart';
import 'package:teachers_app/features/main/schedule/screens/request_history.dart';
import 'package:teachers_app/features/settings/screen/change_password_screen.dart';
import 'package:teachers_app/features/settings/screen/notifications/teacher_requests.dart';
import 'package:teachers_app/features/settings/widgets/setting_listtile.dart';
import 'package:teachers_app/router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) async {},
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserLoaded) {
            return Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                TitleContainer(
                  text: 'Settings',
                ),
                SettingListTile(
                    leadingIcon: Icons.logout,
                    title: 'Log Out',
                    onTap: () async {
                      await BlocProvider.of<UserCubit>(context).logOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          generateRoute(
                              RouteSettings(name: RoleScreen.routeName)),
                          (route) => false);
                    }),
                SettingListTile(
                    leadingIcon: Icons.password,
                    title: 'Change Password',
                    onTap: () {
                      Navigator.push(
                          context,
                          generateRoute(RouteSettings(
                              name: ChangePasswordScreen.routeName)));
                    }),
                SettingListTile(
                    leadingIcon: Icons.delete,
                    title: 'Deactivate your account',
                    onTap: () async {
                      final submit = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Are you sure?'),
                              content: Text(
                                  'Are you sure you want to delete your account?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Text(
                                      'YES',
                                      style: TextStyle(color: Colors.red),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: Text('No')),
                              ],
                            );
                          });
                      if (submit) {
                        await BlocProvider.of<UserCubit>(context)
                            .deactivateAcc();

                        await BlocProvider.of<UserCubit>(context).logOut();
                        Navigator.pushReplacement(
                          context,
                          generateRoute(
                              RouteSettings(name: RoleScreen.routeName)),
                        );
                      }
                    }),
                // SettingListTile(
                //     leadingIcon: Icons.remove_from_queue_outlined,
                //     title: "Requests",
                //     onTap: () {
                //       if (state.user.user.role == Role.student) {
                //         Navigator.push(
                //             context,
                //             generateRoute(RouteSettings(
                //                 name: StudentRequestHistory.routeName)));
                //       } else {
                //         Navigator.push(
                //             context,
                //             generateRoute(RouteSettings(
                //                 name: TeacherRequests.routeName)));
                //       }
                //     })
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
