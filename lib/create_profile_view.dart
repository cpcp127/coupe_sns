import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({super.key});

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.close)),
        leadingWidth: 56,
        title: Text('프로필 작성'),
        centerTitle: true,
      ),
      body: Column(

      ),
    );
  }
}
