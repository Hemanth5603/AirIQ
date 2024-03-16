import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackoverflow_mobile/constants/colors.dart';
import 'package:hackoverflow_mobile/constants/data.dart';
import 'package:hackoverflow_mobile/models/productModel.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({super.key});

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {


  






  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Constants.getColor(77),
        ),
        child: Icon(Icons.shopping_cart_rounded,color: Colors.white,),
      ),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        title: Text("MarketPlace",style: TextStyle(fontFamily: 'man-sb',fontSize: 18),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.9,
                child: GridView.builder(
                  itemCount: ConstantData.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                ), 
                itemBuilder:(BuildContext context,index){
                  return ProductCard(h, w, ConstantData.products[index].image,ConstantData.products[index].name, ConstantData.products[index].quantity, ConstantData.products[index].price);
          
                }),
              )
          
            ],
          ),
        ),
      ),
    );


    
  }
  Widget ProductCard(h,w,image,name,quantity,price){
    return Container(
      height: h * 0.3,
      width: w * 0.2,
      
      decoration: BoxDecoration(
     
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: w,
            height: h * 0.12,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.contain
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextStyle(fontFamily: 'man-sb',fontSize: 14),),
                  
                  Text(quantity,style: TextStyle(fontFamily: 'man-l',fontSize: 10,color: Colors.grey),),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Text(price,style: TextStyle(fontFamily: 'man-b',fontSize: 16),),
                      Container(
                        width: w * 0.16,
                        height: h * 0.03,
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:Constants.getColor(77),),
                        
                        child: Center(
                          child: Text("Add",style: TextStyle(fontSize: 12,fontFamily: 'man-r',color: Colors.white),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  
}



