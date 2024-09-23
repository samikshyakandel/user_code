import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Utils/app_textstyle.dart';

import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_widget.dart';
import '../App_Widgets/textfield_widget.dart';
import 'Controller/review_controller.dart';

class GiveRatingView extends StatelessWidget {
  GiveRatingView({super.key});

  final ReviewController reviewController = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(
          () => AbsorbPointer(
            absorbing: reviewController.isLoading.value,
            child: Form(
              key: reviewController.reviewFormGlobalKey,
              child: Container(
                alignment: FractionalOffset.topLeft,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                    alignment: FractionalOffset.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppbarWidget(
                          title: "Review",
                          isSearch: false,
                          isCart: false,
                        ),
                        Expanded(
                            child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("How would you rate it?",
                                    style: AppTextStyle.lableLarge),
                                const SizedBox(
                                  height: 20,
                                ),
                                Obx(
                                  () => StarRating(
                                    starCount: 5,
                                    rating: reviewController.rating.value,
                                    color: Colors.orange,
                                    size: 50,
                                    onRatingChanged: (double doubleVal) =>
                                        reviewController.rating.value =
                                            doubleVal,
                                  ),
                                ),
                                /*  const SizedBox(
                                  height: 30,
                                ),
                                TextFieldWidget(
                                  controller: reviewController.titleReviewCont,
                                  headerText: "Title Your review",
                                  hintText: "Enter Your Review Title",
                                  validator: (nameValue) {
                                    if (nameValue!.isEmpty) {
                                      return "Enter Title";
                                    }
                                    return null;
                                  },
                                ),*/
                                const SizedBox(height: 20),
                                TextFieldWidget(
                                  controller: reviewController.descReviewCont,
                                  headerText: "Write your review",
                                  hintText: "Enter Your Review",
                                  minLines: 3,
                                  maxLines: 4,
                                  // validator: (nameValue) {
                                  //   if (nameValue!.isEmpty) {
                                  //     return "Enter Review";
                                  //   }
                                  //   return null;
                                  // },
                                ),
                              ],
                            ),
                          ),
                        )),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: ButtonWidget(
                            title: "SUBMIT",
                            onTap: () {
                              if (reviewController
                                  .reviewFormGlobalKey.currentState!
                                  .validate()) {
                                reviewController.addReviewApi();
                              }
                            },
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final Color color;
  final double size;
  final Function(double) onRatingChanged;

  const StarRating(
      {super.key,
      this.starCount = 5,
      this.rating = .0,
      required this.color,
      this.size = 50,
      required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(starCount, (index) {
        return GestureDetector(
          onTap: () {
            onRatingChanged(index + 1.0);
          },
          child: Icon(
            index < rating ? Icons.star : Icons.star_border,
            color: color,
            size: size,
          ),
        );
      }),
    );
  }
}
