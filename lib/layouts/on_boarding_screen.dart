import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/componanes/componanets.dart';
import 'package:shop_app/layouts/login_screen.dart';
import 'package:shop_app/shared/local/shared_pref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

var boardingController = PageController();
var isLast = false;
class BoardingModel {
  final String title;
  final String images;
  final String body;

  BoardingModel(
      {required this.title, required this.images, required this.body});

}

List<BoardingModel> boardingmodel = [
  BoardingModel(

    images: 'assets/images/boarding.png',
    title: 'Shopping Now Easier  ',
    body: 'All you need is here !',
  ),
  BoardingModel(
    images: 'assets/images/shopBoarding.png',
    title: 'ALL Brands in your hand',
    body: 'Fast Shopping',
  ),
  BoardingModel(
    images: 'assets/images/payBoard.png',
    title: 'Easy payment',
    body: 'pay with your visa Now!',
  ),
];

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.purple,
        actions: [
          TextButton(
              onPressed:() {submit(context);},
              child: Text(
                'SKIP',
                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boardingmodel.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardingmodel[index]),
                itemCount: boardingmodel.length,
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boardingmodel.length,
                  effect: SwapEffect(spacing: 6.0),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.purpleAccent,
                  onPressed: () {
                    if (isLast) {
                      submit(context);
                    } else {
                      boardingController.nextPage(
                          duration: Duration(milliseconds: 700),
                          curve: Curves.fastOutSlowIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage('${model.images}')),
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0,color: Colors.white,),
          ),
          SizedBox(height: 20.0),
          Text(
            '${model.body}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0,color: Colors.white),
          ),
        ],
      );
  void submit(context){
    CashHelper.saveData(key: 'Boarding', value: true).then((value) {
      if (value=true) {
        Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen(),
        ),
            (Route<dynamic>route) => false,
      );
      }
    });

  }
}
