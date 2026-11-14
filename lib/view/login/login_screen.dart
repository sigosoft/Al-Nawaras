import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/login_controller.dart';
import '../../generated/l10n.dart';
// import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        alignment: AlignmentDirectional.centerStart,
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: const Color(0xFF001133),
                          size: 24,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      Center(
                        child: SizedBox(
                          height: height * 0.1,
                          child: Image.asset(
                            'lib/assets/images/Welcome.png',
                            errorBuilder: (context, error, stackTrace) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.flight_takeoff,
                                  size: 50,
                                  color: Color(0xFF0D1B2A),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "ANET",
                                  style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE30613),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.001),
                      Center(
                        child: Text(
                          S.of(context).alNawaras,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF001133),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.002),
                      Center(
                        child: Text(
                          S.of(context).premiumParkingSolutions,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 103, 111, 128),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.03),
                      Center(
                        child: Text(
                          S.of(context).welcomeBack,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF001133),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Center(
                        child: Text(
                          S.of(context).signInToYourAccount,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF001133),
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      Text(
                        S.of(context).emailOrMobile,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      SizedBox(
                        height: height * 0.06,
                        child: TextField(
                          controller: controller.emailOrMobileController,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: S.of(context).enterEmailOrMobile,
                            hintStyle: const TextStyle(
                              color: Colors.black38,
                              fontSize: 13,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE30613),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Text(
                        S.of(context).password,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      SizedBox(
                        height: height * 0.06,
                        child: TextField(
                          controller: controller.passwordController,
                          obscureText: controller.isPasswordObscured,
                          style: const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: S.of(context).enterPassword,
                            hintStyle: const TextStyle(
                              color: Colors.black38,
                              fontSize: 13,
                            ),
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
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Color(0xFFE30613),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: controller.forgotPassword,
                            child: Text(
                              S.of(context).forgotPassword,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFFE30613),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 15,
                            width: 15,
                            child: Checkbox(
                              value: controller.isRememberMe,
                              onChanged: (value) =>
                                  controller.toggleRememberMe(),
                              side: const BorderSide(
                                color: Colors.black38,
                                width: 1,
                              ),
                              activeColor: const Color(0xFFE30613),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            S.of(context).rememberMe,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      ElevatedButton(
                        onPressed: () =>
                            controller.isLoading ? null : controller.signIn(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE30613),
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
                                S.of(context).signIn,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(color: Colors.black26, thickness: 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              S.of(context).orSignInWith,
                              style: TextStyle(
                                fontSize: 13,
                                color: const Color(0xFF001133).withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                          const Expanded(
                            child: Divider(color: Colors.black26, thickness: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        children: [
                          _buildSocialButton(
                            child: Image.asset(
                              'lib/assets/images/google.png',
                              height: 30,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.g_mobiledata,
                                    size: 35,
                                    color: Colors.red,
                                  ),
                            ),
                            onTap:controller.googleLogin,
                            height: height,
                          ),
                          _buildSocialButton(
                            child: Image.asset(
                              'lib/assets/images/facebook.png',
                              height: 36,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.facebook,
                                    size: 28,
                                    color: Colors.blue,
                                  ),
                            ),
                            onTap: controller.signInWithFacebook,
                            height: height,
                          ),
                          _buildSocialButton(
                            child: Image.asset(
                              'lib/assets/images/twitter.png',
                              height: 30,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.close,
                                    size: 26,
                                    color: Colors.black,
                                  ),
                            ),
                            onTap: controller.signInWithX,
                            height: height,
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).dontHaveAccount,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF001133),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: controller.goToRegister,
                            child: Text(
                              S.of(context).signUp,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFFE30613),
                                fontWeight: FontWeight.bold,
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

  Widget _buildSocialButton({
    required Widget child,
    required VoidCallback onTap,
    required double height,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height * 0.08,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
