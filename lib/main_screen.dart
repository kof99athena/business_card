import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //Text를 입력받을 때 필요한 컨트롤러
  TextEditingController introduceController = TextEditingController();

  //자기소개 수정 모드
  bool isEditMode = false;
  
  @override
  void initState() {
    super.initState();
    getIntroduceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.accessibility_new,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '네이티브 개발자 안혜영입니다.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              height: 250,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/img_profile.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //정보 입력
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '이름',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '안혜영',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '나이',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '100',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '직업',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    '안드로이드 개발자',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      '학교',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'cat school',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    child: Text(
                      'MBTI',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'AAAA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            //자기소개 입력 필드
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 16,
                    top: 16,
                  ),
                  child: Text(
                    '자기소개 입력',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                      margin: EdgeInsets.only(right: 16, top: 16),
                      child: Icon(
                        Icons.mode_edit,
                        color: isEditMode == true ? Colors.blueAccent : Colors.black,
                        size: 24,
                      )),
                  onTap: () async {
                    if (isEditMode == false) {
                      setState(() {
                        //위젯을 업데이트한다.
                        isEditMode = true;
                      });
                    } else {
                      if (introduceController.text.isEmpty) {
                        var snackBar = SnackBar(content: Text('자기소개 입력값이 비어있습니다.'), duration: Duration(seconds: 2),);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                        //입력필드값이 비어있으면 하단의 로직을 수행하지않고 여기서 메소드 종료이다.
                      }

                      //실제 저장하는 로직을 이곳에서 구현해야한다. sharedPreference
                      var sharedPref = await SharedPreferences.getInstance();
                      sharedPref.setString('introduce', introduceController.text);
                      //문자열 저장해줌 키/밸류

                      setState(() {
                        //위젯을 업데이트한다.
                        isEditMode = false;
                      });
                    }
                  },
                )
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TextField(
                  maxLines: 5,
                  controller: introduceController,
                  enabled: isEditMode, //false로 두면 수정불가하다
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Color(0xffd9d9d9),
                          ))),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> getIntroduceData() async {
    //기존에 저장된 자기소개 데이터가 있다면 로드해오기!
    var sharedPref = await SharedPreferences.getInstance();
    String introduceMsg = sharedPref.getString('introduce').toString();
    introduceController.text = introduceMsg ?? "";
  }
}



