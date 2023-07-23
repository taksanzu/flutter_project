import 'package:flutter/material.dart';

class LovePercent extends StatefulWidget {
  LovePercent({Key? key}) : super(key: key);

  @override
  _LovePercentState createState() => _LovePercentState();
}

class _LovePercentState extends State<LovePercent> {
  TextEditingController name1Controller = TextEditingController();
  TextEditingController name2Controller = TextEditingController();
  String result = '';
  String interpretation = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Love Percentage Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: name1Controller,
              decoration: InputDecoration(
                labelText: 'Nhập tên thứ nhất',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: name2Controller,
              decoration: InputDecoration(
                labelText: 'Nhập tên thứ 2',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateLovePercentage,
              child: Text('Calculate'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Love Percentage: $result%',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Kết quả bói:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              interpretation,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  void calculateLovePercentage() {
    String name1 = normalizeString(name1Controller.text);
    String name2 = normalizeString(name2Controller.text);

    List<String> characters = ['L', 'O', 'V', 'E', 'S'];
    Map<String, int> charCount = {};

    for (String character in characters) {
      charCount[character] = 0;
    }

    for (int i = 0; i < name1.length; i++) {
      String character = name1[i];
      if (characters.contains(character)) {
        if (charCount.containsKey(character)) {
          charCount[character] = charCount[character]! + 1;
        }
      }
    }

    for (int i = 0; i < name2.length; i++) {
      String character = name2[i];
      if (characters.contains(character)) {
        if (charCount.containsKey(character)) {
          charCount[character] = charCount[character]! + 1;
        }
      }
    }

    List<int> countList = charCount.values.toList();
    String numberSequence = countList.join('');

    int lovePercentage = calculatePercentage(numberSequence);
    setState(() {
      result = lovePercentage.toString();
      interpretation = getInterpretation(lovePercentage);
    });
  }

  int calculatePercentage(String numberSequence) {
    int lovePercentage = int.tryParse(numberSequence) ?? 0;

    while (lovePercentage >= 100) {
      String newNumberSequence = '';
      if (numberSequence.length > 1) {
        for (int i = 0; i < numberSequence.length - 1; i++) {
          int digit = int.tryParse(numberSequence[i]) ?? 0;
          int nextDigit =
              int.tryParse(numberSequence[i + 1]?.toString() ?? '0') ?? 0;
          int sum = digit + nextDigit;
          newNumberSequence += sum.toString();
        }
      }
      numberSequence = newNumberSequence;
      lovePercentage = int.tryParse(numberSequence) ?? 0;
    }
    return lovePercentage;
  }

  String getInterpretation(int lovePercentage) {
    if (lovePercentage < 50) {
      return "Dưới 50%: Hai người không quá hòa hợp với nhau. Hãy cố gắng tìm cơ hội để thấu hiểu đối phương.";
    } else if (lovePercentage >= 50 && lovePercentage < 80) {
      return "Từ 50% - 79%: Sự phù hợp giữa hai người ở mức tương đối. Chuyện tình cảm có thể tiến triển xa hơn nữa.";
    } else {
      return "Từ 80% - 100%: Hai người sinh ra là để dành cho nhau. Mối tình rất bền chặt và sẽ kéo dài đến suốt đời.";
    }
  }

  String normalizeString(String input) {
    var normalizedInput = input.trim().toUpperCase();
    normalizedInput = normalizedInput.replaceAll(RegExp(r'\s+'), '');
    normalizedInput = normalizedInput.replaceAllMapped(
      RegExp(r'[ÁÀẢÃẠĂẮẰẲẴẶẤẦẨẪẬẢẠÁÀÃ]'),
          (match) => 'A',
    );
    normalizedInput = normalizedInput.replaceAllMapped(
      RegExp(r'[ÉÈẺẼẸÊẾỀỂỄỆÉÈẺẼẸ]'),
          (match) => 'E',
    );
    normalizedInput = normalizedInput.replaceAllMapped(
      RegExp(r'[ÍÌỈĨỊÍÌỈĨỊ]'),
          (match) => 'I',
    );
    normalizedInput = normalizedInput.replaceAllMapped(
      RegExp(r'[ÓÒỎÕỌÔỐỒỔỖỘỚỜỞỠỢƠỚỜỞỠỢ]'),
          (match) => 'O',
    );
    normalizedInput = normalizedInput.replaceAllMapped(
      RegExp(r'[ÚÙỦŨỤƯỨỪỬỮỰÚÙỦŨỤƯỨỪỬỮỰ]'),
          (match) => 'U',
    );
    normalizedInput = normalizedInput.replaceAllMapped(
      RegExp(r'[ÝỲỶỸỴỲ]'),
          (match) => 'Y',
    );
    return normalizedInput;
  }
}
