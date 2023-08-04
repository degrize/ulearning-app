import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ulearning_app/common/values/colors.dart';
import 'package:ulearning_app/main.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_blocs.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_events.dart';
import 'package:ulearning_app/pages/welcome/bloc/welcome_states.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
          builder: (context, state) {
            return SafeArea(
              child: Container(
                  width: 375.w,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          state.page = index;
                          BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                          if (kDebugMode) {
                            print("index value is ${index}");
                          }
                        },
                        children: [
                          _page(
                              1,
                              context,
                              'next',
                              'First see learning',
                              'Forget about a for of paper all knowledge in one learning',
                              'assets/images/reading.png'
                          ),
                          _page(
                              2,
                              context,
                              "next",
                              "Connect with everyone",
                              "Always keep in touch with your tutor & friend. let's get connected",
                              "assets/images/boy.png"
                          ),
                          _page(
                              3,
                              context,
                              'get started',
                              'Always Fascinated learning',
                              'Everywhere Anytime, the time is aut your discretion so'
                                  'study whenever you what',
                              'assets/images/man.png'
                          ),

                        ],
                      ),
                      Positioned(
                          bottom: 100.h,
                          child: DotsIndicator(
                            position: state.page,
                            dotsCount: 3,
                            mainAxisAlignment: MainAxisAlignment.center,
                            decorator: DotsDecorator(
                                color: AppColors.primaryThirdElementText,
                                activeColor: AppColors.primaryElement,
                                size: const Size.square(8.0),
                                activeSize: const Size(18.0, 8.0),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)
                                )

                            ),
                          )
                      )
                    ],
                  )
              ),
            );
          },
        )
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subTitle, String imagePath) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: 345.w,
            height: 345.h,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: Text(
                title,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.normal
                )
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 30.w
            ),
            child: Text(
                subTitle,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primarySecondaryElementText
                )
            ),
          ),
          GestureDetector(
            onTap: () {
              if (index < 3) {
                pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn
                );
              } else {
                /*Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (context) => MyHomePage(title: title)
                    )
                );*/
                
                Navigator.of(context).pushNamedAndRemoveUntil('signIn', (route) => false);
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: 25.w, right: 25.w, top: 50.h
              ),
              width: 325.w,
              height: 40.h,
              decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.all(Radius.circular(15.w)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1)
                    ),
                  ]
              ),
              child: Center(
                child: Text(buttonName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          )

        ],
      ),
    );
  }
}
