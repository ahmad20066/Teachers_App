import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:teachers_app/common/widgets/custom_button.dart';
import 'package:teachers_app/common/widgets/custom_textfield.dart';
import 'package:teachers_app/constants/endpoints.dart';
import 'package:teachers_app/constants/global_variables.dart';
import 'package:teachers_app/models/request/request_model.dart';
import 'package:teachers_app/models/subject/subject_model.dart';
import 'package:teachers_app/models/tutor/tutor_model.dart';

import '../../../../../router.dart';
import '../../../search/screens/tutor_details.dart';
import '../../cubit/cubit/schedule_cubit.dart';
import '../../cubit/request_cubit.dart';

class RequestItem extends StatefulWidget {
  final RequestModel request;
  final bool isTeacher;
  const RequestItem(
      {super.key, required this.request, required this.isTeacher});

  @override
  State<RequestItem> createState() => _RequestItemState();
}

class _RequestItemState extends State<RequestItem> {
  TextEditingController commentController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.sp),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          children: [
            if (!widget.isTeacher)
              Row(
                children: [
                  CircleAvatar(
                    radius: 35.sp,
                    backgroundImage: NetworkImage(
                        "${EndPoints.baseUrl}/${widget.request.tutor.image}"),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.request.tutor.name,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        widget.request.tutor.phone_number,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        widget.request.tutor.location,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(DateFormat().format(widget.request.date)),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        widget.request.state,
                        style: TextStyle(
                            color: widget.request.state == 'pending'
                                ? Colors.amber
                                : widget.request.state == 'rejected'
                                    ? Colors.red
                                    : Colors.green),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      if (widget.request.state == 'rejected' &&
                          widget.request.comment != null)
                        Container(
                          padding: EdgeInsets.all(15.sp),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Text(widget.request.comment!),
                        )
                    ],
                  ),
                ],
              ),
            if (widget.isTeacher)
              Row(
                children: [
                  CircleAvatar(
                    radius: 35.sp,
                    backgroundImage: NetworkImage(
                        "${EndPoints.baseUrl}/${widget.request.student.image}"),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.request.student.name,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        widget.request.student.phone_number,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        widget.request.student.location,
                      )
                    ],
                  ),
                ],
              ),
            SizedBox(
              height: 10.h,
            ),
            if (!widget.isTeacher && widget.request.state == 'pending')
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      text: 'Cancel',
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final success =
                            await BlocProvider.of<RequestCubit>(context)
                                .cancelRequest(widget.request.id);

                        setState(() {
                          isLoading = false;
                        });
                        if (success) {
                          // Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Request Canceled Successfuly'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 3),
                            ),
                          );
                          await BlocProvider.of<RequestCubit>(context)
                              .getRequestsStudent();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }

                        // await BlocProvider.of<RequestCubit>(context)
                        //     .getRequestsStudent();
                      },
                      color: Colors.red,
                      height: 40.h,
                      width: 100.w,
                    ),
            if (widget.isTeacher)
              CustomTextFiled(
                  textController: commentController,
                  labelText: 'Comment',
                  vMargin: 10),
            SizedBox(
              height: 20.h,
            ),
            if (widget.isTeacher)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Accept',
                    color: Colors.green,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final success =
                          await BlocProvider.of<RequestCubit>(context)
                              .acceptRequest(
                                  widget.request.id, commentController.text);
                      setState(() {
                        isLoading = false;
                      });

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Request Accepted Successfuly'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                          ),
                        );
                        await BlocProvider.of<ScheduleCubit>(context)
                            .getTeacherSchedule();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    width: 100.w,
                    margin: EdgeInsets.zero,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  CustomButton(
                    text: 'Reject',
                    color: Colors.red,
                    margin: EdgeInsets.zero,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final success =
                          await BlocProvider.of<RequestCubit>(context)
                              .rejectRequest(
                                  widget.request.id, commentController.text);
                      setState(() {
                        isLoading = false;
                      });
                      print(success);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Request Accepted Successfuly'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 3),
                          ),
                        );
                        await BlocProvider.of<ScheduleCubit>(context)
                            .getTeacherSchedule();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error'),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    width: 100.w,
                  )
                ],
              ),
            if (!widget.isTeacher)
              GestureDetector(
                onTap: () {
                  print('aaa');
                  final tutor = TutorModel(
                      id: widget.request.tutor.id,
                      state: SubjectModel(
                          id: '',
                          subject_name: widget.request.subject!,
                          image: ''),
                      user: widget.request.tutor,
                      certificates: []);
                  Navigator.push(
                      context,
                      generateRoute(RouteSettings(
                          name: TutorDetails.routeName, arguments: tutor)));
                },
                child: Container(
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                      border: Border.all(color: GlobalVariables.base, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("View Details"),
                ),
              )
          ],
        ),
      ),
    );
  }
}
