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
  final _titleTextController = TextEditingController();

  /// ? : 초기 null을 허용한다.
  File? _image;

  bool isLoading = false;

  @override
  void dispose() {
    _titleTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('새 게시물'),
        actions: [
          IconButton(
            onPressed: () async {
              // 이미지 피커 실행
              if (_image != null && _titleTextController.text.isNotEmpty) {
                setState(() {
                  isLoading = true;
                });

                /// 업로드
                await model.uploadPost(
                  _titleTextController.text,
                  _image!,
                );

                setState(() {
                  isLoading = false;
                });

                /// 화면이 살아있다면 업로드가 끝나고 뒤로 이동
                /// async ~ await 코드에서 사용
                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
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
                controller: _titleTextController,
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
              if (isLoading) const CircularProgressIndicator(),
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
