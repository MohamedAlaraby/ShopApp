import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? desc;

  BoardingModel({required this.image, required this.title, required this.desc});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/onboarding_image.png',
        title: 'On Boarding Title1',
        desc: 'On Boarding Description1',

    ),
    BoardingModel(
        image: 'assets/images/onboarding_image.png',
        title: 'On Boarding Title2',
        desc: 'On Boarding Description2',
    ),
    BoardingModel(
        image: 'assets/images/onboarding_image.png',
        title: 'On Boarding Title3',
        desc: 'On Boarding Description3',
    ),
  ];
  final PageController boardingController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop App'),
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: boardingController,
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              onPageChanged: (index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 40.0),
          Row(
            children: [
              SmoothPageIndicator(
                controller: boardingController,
                count: boarding.length,
                effect: const ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 16,
                    dotWidth: 16,
                    spacing: 5,
                    expansionFactor: 3),
              ),
              const Spacer(),
              FloatingActionButton(
                  child: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.linear,
                      );
                    }
                  }),
            ],
          ),
        ]),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image!))),
          const SizedBox(height: 30.0),
          Text(
            model.title!,
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            model.desc!,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      //the data saved successfully
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }
}
