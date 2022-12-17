import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Container(
    // 배경 이미지 적용
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/img/background.png')
        )
    ),
    child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // 세로 화면의 22% 비율부터 시작
            Container(
              height: MediaQuery.of(context).size.height * 78 / 100,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ElevatedButton(onPressed: ()=>null, child: Text("여기서부터 개발하시면 됩니다"))
                ],
              ),
            )
          ]
          ,)
    ),
  );
}