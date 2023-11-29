import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/constants/endpoints.dart';
import 'package:teachers_app/constants/global_variables.dart';

import 'package:teachers_app/models/tutor/tutor_model.dart';

import '../../../../router.dart';
import '../../search/screens/tutor_details.dart';

class CarouselItem extends StatefulWidget {
  final TutorModel tutor;
  CarouselItem({required this.tutor});

  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            generateRoute(RouteSettings(
                name: TutorDetails.routeName, arguments: widget.tutor)));
      },
      // onTap: tutor.description.isNotEmpty
      //     ? () {
      //         print(tutor.created_at);
      //         Navigator.of(context).push(GenerateRoute(
      //             RouteSettings(name: BlogDetails.routeName, arguments: tutor)));
      //       }
      //     : null,
      child: Container(
        // padding: EdgeInsets.all(10.sp),
        margin: EdgeInsets.all(10.sp),
        height: 220.h,
        width: 162.w,
        decoration: BoxDecoration(
            // color: GlobalVariables.base,
            color: Color.fromRGBO(196, 196, 196, 0.1),
            borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.sp),
                    topRight: Radius.circular(15.sp)),
                child: Image.network(
                  '${EndPoints.baseUrl}/${widget.tutor.state.image}',
                  width: 162.w,
                  height: 120.h,
                  fit: BoxFit.contain,
                ),
              ),

              Container(
                color: Color.fromARGB(1, 196, 196, 196),
                width: 162.w,
                height: 96.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12.sp,
                        ),
                        Text(
                          ' ' + widget.tutor.user.location,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: Color.fromRGBO(60, 60, 67, 0.8)),
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isFav = !isFav;
                              });
                            },
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              size: 17.sp,
                            )),
                        SizedBox(
                          width: 10.w,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 156.w,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.tutor.user.gender == 'male'
                                      ? "Mister."
                                      : "Miss.",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(60, 60, 67, 1),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' ${widget.tutor.user.name}, ${widget.tutor.state.subject_name} Teacher',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(60, 60, 67, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Align(
                        alignment: Alignment(-0.9, 1),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              'Rating : ${widget.tutor.rating}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(60, 60, 67, 1),
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15.sp,
                            )
                          ],
                        )),

                    // Align(
                    //     alignment: Alignment(-0.9, 1),
                    //     child: Text(
                    //       widget.tutor.state.subject_name + "Teacher",
                    //       style: TextStyle(
                    //           fontSize: 12.sp,
                    //           fontWeight: FontWeight.bold,
                    //           color: Color.fromRGBO(60, 60, 67, 1)),
                    //     )),
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                height: 30.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        GlobalVariables.base,
                        GlobalVariables.base.withOpacity(0.5),
                        GlobalVariables.base.withOpacity(0.3),

                        // GlobalVariables.base,
                      ],
                    ),
                    color: GlobalVariables.base,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Text(
                  'Featured',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(60, 60, 67, 1)),
                ),
              )
              // Container(
              //   alignment: Alignment.center,
              //   height: 60.h,
              //   width: 140.w,
              //   child: Text(
              //     tutor.user.name.length > 70
              //         ? tutor.user.name.substring(0, 50) + '.....'
              //         : tutor.user.name,
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         fontSize: 22.sp,
              //         color: Colors.white,
              //         fontWeight: FontWeight.w600),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
