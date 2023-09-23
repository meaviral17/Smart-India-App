import 'package:chatbot/pages/home/homeStartPage.dart';
import 'package:chatbot/utils/textUtil.dart';
import 'package:flutter/material.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _phoneNumberController = TextEditingController();

  String? get _errorText {
    final value = _phoneNumberController.value.text;
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (value.length != 10) {
      return 'Phone number must be 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number should only contain numbers';
    }
    // return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              txt(
                "Complete your profile",
                weight: FontWeight.w600,
                size: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              txt(
                "Please enter your details to complete your profile don't",
                color: Colors.grey.shade400,
              ),
              txt(
                "worry your details are private.",
                color: Colors.grey.shade400,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(
                  children: [
                    Image.asset("assets/vectorImages/avatar.png"),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Color(0xFF3A3A3A),
                        minRadius: 15,
                        maxRadius: 15,
                        child: Icon(
                          Icons.edit,
                          size: 16,
                          color: Color(0xFF17C3CE),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFF17C3CE)), // Change the underline color when not focused
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Change the border color on focus
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                cursorColor: Colors.black,
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  errorText: _errorText,
                  suffixIcon: Icon(
                    Icons.call_outlined,
                    color: Colors.grey,
                  ),
                  labelText: 'Phone Number',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFF17C3CE)), // Change the underline color when not focused
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Change the border color on focus
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 30,
              ),
              const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF17C3CE),
                  ),
                  labelText: 'Gender',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFF17C3CE)), // Change the underline color when not focused
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Change the border color on focus
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF17C3CE),
                  ),
                  labelText: 'Organisation',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFF17C3CE)), // Change the underline color when not focused
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Change the border color on focus
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  labelText: 'Access Id(contact CO if you don\'t have) ',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(
                            0xFF17C3CE)), // Change the underline color when not focused
                  ),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Change the border color on focus
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFD3FCFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 60,
                      width: 180,
                      child: Center(
                        child: txt(
                          'Skip',
                          weight: FontWeight.w400,
                          color: Color(0xFF17C3CE),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeStartPage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF17C3CE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 60,
                      width: 180,
                      child: Center(
                        child: txt(
                          'Continue',
                          // isBold: true,
                          weight: FontWeight.w400,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
