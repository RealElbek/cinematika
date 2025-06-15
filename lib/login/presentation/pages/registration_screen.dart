import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/routes/routes.dart';
import '../../../core/themes/colors.dart';
import '../../domain/entities/user_entity.dart';
import '../manager/auth_bloc.dart';
import '../manager/auth_event.dart';
import '../manager/auth_state.dart';
import '../widgets/auth_input_field.dart';
import '../widgets/error_modal.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> _isRegisterEnabled = ValueNotifier<bool>(false);
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _isRegisterEnabled.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    _isRegisterEnabled.value = _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _handleRegistration() {
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) => ErrorModal(
          errorMessage: 'Passwords do not match',
          onPressed: () => Navigator.pop(context),
          svgAssetPath: 'assets/icons/error_icon.svg',
        ),
      );
      return;
    }

    final user = UserEntity(
      email: _emailController.text,
      password: _passwordController.text,
    );
    context.read<AuthBloc>().add(RegisterUserEvent(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon:  SvgPicture.asset(
            'assets/icons/exit.svg',
            width: 24,
            height: 24,
            color: Color(0xFF2AB156),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Registration',
          style: TextStyle(
            color: Color(0xFF2AB156),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.main);
          } else if (state is AuthError && !state.message.contains('successfully')) {
            showDialog(
              context: context,
              builder: (context) => ErrorModal(
                errorMessage: state.message,
                onPressed: () => Navigator.pop(context),
                svgAssetPath: 'assets/icons/error_icon.svg',
              ),
            );
          }
        },
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AuthInputField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                title: 'Email',
                hintText: 'Enter your email',
                hasCursor: _emailFocusNode.hasFocus,
                topMargin: 32,
              ),
              AuthInputField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                title: 'Password',
                hintText: 'Enter your password',
                hasCursor: _passwordFocusNode.hasFocus,
                isPassword: true,
                isPasswordVisible: _isPasswordVisible,
                onToggleVisibility: _togglePasswordVisibility,
                topMargin: 16,
              ),
              AuthInputField(
                controller: _confirmPasswordController,
                focusNode: _confirmPasswordFocusNode,
                title: 'Confirm Password',
                hintText: 'Confirm your password',
                hasCursor: _confirmPasswordFocusNode.hasFocus,
                isPassword: true,
                isPasswordVisible: _isConfirmPasswordVisible,
                onToggleVisibility: _toggleConfirmPasswordVisibility,
                topMargin: 16,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'By registering you agree to the ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'terms of use',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return Column(
                      children: [
                        Visibility(
                          visible: !isLoading,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _isRegisterEnabled,
                            builder: (context, isEnabled, _) {
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: isEnabled ? _handleRegistration : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    disabledBackgroundColor: const Color(0x802BB157),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}