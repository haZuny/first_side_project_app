import 'package:dio/dio.dart';
import 'package:first_side_project_app/Achieved_Goal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'BaseFile.dart';
import 'dart:math';

import 'EditDaily.dart';
import 'MainPage.dart';

class AchievementRate extends StatefulWidget {
  int dailyNum = 0;

  AchievementRate(int num) {
    this.dailyNum = num;
  }

  @override
  State<AchievementRate> createState() => _AchievementRate(dailyNum);
}

class _AchievementRate extends State<AchievementRate> {
  String today = "";
  int maxDay = 0; // 해당 달에 몇일까지 있나
  int dailyNum = 0; //daily 갯수
  List<double> dayAchieve = [];

  // 0% 색깔
  int color_rate0 = 0xFFCDF0EA;

  // ~49% 색깔
  int color_rate49 = 0xFFB8E8FC;

  // ~99% 색깔
  int color_rate99 = 0xFFECC5FB;

  // 100% 색깔
  int color_rate100 = 0xFFB1AFFF;

  _AchievementRate(int num) {
    this.dailyNum = num;
  }

  // 페이지 나타날때 동작
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    today = getToday();
    maxDay = getMaxDay(today.substring(0, 6));

    // 요일에 따라 빈칸 넣어줌
    String startWeek = getDayOfWeek(today.substring(0, 6) + "01");
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
    getAchievementRate();
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
              // 헤더
              child: Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset('assets/img/icon.png'),
                            width: getMobileSizeFromPercent(context, 10, false),
                          ),
                          Text(DateTime.now().year.toString() +
                              "년 " +
                              DateTime.now().month.toString() +
                              "월 " +
                              DateTime.now().day.toString() +
                              "일 ", style: TextStyle(fontSize: logoDateFontSize),)
                        ],
                      ),
                      onTap: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MainPage()), (route) => false);
                      },
                    ),
                    Container(height: getMobileSizeFromPercent(context, 7, false),)
                  ],
                ),
              ),
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
                                    fontSize: achievementDayFontSize,
                                  ),
                                ),
                                Text(
                                  "화",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: achievementDayFontSize,
                                  ),
                                ),
                                Text(
                                  "수",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: achievementDayFontSize,
                                  ),
                                ),
                                Text(
                                  "목",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: achievementDayFontSize,
                                  ),
                                ),
                                Text(
                                  "금",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: achievementDayFontSize,
                                  ),
                                ),
                                Text(
                                  "토",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: achievementDayFontSize,
                                  ),
                                ),
                                Text(
                                  "일",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: achievementDayFontSize,
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
                                    Border.all(color: Colors.black, width: 2)),
                            // color: Colors.yellow,
                            width: getMobileSizeFromPercent(context, 80, true),
                            height:
                                ((getMobileSizeFromPercent(context, 80, true) -
                                                12) /
                                            7 +
                                        2) *
                                    (dayAchieve.length / 7).ceil() -1,
                            child: GridView.builder(
                                // 스크롤 사용 안함
                                physics: NeverScrollableScrollPhysics(),
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

                          Container(
                            height: 20,
                          ),

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
                                          Text("0 %",
                                              style: TextStyle(fontSize: achievementPercentFontSize),),
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

                                    Container(
                                      width: getMobileSizeFromPercent(
                                          context, 10, true),
                                    ),

                                    // ~49%
                                    Container(
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("~49 %",
                                              style: TextStyle(fontSize: achievementPercentFontSize)),
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
                                          Text("~99 %",
                                              style: TextStyle(fontSize: achievementPercentFontSize)),
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

                                    Container(
                                      width: getMobileSizeFromPercent(
                                          context, 10, true),
                                    ),

                                    // 100%
                                    Container(
                                      width: getMobileSizeFromPercent(
                                          context, 30, true),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("100 %",
                                              style: TextStyle(fontSize: achievementPercentFontSize)),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              //모서리를 둥글게
                              borderRadius: BorderRadius.circular(16)),
                          primary: Color(color_mint),
                          onPrimary: Colors.black,
                          minimumSize: Size(
                              getMobileSizeFromPercent(context, 50, true),
                              getMobileSizeFromPercent(context, 6, false)),
                          shadowColor: Colors.transparent,
                          elevation: 0,
                        ),
                        child: Text(
                          "뒤로가기",
                          style: TextStyle(fontSize: btnTitleFontSize),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ]))),
      );

  /// 정보 받아옴
  Future<int> getAchievementRate() async {
    String getARPURI = hostURI +
        'api/users/calender/' +
        DateTime.now().year.toString() +
        "-" +
        getToday().substring(4, 6);

    Dio dio = Dio();
    dio.options.headers['jwt-auth-token'] = token;
    dio.options.headers['jwt-auth-refresh-token'] = refreshToken;
    try {
      var res = await dio.get(getARPURI);
      for (int i = 1; i < maxDay + 1; i++) {
        String day = i < 10 ? '0' + i.toString() : i.toString();
        int cnt = 0;
        for (String keyDay in res.data['calenderResponseList'].keys.toList()) {
          if (keyDay.substring(8, 10) == day) {
            cnt += res.data['calenderResponseList'][keyDay].length as int;
          }
        }
        setState(() {
          dayAchieve.add(cnt / dailyNum * 100);
        });
      }
      print(dayAchieve);

      print("====================");
      print("sucess getAchievementRate");
      return 0;
    } catch (e) {
      print("====================");
      print("getAchievementRate Err");
      Fluttertoast.showToast(
          msg:
          "정보를 받아오지 못했습니다.");
    }
    return -1;
  }
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
