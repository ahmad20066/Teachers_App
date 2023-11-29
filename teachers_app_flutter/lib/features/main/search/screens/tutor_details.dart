import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/common/widgets/custom_textfield.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/features/main/search/cubit/report_cubit.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';

import '../../../../constants/endpoints.dart';
import '../../../auth/profile/cubit/user_cubit.dart';
import '../../schedule/cubit/request_cubit.dart';

class TutorDetails extends StatefulWidget {
  static const routeName = '/details';
  final TutorModel tutor;
  const TutorDetails({super.key, required this.tutor});

  @override
  State<TutorDetails> createState() => _TutorDetailsState();
}

class _TutorDetailsState extends State<TutorDetails> {
  Widget buildRow(IconData icon, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25.sp,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 18.sp),
          )
        ],
      ),
    );
  }

  DateTime? _selectedDateTime;

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  String getFormattedDateTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.sssZ');
    return formatter.format(dateTime.toUtc());
  }

  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RequestCubit, RequestState>(
        listener: (context, state) {
          if (state is RequestSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Request Added Successfuly'),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ));
          } else if (state is RequestError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
              duration: Duration(seconds: 3),
            ));
          }
        },
        builder: (context, state) {
          if (state is RequestLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Image.network(
                    "${EndPoints.baseUrl}/${widget.tutor.user.image}"),
                SizedBox(
                  height: 20.h,
                ),
                buildRow(Icons.person, widget.tutor.user.name),
                buildRow(Icons.phone, widget.tutor.user.phone_number),
                buildRow(
                    Icons.location_on_outlined, widget.tutor.user.location),
                buildRow(Icons.quiz, widget.tutor.state.subject_name),
                buildRow(
                    widget.tutor.user.gender == 'male'
                        ? Icons.male
                        : Icons.female,
                    widget.tutor.user.gender),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      print(state.user.user.role);
                      if (state.user.user.role == Role.student) {
                        return Column(
                          children: [
                            CustomButton(
                                text: 'Request',
                                onTap: () {
                                  bool isPicked = false;
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return Dialog(
                                            child: Container(
                                              height: 200.h,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  CustomButton(
                                                      text:
                                                          'Pick Date And Time',
                                                      onTap: () {
                                                        _pickDateTime();
                                                        if (_selectedDateTime !=
                                                            null) {
                                                          setState(() {
                                                            isPicked = true;
                                                          });
                                                        }
                                                      }),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  CustomButton(
                                                      text: 'Submit',
                                                      height: 40.h,
                                                      width: 80.w,
                                                      color: !isPicked
                                                          ? Colors.grey
                                                          : null,
                                                      onTap: !isPicked
                                                          ? null
                                                          : () async {
                                                              setState(() {
                                                                isPicked = true;
                                                              });

                                                              await BlocProvider
                                                                      .of<RequestCubit>(
                                                                          context)
                                                                  .addRequest(
                                                                      widget
                                                                          .tutor
                                                                          .user
                                                                          .id,
                                                                      _selectedDateTime!,
                                                                      widget
                                                                          .tutor
                                                                          .state
                                                                          .subject_name);
                                                              Navigator.pop(
                                                                  context);
                                                            })
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                      });
                                }),
                            SizedBox(
                              height: 20.h,
                            ),
                            CustomButton(
                                text: "Report",
                                color: Colors.red,
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                            content: BlocConsumer<ReportCubit,
                                                ReportState>(
                                              listener: (context, state) {
                                                if (state is ReportSucces) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          duration: Duration(
                                                              seconds: 3),
                                                          backgroundColor:
                                                              Colors.green,
                                                          content: Text(
                                                              'Report Submitted Successfulyy')));
                                                } else if (state
                                                    is ReportError) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          duration: Duration(
                                                              seconds: 3),
                                                          backgroundColor:
                                                              Colors.red,
                                                          content: Text(
                                                              state.error)));
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state is ReportLoading) {
                                                  return Container(
                                                      height: 90.h,
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ));
                                                }
                                                return Container(
                                                  height: 100.h,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          'Why do you intent to report this teacher'),
                                                      SizedBox(
                                                        height: 10.h,
                                                      ),
                                                      CustomTextFiled(
                                                          onChanged: (v) {
                                                            setState(() {});
                                                          },
                                                          textController:
                                                              reasonController,
                                                          labelText: 'reason',
                                                          vMargin: 0),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: reasonController
                                                          .text.isNotEmpty
                                                      ? () async {
                                                          await BlocProvider.of<
                                                                      ReportCubit>(
                                                                  context)
                                                              .report(
                                                                  widget.tutor
                                                                      .user.id,
                                                                  reasonController
                                                                      .text);
                                                        }
                                                      : null,
                                                  child: Text('Submit'))
                                            ],
                                          );
                                        });
                                      });
                                })
                          ],
                        );
                      } else {
                        return Container();
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
                SizedBox(
                  height: 50.h,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
