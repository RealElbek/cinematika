import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/routes/routes.dart';
import '../../../core/themes/colors.dart';
import '../../domain/entities/user_entity.dart';
import '../manager/auth_bloc.dart';
import '../manager/auth_event.dart';
import '../manager/auth_state.dart';
import '../widgets/error_modal.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isLoginEnabled = ValueNotifier<bool>(false);
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _isLoginEnabled.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    _isLoginEnabled.value =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _handleLogin() {
    final user = UserEntity(
      email: _emailController.text,
      password: _passwordController.text,
    );
    context.read<AuthBloc>().add(LoginUserEvent(user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.main);
          } else if (state is AuthError) {
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
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child:  SvgPicture.asset(
                        'assets/icons/exit.svg',
                        width: 24,
                        height: 24,
                        color: Color(0xFF2AB156),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xFF2AB156),
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              _buildInputField(
                controller: _emailController,
                focusNode: _emailFocusNode,
                title: 'Email',
                hintText: 'Enter your email',
                topMargin: 32,
                hasCursor: _emailFocusNode.hasFocus,
              ),
              _buildInputField(
                controller: _passwordController,
                focusNode: _passwordFocusNode,
                title: 'Password',
                hintText: 'Enter your pass',
                topMargin: 16,
                hasCursor: _passwordFocusNode.hasFocus,
                isPassword: true,
                isPasswordVisible: _isPasswordVisible,
                onToggleVisibility: _togglePasswordVisibility,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return Column(
                      children: [
                        Visibility(
                          visible: !isLoading,
                          child: ValueListenableBuilder<bool>(
                            valueListenable: _isLoginEnabled,
                            builder: (context, isEnabled, _) {
                              return SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: isEnabled ? _handleLogin : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    disabledBackgroundColor:
                                    const Color(0x802BB157),
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Login',
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String title,
    required String hintText,
    required double topMargin,
    required bool hasCursor,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: topMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0x1E8E8E93),
              borderRadius: BorderRadius.circular(10),
              border: hasCursor
                  ? Border.all(color: const Color(0xFF535353))
                  : null,
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      controller: controller,
                      focusNode: focusNode,
                      obscureText: isPassword && !isPasswordVisible,
                      style: const TextStyle(
                        color: Colors.white,
                        height: 1.25,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 15,
                          height: 1.25,
                        ),
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                if (hasCursor && isPassword)
                  Positioned(
                    right: 16,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: const Color(0xFF8E8E93),
                          size: 24,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: onToggleVisibility,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}