import 'package:first_side_project_app/Achieved_Goal.dart';
import 'package:flutter/material.dart';
import 'getMediaQuery.dart';
import 'dart:math';

import 'EditDaily.dart';

class AchievementRate extends StatefulWidget {
  @override
  State<AchievementRate> createState() => _AchievementRate();
}

class _AchievementRate extends State<AchievementRate> {
  String today = "";
  int maxDay = 0; // 해당 달에 몇일까지 있나
  List<DailyObj> dailyList = [];
  List<double> dayAchieve = [];

  // 연노랑
  int color_whiteYellow = 0xFFFAF4B7;

  // 찐노랑
  int color_realYellow = 0xFFFFD966;

  // 민트
  int color_mint = 0xFFCDF0EA;

  // 0% 색깔
  int color_rate0 = 0xFFCDF0EA;

  // ~49% 색깔
  int color_rate49 = 0xFFB8E8FC;

  // ~99% 색깔
  int color_rate99 = 0xFFECC5FB;

  // 100% 색깔
  int color_rate100 = 0xFFB1AFFF;

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    today = year.toString() +
        (month < 10 ? "0" + month.toString() : month.toString()) +
        (day < 10 ? "0" + day.toString() : day.toString());
    maxDay = getMaxDay(today.substring(0, 6));
    print("오늘 날짜: " + today);

    // 랜덤으로 daily 넣어줌
    for (int i = 0; i < 100; i++) {
      int randDay = Random().nextInt(getMaxDay(today.substring(0, 6)));
      dailyList.add(DailyObj(
          Random().nextInt(6),
          "202212" +
              (randDay < 10 ? "0" + randDay.toString() : randDay.toString()),
          (Random().nextInt(2) == 0 ? "ON" : "OFF")));
    }

    // daily 정보를 토대로 일별 달성률 리스트 작성
    for (int i = 1; i <= maxDay; i++) {
      int totalCount = 0;
      int achevedCnt = 0;
      // 날짜별 요소 갯수와, 달성된 요소 개수 구함
      for (DailyObj daily in dailyList) {
        // print(daily.date);
        // print(today.substring(0,6));
        if (daily.date ==
            today.substring(0, 6) +
                (i < 10 ? "0" + i.toString() : i.toString())) {
          totalCount += 1;
          if (daily.status == "ON") {
            achevedCnt += 1;
          }
        }
      }
      dayAchieve.add(totalCount != 0 ? achevedCnt / totalCount * 100 : -1);
    }

    // 요일에 따라 빈칸 넣어줌
    String startWeek = getDayOfWeek(today);
    switch (startWeek) {
      case "월":
        break;
      case "화":
        dayAchieve.insert(0, -1);
        break;
      case "수":
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        break;
      case "목":
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        break;
      case "금":
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        break;
      case "토":
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        break;
      case "일":
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        dayAchieve.insert(0, -1);
        break;
      default:
        break;
    }

    // 서버에서 데이터를 받아옴
  }

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
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(getMobileSizeFromPercent(context, 18, false)),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset('assets/img/icon.png'),
                      height: getMobileSizeFromPercent(context, 10, false),
                    ),
                  ],
                ),
              ),
            ),

            // floatig button
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,

            floatingActionButton: Stack(
              children: <Widget>[
                Positioned(
                  left: 10,
                  top: getMobileSizeFromPercent(context, 50, false),
                  child: SizedBox(
                    width: 40,
                    child: FloatingActionButton(
                      heroTag: "btn1",
                      onPressed: (() => print("")),
                      child: Icon(Icons.arrow_circle_left, size: 38),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: getMobileSizeFromPercent(context, 50, false),
                  child: SizedBox(
                    width: 40,
                    child: FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: (() => print("")),
                      child: Icon(Icons.arrow_circle_right, size: 38),
                    ),
                  ),
                ),
              ],
            ),

            // Body
            body: Container(
                height: getMobileSizeFromPercent(context, 82, false) -
                    MediaQuery.of(context).padding.top * 2,
                width: double.infinity,
                // 여기서부터 찐 개발 시작
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      // 요일_달력
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 날짜
                          Text(today.substring(0,4) + " - " + today.substring(4,6), style: TextStyle(fontSize: 30)),

                          Container(),

                          // 요일
                          Container(
                            padding: EdgeInsets.all(3),
                            width: getMobileSizeFromPercent(context, 80, true),
                            height: getMobileSizeFromPercent(context, 5, false),
                            child: GridView.count(
                              crossAxisCount: 7,
                              crossAxisSpacing: 5,
                              children: [
                                Text(
                                  "월",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "화",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "수",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "목",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "금",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "토",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                Text(
                                  "일",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // 달력
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border:
                                    Border.all(color: Colors.black, width: 3)),
                            // color: Colors.yellow,
                            width: getMobileSizeFromPercent(context, 80, true),
                            height:
                                ((getMobileSizeFromPercent(context, 80, true) -
                                                    12) /
                                                7 +
                                            2) *
                                        (dayAchieve.length / 7).ceil() -
                                    2,
                            child: GridView.builder(
                                itemCount: dayAchieve.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7,
                                        crossAxisSpacing: 2,
                                        mainAxisSpacing: 2),
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13),
                                          color: (dayAchieve[index] < 0
                                              ? Colors.transparent
                                              : ( // 빈칸 or 목표 없는 날
                                                  dayAchieve[index] == 0
                                                      ? Color(color_rate0)
                                                      : ( // 0%
                                                          dayAchieve[index] < 50
                                                              ? Color(
                                                                  color_rate49)
                                                              : ( // ~49%
                                                                  dayAchieve[index] <
                                                                          100
                                                                      ? Color(
                                                                          color_rate99)
                                                                      : // ~99%
                                                                      Color(
                                                                          color_rate100) // 100%
                                                              ))))),
                                    )),
                          ),

                          Container(height: 20,),

                          // 색당 달성률 정보
                          Container(
                            width: getMobileSizeFromPercent(context, 70, true),
                            child: Column(
                              children: [
                                // 윗줄
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // 0%
                                    Container(
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("0 %", style: TextStyle(fontSize: 20)),
                                          Container(
                                              width: (getMobileSizeFromPercent(
                                                          context, 80, true) -
                                                      12) /
                                                  7,
                                              height: (getMobileSizeFromPercent(
                                                          context, 80, true) -
                                                      12) /
                                                  7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: Color(color_rate0),
                                              )),
                                        ],
                                      ),
                                    ),

                                    Container(width: getMobileSizeFromPercent(context, 10, true),),

                                    // ~49%
                                    Container(
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("~49 %", style: TextStyle(fontSize: 20)),
                                          Container(
                                              width: (getMobileSizeFromPercent(
                                                          context, 80, true) -
                                                      12) /
                                                  7,
                                              height: (getMobileSizeFromPercent(
                                                          context, 80, true) -
                                                      12) /
                                                  7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: Color(color_rate49),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  height: 5,
                                ),

                                // 아래줄
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    // 99%
                                    Container(
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("~99 %", style: TextStyle(fontSize: 20)),
                                          Container(
                                              width: (getMobileSizeFromPercent(
                                                          context, 80, true) -
                                                      12) /
                                                  7,
                                              height: (getMobileSizeFromPercent(
                                                          context, 80, true) -
                                                      12) /
                                                  7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: Color(color_rate99),
                                              )),
                                        ],
                                      ),
                                    ),

                                    Container(width: getMobileSizeFromPercent(context, 10, true),),

                                    // 100%
                                    Container(
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("100 %",  style: TextStyle(fontSize: 20)),
                                          Container(
                                              width: (getMobileSizeFromPercent(
                                                          context, 80, true) -
                                                      12) /
                                                  7,
                                              height: (getMobileSizeFromPercent(
                                                          context, 80, true) -
                                                      12) /
                                                  7,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                color: Color(color_rate100),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      // 뒤로가기
                      Container(
                        width: getMobileSizeFromPercent(context, 80, true),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              // 완료
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(
                                    getMobileSizeFromPercent(context, 30, true),
                                    40),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "달성한 목표",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Achieved_Goal()));
                              },
                            ),
                            // 취소
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    //모서리를 둥글게
                                    borderRadius: BorderRadius.circular(16)),
                                primary: Color(color_mint),
                                onPrimary: Colors.black,
                                minimumSize: Size(
                                    getMobileSizeFromPercent(context, 30, true),
                                    40),
                                shadowColor: Colors.transparent,
                                elevation: 0,
                              ),
                              child: Text(
                                "뒤로가기",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),
                    ]))),
      );
}

// 날짜 요일 반환
String getDayOfWeek(String yearmonthday) {
  int year = int.parse(yearmonthday.substring(0, 4));
  int month = int.parse(yearmonthday.substring(4, 6));
  int day = int.parse(yearmonthday.substring(6, 8));

  // 날수
  int allDay = 0;

  // 전년도까지 날수 더함
  allDay += (year - 1) * 365 +
      (year - 1) ~/ 4 -
      (year - 1) ~/ 100 +
      (year - 1) ~/ 400;

  // 이번달 직전까지 더함
  List<int> monthDayList = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  for (int i = 0; i < month - 1; i++) {
    allDay += monthDayList[i];
  }

  // 올해가 윤년이면 1 더함
  if (month > 2 && (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))) {
    allDay += 1;
  }

  // 오늘 날짜까지 더함
  allDay += day;

  int dayOfWeek = allDay % 7;

  switch (dayOfWeek) {
    case 0:
      return "일";
    case 1:
      return "월";
    case 2:
      return "화";
    case 3:
      return "수";
    case 4:
      return "목";
    case 5:
      return "금";
    case 6:
      return "토";
    default:
      return "에러";
  }
}

// 월 몇일까지 있나 반환
int getMaxDay(String yearmonth) {
  int year = int.parse(yearmonth.substring(0, 4));
  int month = int.parse(yearmonth.substring(4, 6));
  int maxDay = 0;

  List<int> monthDayList = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  maxDay = monthDayList[month - 1];

  // 윤년이면 + 1
  if (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
    maxDay += 1;
  }

  return maxDay;
}

class DailyObj {
  int id = 0;
  String date = "";
  String status = "";
  String week = "";

  DailyObj(int id, String date, String status) {
    this.id = id;
    this.date = date;
    this.status = status;
    week = getDayOfWeek(date);
  }
}
