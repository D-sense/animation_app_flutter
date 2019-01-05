import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
      return HomeState();
    }
}

class HomeState extends State<Home> with TickerProviderStateMixin{
  Animation<double> catAnimation; 
  AnimationController catController;

  Animation<double> boxAnimation; 
  AnimationController boxController;

  initState() {
    super.initState();

    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation = Tween(
      begin: pi * 0.6, 
      end: pi * 0.65
    ).animate(
        CurvedAnimation(
          parent: boxController,
          curve: Curves.easeInOut,
        ),
    );
    boxAnimation.addStatusListener((status){
        if(status == AnimationStatus.completed){
             boxController.reverse();
        }else if(status == AnimationStatus.dismissed){
             boxController.forward();
        }  
    });
    boxController.forward();
    


    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
        CurvedAnimation(
          parent: catController,
          curve: Curves.easeIn,
        ),
    );
  }

  onTap() {
    if(catController.status == AnimationStatus.completed){
      boxController.forward();
      catController.reverse();
    }else if(catController.status == AnimationStatus.dismissed){
      boxController.stop();
      catController.forward();
    }
  }

  Widget build(context){
    return  Scaffold(
        appBar: AppBar(
          title: Text("Animation")
        ),
        body: GestureDetector(
          child: Center(
              child: Stack(overflow:Overflow.visible, children:[
                buildCatAnimation(),
                buildBox(),
                buildLeftFlap(),
                buildRightFlap()
              ]),
          ),
          onTap: onTap
        )
    );
  }

   Widget buildBox(){
    return Container(
      height: 200,
      width:200,
      color:Colors.blue
    );
  }
  
  Widget buildCatAnimation(){
     return AnimatedBuilder(
       animation: catAnimation,
       builder: (context, child){
         return Positioned(
           child: child,
           top: catAnimation.value,
           right: 0,
           left: 0,
         );
       },
       child: Cat(),
     );
  }


  Widget buildLeftFlap(){
    return Positioned(
          left:3,
          child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
              height:10.0,
              width: 125.0,
              color: Colors.blue
          ),
          builder: (context, child){
               return Transform.rotate(
                  child: child,
                  angle: boxAnimation.value,
                  alignment: Alignment.topLeft
               );   
          },
      ),
    ); 
  }

   Widget buildRightFlap(){
    return Positioned(
          right:3,
          child: AnimatedBuilder(
          animation: boxAnimation,
          child: Container(
              height:10.0,
              width: 125.0,
              color: Colors.blue
          ),
          builder: (context, child){
               return Transform.rotate(
                  child: child,
                  angle: -boxAnimation.value,
                  alignment: Alignment.topRight
               );   
          },
      ),
    ); 
  }


}