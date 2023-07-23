import 'package:flutter/material.dart';

class LoveNumber extends StatefulWidget {
  LoveNumber({Key? key}) : super(key: key);

  @override
  _LoveFortuneScreenState createState() => _LoveFortuneScreenState();
}

class _LoveFortuneScreenState extends State<LoveNumber> {
  TextEditingController nameController1 = TextEditingController();
  TextEditingController nameController2 = TextEditingController();
  String loveFortuneResult = '';

  @override
  void dispose() {
    nameController1.dispose();
    nameController2.dispose();
    super.dispose();
  }

  void calculateLoveFortune() {
    String name1 = nameController1.text.trim().toUpperCase();
    String name2 = nameController2.text.trim().toUpperCase();

    if (name1.isNotEmpty && name2.isNotEmpty) {
      int sum = calculateNameSum(name1) + calculateNameSum(name2);
      while (sum > 9) {
        sum = calculateDigitSum(sum);
      }

      String description = '';
      switch (sum) {
        case 1:
          description =
          'Hai người chính là những người bạn đời tri kỷ của nhau. Dù không dùng đến lời nói, hai bạn vẫn có thể hiểu được tâm tư của đối phương. Mối tình của hai người ngọt ngào, mặn nồng khiến mọi người xung quanh phải ngưỡng mộ.';
          break;
        case 2:
          description =
          'Mối tình của hai người dù thắm thiết nhưng sẽ gặp phải trở ngại. Dù hai người luôn muốn dành trọn cả đời ở bên đối phương nhưng họ vẫn có thể phải xa nhau vì sự phản đối của gia đình. Để bảo vệ tình yêu, cặp đôi này phải tỏ ra mạnh mẽ hơn nữa.';
          break;
        case 3:
          description =
          'Đây là cặp đôi thanh mai trúc mã, đi từ tình bạn trong sáng ngây thơ đến tình yêu vĩnh cửu. Chính vì thế, họ có thể thấu hiểu đối phương đến từng chân tơ kẽ tóc. Cặp đôi này sẽ gặp khó khăn khi phải vượt qua ranh giới giữa tình bạn và tình yêu.';
          break;
        case 4:
          description =
          'Mối lương duyên tiền định kéo dài trong nhiều kiếp. Hai người vốn dĩ đã quen biết nhau từ lâu, chỉ đến lúc này mới có dịp gặp lại. Điều này khiến cho tình cảm giữa hai người lúc nào cũng rất nồng nàn và chân thành.';
          break;
        case 5:
          description =
          'Cặp đôi này đến với nhau nhờ vào sự trùng hợp về sở thích và tình yêu chung của mình. Họ có thể cùng nhau đi qua nhiều trở ngại và đạt được những mục tiêu lớn trong cuộc sống. Để duy trì tình yêu lâu dài, hai người cần biết chia sẻ và tôn trọng ý kiến của nhau.';
          break;
        case 6:
          description =
          'Đây là một cặp đôi lý tưởng, luôn đồng lòng với nhau trong mọi tình huống. Họ sẽ cùng nhau xây dựng một gia đình viên mãn và hạnh phúc. Đôi khi, họ cần nhớ rằng không ai là hoàn hảo và biết tha thứ cho nhau khi cần thiết.';
          break;
        case 7:
          description =
          'Tình yêu của hai người chứa đựng sự trầm lặng và tâm hồn sâu thẳm. Họ cần thời gian để hiểu rõ và tìm hiểu về đối phương. Đôi khi, họ cần thể hiện tình yêu một cách rõ ràng và chia sẻ nhiều hơn để tránh những hiểu lầm không đáng có.';
          break;
        case 8:
          description =
          'Đây là một cặp đôi đầy năng lượng và quyền lực. Tình yêu của hai người mang đến sự thịnh vượng và thành công. Tuy nhiên, để duy trì tình yêu lâu dài, họ cần học cách thúc đẩy sự cân bằng giữa cuộc sống cá nhân và công việc.';
          break;
        case 9:
          description =
          'Mối tình của hai người tràn đầy tình yêu và sự hiểu biết. Họ sẽ luôn ủng hộ lẫn nhau trong mọi tình huống. Đôi khi, họ cần nhớ rằng tình yêu cũng cần sự cống hiến và hy sinh từ cả hai phía để trở thành một mối tình bền vững.';
          break;
        default:
          description = 'Không thể xác định được mức độ tình yêu của hai người.';
      }

      setState(() {
        loveFortuneResult = description;
      });
    } else {
      setState(() {
        loveFortuneResult = 'Vui lòng nhập tên của hai người!';
      });
    }
  }

  int calculateNameSum(String name) {
    int sum = 0;
    for (int i = 0; i < name.length; i++) {
      String character = name[i];
      if (character.codeUnitAt(0) >= 65 && character.codeUnitAt(0) <= 90) {
        sum += character.codeUnitAt(0) - 64;
      }
    }
    return sum;
  }

  int calculateDigitSum(int number) {
    int sum = 0;
    while (number != 0) {
      sum += number % 10;
      number ~/= 10;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Love Fortune'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nhập tên của hai người:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: nameController1,
                decoration: InputDecoration(
                  labelText: 'Tên người thứ nhất',
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: nameController2,
                decoration: InputDecoration(
                  labelText: 'Tên người thứ hai',
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: calculateLoveFortune,
                child: Text(
                  'Dự đoán tình yêu',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                loveFortuneResult,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
