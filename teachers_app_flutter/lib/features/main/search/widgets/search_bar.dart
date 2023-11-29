import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/global_variables.dart';

class SearchBar extends StatelessWidget {
  Function(String)? onChanged;
  SearchBar({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w, right: 10.w),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: GlobalVariables.base,
          blurRadius: 6,
        )
      ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            border: InputBorder.none,
            hintText: "Search",
            contentPadding: EdgeInsets.only(left: 10.w, top: 10.h)),
      ),
    );
  }
}
