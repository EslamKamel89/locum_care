import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/widgets/sizer.dart';
import 'package:locum_care/utils/assets/assets.dart';
import 'package:locum_care/utils/styles/styles.dart';

class TestimonialsWidget extends StatelessWidget {
  const TestimonialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final testimonials = [
          Testimonial(
            name: "Dr. Amira Watson",
            comment:
                "The Locum app has revolutionized how I manage my shifts. It's user-friendly and has significantly reduced my stress when looking for locum opportunities. Highly recommend!",
            image: AssetsData.review1,
          ),
          Testimonial(
            name: "Dr. Michael Carter",
            comment:
                "As a busy GP, finding reliable locum work was a challenge. The Locum app has simplified the process, allowing me to easily find and book shifts that fit my schedule.",
            image: AssetsData.review2,
          ),
          Testimonial(
            name: "Dr. Daniel Martinez",
            comment:
                "The convenience and efficiency of the Locum app are unmatched. I appreciate the transparency in job postings and the ease of communication with employers.",
            image: AssetsData.review3,
          ),

          Testimonial(
            name: "Dr. Amelia Patel",
            comment:
                "This app is a game-changer for locum doctors. It saves me so much time and effort in finding the right shifts. Plus, the ratings and reviews help me choose the best opportunities.",
            image: AssetsData.review6,
          ),
          //   Testimonial(
          //   name: "Dr. Amanda John",
          //   comment:
          //       "I was skeptical at first, but the Locum app has exceeded my expectations. It's straightforward to use, and the support team is always ready to help with any queries.",
          //   image: AssetsData.review4,
          // ),
          // Testimonial(
          //   name: "Dr. Daniel Martinez",
          //   comment:
          //       "The Locum app has made finding work incredibly seamless. I love how I can filter jobs based on location and specialty, ensuring I get the perfect match every time.",
          //   image: AssetsData.review6,
          // ),
          // Testimonial(
          //   name: "Dr. Amelia Patel",
          //   comment:
          //       "What I love most about the Locum app is the real-time notifications. I never miss out on any new opportunities, and the app's interface is clean and intuitive.",
          //   image: AssetsData.review1,
          // ),
          // Testimonial(
          //   name: "Dr. Ethan Johnson",
          //   comment:
          //       "Managing my locum work has never been easier. The Locum app provides all the information I need at my fingertips, and the job matching algorithm is spot on.",
          //   image: AssetsData.review2,
          // ),
          // Testimonial(
          //   name: "Dr. Grace Lee",
          //   comment:
          //       "The Locum app has significantly improved my work-life balance. I can now easily find shifts that suit my availability, making it easier to plan my personal time.",
          //   image: AssetsData.review3,
          // ),
          // Testimonial(
          //   name: "Dr. William Davis",
          //   comment:
          //       "I appreciate the professionalism of the Locum app. It offers a wide range of locum positions, and the process from application to confirmation is smooth and efficient.",
          //   image: AssetsData.review4,
          // ),
        ];
        return SizedBox(
          // height: 500.h,
          // color: Colors.red,
          child: CarouselSlider(
            options: CarouselOptions(autoPlay: true, height: 400),
            items:
                testimonials.map((testimonial) {
                  return SizedBox(
                    height: 9000,
                    child: SliderContent(
                      image: testimonial.image,
                      title: testimonial.name,
                      description: testimonial.comment,
                    ),
                  );
                  // CircularImageAsset(image: testimonial.image, height: 200.h),
                  // Text(testimonial.name),
                  // Text(testimonial.comment),

                  // .animate().fadeIn();
                }).toList(),
          ),
        );
      },
    );
  }
}

class SliderContent extends StatelessWidget {
  const SliderContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(image, height: 150.h, fit: BoxFit.fitHeight),
          ),
          Sizer(height: 30.h),
          txt(title, e: St.bold14, textAlign: TextAlign.center, c: context.secondaryHeaderColor),
          Sizer(height: 15.h),
          txt(description, e: St.reg12, c: Colors.grey, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Testimonial {
  final String name;
  final String comment;
  final String image;

  Testimonial({required this.name, required this.comment, required this.image});
}
