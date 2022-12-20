import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'getMediaQuery.dart';
import 'Real_Main.dart';

class Achieved_Goal extends StatelessWidget {
  // 위젯간 간격(세로)
  double titleFontSize = 17;
  // 연노랑
  int color_whiteYellow = 0xFFFAF4B7;
  // 찐노랑
  int color_realYellow = 0xFFFFD966;
  // 민트
  int color_mint = 0xFFCDF0EA;

  @override
  Widget build(BuildContext context) => Container(
        // 상태바 높이만큼 띄우기
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        // 배경 이미지 적용
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/background.png'))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // 앱 상단 로고
                Container(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        22 /
                        100,
                    width: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        10 /
                        100,
                    padding: EdgeInsets.only(
                        bottom: (MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top) *
                            5 /
                            100),
                    child: Image.asset(
                      'assets/img/icon.png',
                    )),

                // 세로 화면의 22% 비율부터 시작
                Container(
                    height: (MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top) *
                        78 /
                        100,
                    width: MediaQuery.of(context).size.width,
                    // 여기서부터 찐 개발 시작
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 제목
                        Column(
                          children: [
                            Text("달성한 목표들",
                                style: TextStyle(fontSize: titleFontSize)),
                            Container(
                              height: 5,
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                //모서리를 둥글게 하기 위해 사용
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              color: Color(color_whiteYellow),
                              elevation: 0, // 그림자 깊이
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width:
                                    getMobileSizeFromPercent(context, 80, true),
                                height: getMobileSizeFromPercent(
                                    context, 50, false),
                                child: ListView(
                                  // scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.all(10),
                                  children: [
                                    Card(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Real_Main()));
                                        },
                                        child: Text(
                                          "토익 850점 넘기",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                      color: Color(color_whiteYellow),
                                      margin: EdgeInsets.all(2),
                                    ),
                                    Card(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Real_Main()));
                                        },
                                        child: Text(
                                          "데이터베이스 자격증 따기",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                      color: Color(color_whiteYellow),
                                      margin: EdgeInsets.all(2),
                                    ),
                                    Card(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Real_Main()));
                                        },
                                        child: Text(
                                          "알고리즘 마스터하기",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                      color: Color(color_whiteYellow),
                                      margin: EdgeInsets.all(2),
                                    ),
                                    Card(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Real_Main()));
                                        },
                                        child: Text(
                                          "앱 배포 프로젝트 마무리",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                      color: Color(color_whiteYellow),
                                      margin: EdgeInsets.all(2),
                                    ),
                                    Card(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Real_Main()));
                                        },
                                        child: Text(
                                          "매일 영단어 100개 암기",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                      color: Color(color_whiteYellow),
                                      margin: EdgeInsets.all(2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        Card(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게 하기 위해 사용
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color: Color(color_mint),
                          elevation: 0, // 그림자 깊이
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Real_Main()));
                            },

                            // 로그인 버튼
                            child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                width:
                                    getMobileSizeFromPercent(context, 50, true),
                                height:
                                    getMobileSizeFromPercent(context, 6, false),
                                child: Text(
                                  "뒤로 가기",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    )),
              ]),
        ),
      );
}
