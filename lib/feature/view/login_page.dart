import 'dart:convert';
import 'package:emr_application/core/services/api_servicce.dart';
import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/custom_widgets/custom_text_form_field.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/core/custom_widgets/shared_preference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController patientIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Future<void> login(String userId, String password) async {
  //   final apiService = ApiServicce();
  //   final response = await apiService.login(userId, password);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final patientDetails = data["patient_details"];
  //     // Save full patient data
  //     await SharedPreferencesHelper.savePatientDetails(patientDetails);
  //     //save login state
  //     await SharedPreferencesHelper.saveLoginState(userId);
  //     if (!mounted) return;
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Welcome ${patientDetails["name"]}')),
  //     );
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Invalid username or password')),
  //     );
  //   }
  // }
  
  Future<void> login(String userId, String password) async {
    if (_formKey.currentState!.validate()) {
      if (userId == 'user' && password == '123456') {
        await SharedPreferencesHelper.saveLoginState(userId);
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    }

    if (mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CustomText(
                      text: 'Sign In',
                      size: 22,
                      weight: FontWeight.bold,
                      color: AppColors.navy,
                    ),
                  ),
                  30.height,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          label: 'Patient ID',
                          labelWeight: FontWeight.bold,
                          hintText: 'Enter your Patient ID',
                          controller: patientIdController,
                          textColor: AppColors.black,
                          labelColor: AppColors.black,
                        ),
                        16.height,
                        CustomTextFormField(
                          label: 'Password',
                          labelWeight: FontWeight.bold,
                          hintText: 'Enter your password',
                          controller: passwordController,
                          obscureText: true,
                          textColor: AppColors.black,
                          labelColor: AppColors.black,
                        ),
                        8.height,
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: const CustomText(
                              text: 'Forgot Password?',
                              size: 13,
                              color: AppColors.primary,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  40.height,
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        login(
                            patientIdController.text, passwordController.text);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: 348,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                AppAssets.iconlogin,
                                width: 348,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
