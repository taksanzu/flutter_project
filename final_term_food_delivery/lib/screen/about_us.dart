import 'package:flutter/material.dart';

import 'home_page.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Về Chúng Tôi'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
             Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return HomePage();
            }));
          },
        )
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('images/logo.png'), // Thay đổi đường dẫn hình ảnh của TakFood
            ),
            SizedBox(height: 20),
            Text(
              'Chào mừng bạn đến với TakFood',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Chúng tôi là một nhà hàng hiện đại và ấm cúng, cung cấp nhiều món ăn ngon và bổ dưỡng. Sứ mệnh của chúng tôi là mang đến trải nghiệm ẩm thực đáng nhớ cho khách hàng với dịch vụ tận tâm và nguyên liệu chất lượng cao. Tại TakFood, chúng tôi tin rằng mỗi bữa ăn là một hành trình đáng nhớ.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Liên Hệ:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Địa chỉ: 123 Đường Chính, Thành phố, Quốc gia',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Điện thoại: (123) 456-7890',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Email: info@takfood.com',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
