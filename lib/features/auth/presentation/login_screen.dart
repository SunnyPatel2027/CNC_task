import 'package:cnc_prac/core/common_widget_helper/common_button.dart';
import 'package:cnc_prac/core/common_widget_helper/common_snackbr.dart';
import 'package:cnc_prac/features/auth/bloc/auth_cubit.dart';
import 'package:cnc_prac/features/auth/bloc/auth_state.dart';
import 'package:cnc_prac/features/auth/presentation/auth_widget_helper/textfiled.dart';
import 'package:cnc_prac/features/auth/presentation/sign_up_screen.dart';
import 'package:cnc_prac/features/task_screen/presentation/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailCtl = TextEditingController();
  FocusNode emailNode = FocusNode();
  TextEditingController passCtl = TextEditingController();
  FocusNode passNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            width: MediaQuery.of(context).size.width,
            height:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IntrinsicWidth(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Icon(Icons.done, color: Colors.blueAccent),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Log in to manage your tasks.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state.user != null) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => TaskScreen()),
                        (route) => false,
                      );
                    }
                    if (state.error != null) {
                      snackBar(context: context, error: state.error!);
                    }
                  },
                  builder: (context, state) => SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextfiledHelper(
                          ctr: emailCtl,
                          focusNode: emailNode,
                          icon: Icons.email_outlined,
                          onChange: (val) {},
                          hintText: "Enter your email address",
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextfiledHelper(
                          ctr: passCtl,
                          focusNode: passNode,
                          icon: Icons.lock_outline,
                          hintText: "Enter your password",
                          keyboardType: TextInputType.text,
                          obscureText: state.obsecure,
                          suffixIcon: state.obsecure
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          onChange: (val) {},
                          onSuffixTap: () {
                            context.read<AuthCubit>().passObsecure();
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        state.loading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [CircularProgressIndicator()],
                              )
                            : CommonButtonWidget(
                                buttonString: "Login",
                                onTap: () {
                                  if (emailCtl.text.trim().isEmpty) {
                                    snackBar(
                                      context: context,
                                      error: "Email is not be empty",
                                    );
                                  } else if (!emailCtl.text.trim().contains(
                                    "@",
                                  )) {
                                    snackBar(
                                      context: context,
                                      error: "Email is not correct",
                                    );
                                  } else if (passCtl.text.trim().isEmpty) {
                                    snackBar(
                                      context: context,
                                      error: "Password is not be empty",
                                    );
                                  } else {
                                    context.read<AuthCubit>().login(
                                      emailCtl.text.trim(),
                                      passCtl.text.trim(),
                                    );
                                  }
                                },
                              ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
