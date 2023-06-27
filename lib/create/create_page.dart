import 'dart:io';

import 'package:flutter/material.dart';

import 'create_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final model = CreateModel();

  /// ? : 초기 null을 허용한다.
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새 게시물'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        /// 사진이 영역 밖으로 넘어가면 추가
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: '제목을 입력하세요',
                  fillColor: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  _image = await model.getImage();

                  /// 화면 갱신, setState에서는 async ~ await 안됨
                  setState(() {});
                },
                child: const Text('이미지 선택'),
              ),

              /// 이미지 피커에서 받은 사진 표시
              /// {} 사용 못함, 1줄 코드 가능
              if (_image != null)
                Image.file(
                  _image!,
                  width: 300,
                )
            ],
          ),
        ),
      ),
    );
  }
}
