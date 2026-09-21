import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../controller/register_controller.dart';
import '../../generated/l10n.dart';
import '../widgets/custom_app_bar.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(
            0xFFF7F7F7,
          ), // Extremely light grey to match the image matching inputs
          appBar: CustomAppBar(title: S.of(context).createAccount),
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          S.of(context).provideDetailsToRegister,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),

                      _buildTextField(
                        label: S.of(context).fullName,
                        hint: S.of(context).enterFullName,
                        controller: controller.fullNameController,
                        height: height,
                      ),

                      _buildTextField(
                        label: S.of(context).emailAddress,
                        hint: S.of(context).enterEmail,
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        height: height,
                      ),

                      _buildTextField(
                        label: S.of(context).mobileNumber,
                        hint: '50 XXX XXXX',
                        controller: controller.mobileController,
                        keyboardType: TextInputType.phone,
                        height: height,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[+\d]')),
                          LengthLimitingTextInputFormatter(13), // +971 + 9 digits
                        ],
                      ),

                      // _buildTextField(
                      //   label: 'Emirates ID',
                      //   hint: 'Enter your Emirates ID',
                      //   controller: controller.emiratesIdController,
                      //   height: height,
                      // ),
                      _buildTextField(
                        label: S.of(context).drivingLicense,
                        hint: S.of(context).enterDrivingLicense,
                        controller: controller.drivingLicenseController,
                        height: height,
                      ),

                      _buildTextField(
                        label: S.of(context).password,
                        hint: S.of(context).createPassword,
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordObscured,
                        height: height,
                        suffixIcon: GestureDetector(
                          onTap: controller.togglePasswordVisibility,
                          child: Icon(
                            controller.isPasswordObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),

                      _buildTextField(
                        label: S.of(context).confirmPassword,
                        hint: S.of(context).confirmYourPassword,
                        controller: controller.confirmPasswordController,
                        obscureText: controller.isConfirmPasswordObscured,
                        height: height,
                        suffixIcon: GestureDetector(
                          onTap: controller.toggleConfirmPasswordVisibility,
                          child: Icon(
                            controller.isConfirmPasswordObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.002),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Checkbox(
                              value: controller.isTermsAccepted,
                              onChanged: (value) => controller.toggleTerms(),
                              side: const BorderSide(
                                color: Colors.black38,
                                width: 1,
                              ),
                              activeColor: const Color(0xFFE30613),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            S.of(context).agreeToTerms,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: height * 0.03),

                      ElevatedButton(
                        onPressed: () => controller.isLoading
                            ? null
                            : controller.createAccount(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFE30613,
                          ), // Requested custom red color
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, height * 0.055),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: controller.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                S.of(context).createAccount,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),

                      SizedBox(height: height * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).alreadyHaveAccount,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.goToSignIn,
                            child: Text(
                              S.of(context).signIn,
                              style: const TextStyle(
                                color: Color(0xFFE30613),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
    required double height,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
          SizedBox(height: height * 0.008),
          SizedBox(
            height: height * 0.05,
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              inputFormatters: inputFormatters,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.black38, fontSize: 13),
                suffixIcon: suffixIcon,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFE30613)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
