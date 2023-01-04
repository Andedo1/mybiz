import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:majisoft/controllers/popular_item_controller.dart';
import 'package:majisoft/models/product_model.dart';
import 'package:majisoft/utils/dimensions.dart';
import 'package:majisoft/widgets/big_text.dart';
import 'package:majisoft/widgets/column.dart';
import 'package:majisoft/widgets/ico_and_text.dart';
import 'package:majisoft/widgets/small_text.dart';

import '../../controllers/recommended_item_controller.dart';
import '../../routes/routes_helper.dart';
import '../../utils/app_constants.dart';

class ItemBody extends StatefulWidget {
  const ItemBody({Key? key}) : super(key: key);

  @override
  State<ItemBody> createState() => _ItemBodyState();
}

class _ItemBodyState extends State<ItemBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double _height = Dimension.pageViewContainer;
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }
  @override
  void dispose(){
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider section
        GetBuilder<PopularItemController>(
          builder: (popularItems){
            return popularItems.isLoaded?Container(
                height: Dimension.pageView,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: popularItems.popularItemList.length,
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularItems.popularItemList[position]);
                  },
                )
            ):const CircularProgressIndicator(color: Colors.blue,);
          },
        ),
        //Dots
        GetBuilder<PopularItemController>(
          builder: (popularItems) {
            return DotsIndicator(
              dotsCount: popularItems.popularItemList.isEmpty?1:popularItems.popularItemList.length,
              position: _currPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
              ),
            );
          }
        ),
        //Popular text
        SizedBox(height: Dimension.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(width: Dimension.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimension.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Item pairing",),
              )
            ],
          ),
        ),
        //List of items and images
        GetBuilder<RecommendedItemController>(
          builder: (recommendedItem){
            return recommendedItem.isLoaded?ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedItem.recommendedItemList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RoutesHelper.getRecommendedItem());
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimension.width20, right: Dimension.width20, bottom: Dimension.height10),
                    child: Row(
                      children: [
                        //Image section
                        Container(
                          height: Dimension.listViewImgSize,
                          width: Dimension.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimension.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    "${AppConstants.BASE_URL}/uploads/"+recommendedItem.recommendedItemList[index].img,
                                  )
                              )
                          ),
                        ),
                        //Text section
                        Expanded(
                          child: Container(
                            height: Dimension.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimension.radius20),
                                bottomRight: Radius.circular(Dimension.radius20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimension.width10, right: Dimension.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedItem.recommendedItemList[index].name!),
                                  SizedBox(height: Dimension.height10,),
                                  SmallText(text: "Battery operated(5 years life span)"),
                                  SizedBox(height: Dimension.height20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const<Widget>[
                                      IconAndText(icon: Icons.circle_sharp, text: "Normal", iconcolor: Colors.orange),
                                      IconAndText(icon: Icons.location_on, text: "20KM", iconcolor: Colors.green),
                                      IconAndText(icon: Icons.access_time_rounded, text: "25min", iconcolor: Colors.blue)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ):
            const CircularProgressIndicator(color: Colors.blue);
          },
        )
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularItem){
    Matrix4 matrix = Matrix4.identity();
    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(0, _height*(1-_scaleFactor)/2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RoutesHelper.getPopularItem(index));
            },
            child: Container (
              height: Dimension.pageViewContainer,
              margin: EdgeInsets.only(left: Dimension.width10, right: Dimension.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  color: index.isEven?Colors.blue : Colors.yellow,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "${AppConstants.BASE_URL}/uploads/${popularItem.img!}"
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimension.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimension.width30, right: Dimension.width30, bottom: Dimension.height30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: Colors.white,
                boxShadow: const[
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5.0,
                    offset: Offset(0,5)
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5,0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5,0),
                  )
                ]
              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimension.height15, left: Dimension.width15, right: Dimension.width15),
                child: AppColumn(text: popularItem.name!,)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
