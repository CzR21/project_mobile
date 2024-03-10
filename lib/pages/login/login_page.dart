import 'package:flutter/material.dart';
import 'package:project_mobile/components/buttons/app_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_icon_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_text_buttom_component.dart';
import 'package:project_mobile/components/checkbox/app_checkbox_component.dart';
import 'package:project_mobile/components/textfields/app_textfield_component.dart';
import 'package:project_mobile/settings/app_assets.dart';
import 'package:project_mobile/settings/app_colors.dart';
import 'package:project_mobile/settings/app_fonts.dart';

enum Tipologin{ email, google, facebook, twitter }

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _emailFormkey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormkey = GlobalKey<FormState>();

  bool visibleText = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDarkColor,
      body: LayoutBuilder(
        builder: (context, contrains) {
          return SizedBox(
            height: contrains.maxHeight,
            child: Column(
              children: [
                Builder(
                  builder: (context)  =>  Container(
                    width: double.infinity,
                    height: contrains.maxHeight/4,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Login", style: AppFonts.title.copyWith(color: AppColors.textWhiteColor),),
                        const SizedBox(height: 5,),
                        Text("Faça login na sua conta existente", style: AppFonts.subTitle.copyWith(color: AppColors.textWhiteColor,), textAlign: TextAlign.center,),
                      ],
                    ),
                  )
                ),
                Builder(
                  builder: (context)  =>  Container(
                    height: contrains.maxHeight*3/4,
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        AppTextFieldComponent(
                          label: 'email',
                          controller: _emailController,
                          individualKey: _emailFormkey,
                          hint: 'exemplo@email.com',
                        ),

                        const SizedBox(height: 20,),

                        AppTextFieldComponent(
                          label: 'senha',
                          controller: _passwordController,
                          individualKey: _passwordFormkey,
                          suffixIcon: visibleText ? AppAssets.visibilityOffIcon : AppAssets.visibilityOnIcon,
                          suffixIconOnTap: () => setState(() => visibleText = !visibleText),
                          obscureText: visibleText,
                        ),

                        const SizedBox(height: 20,),

                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppCheckBoxComponent(
                              value: rememberMe,
                              function: () => setState(() => rememberMe = !rememberMe),
                              child: Text("Manter conectado", style: AppFonts.regularDefault.copyWith(color: AppColors.textDarkGreyColor,),),
                            ),
                            AppTextButtomComponent(
                              text: 'Esqueci a senha',
                              function: (){},
                            )
                          ],
                        ),

                        const SizedBox(height: 20,),

                        AppButtomComponent(
                          onPressed: () => _login(Tipologin.email),
                          text: 'Login'
                        ),

                        const SizedBox(height: 40,),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Ainda não tem uma conta? ", style: AppFonts.subTitle2.copyWith(color: AppColors.textDarkGreyColor,),),
                            AppTextButtomComponent(text: "Registre-se", function: (){}, style: AppFonts.subTitle2.copyWith(color: AppColors.textOrangeColor, fontWeight: FontWeight.w700),)
                          ],
                        ),

                        const SizedBox(height: 20,),

                        Text("Ou", style: AppFonts.subTitle2.copyWith(color: AppColors.textDarkGreyColor,),),

                        const SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppIconButtomComponent(
                              icon: AppAssets.googleIcon,
                              backgroundColor: AppColors.googleColor,
                              color: AppColors.textWhiteColor,
                              function: () => _login(Tipologin.google),
                              width: 60,
                              iconWidth: 25,
                            ),
                            AppIconButtomComponent(
                              icon: AppAssets.facebookIcon,
                              backgroundColor: AppColors.facebookColor,
                              color: AppColors.textWhiteColor,
                              function: () => _login(Tipologin.google),
                              width: 60,
                              iconWidth: 20,
                            ),
                            AppIconButtomComponent(
                              icon: AppAssets.twitterIcon,
                              color: AppColors.textWhiteColor,
                              backgroundColor: AppColors.twitterColor,
                              function: () => _login(Tipologin.google),
                              width: 60,
                              iconWidth: 20,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  void _login(Tipologin tipologin){
    //TODO: implementar login ainda


  }
}
