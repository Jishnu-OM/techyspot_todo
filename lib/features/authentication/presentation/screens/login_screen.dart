import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:techyspot_todo/core/constants/icon_constants.dart';
import 'package:techyspot_todo/core/router/route_names.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/buttons/google_signin_button.dart';
import 'package:techyspot_todo/core/widgets/buttons/primary_button.dart';
import 'package:techyspot_todo/core/widgets/inputs/auth_textfield.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - MediaQuery.paddingOf(context).top,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.08),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(IconConstants.logo, height: 100),
                        const SizedBox(height: 14),
                        NormalText(
                          text: 'TechySpot',
                          size: 17,
                          weight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        // const SizedBox(height: 4),
                        NormalText(
                          text: 'Task management, simplified',
                          size: 12,
                          weight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),

                  NormalText(
                    text: 'Welcome back',
                    size: 22,
                    weight: FontWeight.w700,
                  ),
                  // const SizedBox(height: 8),
                  NormalText(
                    text: 'Sign in to Continue',
                    size: 13,
                    weight: FontWeight.w400,
                    color: AppColors.darkGrey,
                  ),
                  const SizedBox(height: 12),
                  AuthTextfield(
                    label: 'Email address',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  const SizedBox(height: 20),
                  AuthTextfield(
                    label: 'Password',
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {},
                      child: const NormalText(
                        text: 'Forgot password?',
                        size: 12,
                        weight: FontWeight.w400,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  PrimaryButton(text: 'Sign in', onPressed: () {
                    context.go(RouteNames.home);
                  }),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.borderColor)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: NormalText(
                          text: 'or',
                          color: AppColors.mischka,
                          size: 12,
                          weight: FontWeight.w400,
                        ),
                      ),
                      Expanded(child: Divider(color: AppColors.borderColor)),
                    ],
                  ),
                  const SizedBox(height: 28),
                  GoogleSigninButton(onPressed: () {}),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
