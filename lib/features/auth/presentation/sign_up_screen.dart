import 'package:cnc_prac/core/common_widget_helper/common_button.dart';
import 'package:cnc_prac/core/common_widget_helper/common_snackbr.dart';
import 'package:cnc_prac/features/auth/bloc/auth_cubit.dart';
import 'package:cnc_prac/features/auth/bloc/auth_state.dart';
import 'package:cnc_prac/features/auth/presentation/auth_widget_helper/textfiled.dart';
import 'package:cnc_prac/features/task_screen/presentation/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  TextEditingController fullNameCtr = TextEditingController();
  FocusNode fullNameNode = FocusNode();
  TextEditingController conPassCtr = TextEditingController();
  FocusNode conPassNode = FocusNode();
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
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15),
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
                          "Full Name",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextfiledHelper(
                          ctr: fullNameCtr,
                          dividerIsVisible: false,
                          focusNode: fullNameNode,
                          keyboardType: TextInputType.name,
                          icon: Icons.person_outline_outlined,
                          onChange: (val) {},
                          hintText: "Enter your full name",
                        ),
                        SizedBox(height: 15),
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
                          dividerIsVisible: false,
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
                          dividerIsVisible: false,
                          keyboardType: TextInputType.text,
                          hintText: "Enter your password",
                          obscureText: state.obsecure,
                          suffixIcon: state.obsecure
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          onChange: (val) {},
                          onSuffixTap: () {
                            context.read<AuthCubit>().passObsecure();
                          },
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextfiledHelper(
                          ctr: conPassCtr,
                          focusNode: conPassNode,
                          icon: Icons.lock_outline,
                          dividerIsVisible: false,
                          keyboardType: TextInputType.text,
                          hintText: "Confirm your password",
                          obscureText: state.conPassObsecure,
                          suffixIcon: state.conPassObsecure
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          onChange: (val) {},
                          onSuffixTap: () {
                            context.read<AuthCubit>().conPassObsecure();
                          },
                        ),

                        SizedBox(height: 30),
                        state.loading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [CircularProgressIndicator()],
                              )
                            : CommonButtonWidget(
                                buttonString: "Register",
                                onTap: () {
                                  if (fullNameCtr.text.trim().isEmpty) {
                                    snackBar(
                                      context: context,
                                      error: "Full name is not be empty",
                                    );
                                  } else if (emailCtl.text.trim().isEmpty) {
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
                                  } else if (conPassCtr.text.trim().isEmpty) {
                                    snackBar(
                                      context: context,
                                      error: "Confirm password is not be empty",
                                    );
                                  } else if (conPassCtr.text.trim() !=
                                      passCtl.text.trim()) {
                                    snackBar(
                                      context: context,
                                      error: "Password is missmatch",
                                    );
                                  } else {
                                    context.read<AuthCubit>().signUp(
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
                              "Already have an account? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Log In",
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
