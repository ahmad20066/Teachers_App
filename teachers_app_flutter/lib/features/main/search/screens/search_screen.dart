import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teachers_app/features/main/search/cubit/search_cubit.dart';
import 'package:teachers_app/features/main/search/widgets/search_bar.dart';
import 'package:teachers_app/features/main/search/widgets/tutors_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    BlocProvider.of<SearchCubit>(context).getTutors(alphabet: isAlphabet);
    super.initState();
  }

  bool isAlphabet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                  child: SearchBar(onChanged: (v) {
                    BlocProvider.of<SearchCubit>(context)
                        .getTutors(search: v, alphabet: isAlphabet);
                  }),
                ),
                SizedBox(
                  width: 100.w,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              isAlphabet = true;
                            });
                            await BlocProvider.of<SearchCubit>(context)
                                .getTutors(alphabet: isAlphabet);
                          },
                          icon: Icon(
                              isAlphabet ? Icons.abc : Icons.abc_outlined)),
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              isAlphabet = false;
                            });
                            await BlocProvider.of<SearchCubit>(context)
                                .getTutors(alphabet: isAlphabet);
                          },
                          icon: Icon(isAlphabet
                              ? Icons.star_border_outlined
                              : Icons.star))
                    ],
                  ),
                )
              ],
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is TutorsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TutorsLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      TutorsList(tutors: state.tutors)
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
