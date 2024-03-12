import 'package:flutter/material.dart';
import 'package:project_mobile/components/buttons/app_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_icon_buttom_component.dart';
import 'package:project_mobile/components/buttons/app_text_buttom_component.dart';
import 'package:project_mobile/components/checkbox/app_checkbox_component.dart';
import 'package:project_mobile/components/textfields/app_textfield_component.dart';
import 'package:project_mobile/data/masks/app_masks.dart';
import 'package:project_mobile/settings/app_assets.dart';
import 'package:project_mobile/settings/app_colors.dart';
import 'package:project_mobile/settings/app_fonts.dart';
import 'package:project_mobile/settings/app_routes.dart';

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
  bool loadingLogin = false;

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
                    height: contrains.maxHeight*2/7,
                    alignment: Alignment.center,
                    child: Container(
                      height: contrains.maxHeight*1/7,
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Login", style: AppFonts.title.copyWith(color: AppColors.textWhiteColor),),
                            const SizedBox(height: 5,),
                            Text("Faça login na sua conta existente", style: AppFonts.subTitle.copyWith(color: AppColors.textWhiteColor,), textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context)  =>  Container(
                    height: contrains.maxHeight*5/7,
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextFieldComponent(
                            label: 'email',
                            controller: _emailController,
                            individualKey: _emailFormkey,
                            hint: 'exemplo@email.com',
                            onEdit: (_) => _emailFormkey.currentState!.validate(),
                            validator: (_) {
                              if(_emailController.text.isEmpty){
                                return 'Campo obrigatório';
                              }else if(!AppMasks.regex.hasMatch(_emailController.text)){
                                return 'E-mail inválido';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20,),

                          AppTextFieldComponent(
                            label: 'senha',
                            controller: _passwordController,
                            individualKey: _passwordFormkey,
                            suffixIcon: visibleText ? AppAssets.visibilityOffIcon : AppAssets.visibilityOnIcon,
                            suffixIconOnTap: () => setState(() => visibleText = !visibleText),
                            obscureText: visibleText,
                            onEdit: (_) => _passwordFormkey.currentState!.validate(),
                            validator: (_) {
                              if(_passwordController.text.isEmpty){
                                return 'Campo obrigatório';
                              }
                              return null;
                            },
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
                                function: () => Navigator.of(context).pushNamed(AppRoutes.esqueciSenha),
                              )
                            ],
                          ),

                          const SizedBox(height: 20,),

                          AppButtomComponent(
                            onPressed: () => _login(Tipologin.email),
                            text: 'Login',
                            loading: loadingLogin,
                          ),

                          const SizedBox(height: 40,),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Ainda não tem uma conta? ", style: AppFonts.subTitle2.copyWith(color: AppColors.textDarkGreyColor,),),
                              AppTextButtomComponent(text: "Registre-se", function: () => Navigator.of(context).pushNamed(AppRoutes.cadastro), style: AppFonts.subTitle2.copyWith(color: AppColors.textOrangeColor, fontWeight: FontWeight.w700),)
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

  void _login(Tipologin tipologin) async{
    var validateEmail = _emailFormkey.currentState!.validate();
    var validatePassword = _passwordFormkey.currentState!.validate();

    if(validateEmail && validatePassword){
      //TODO: Implementar login
      setState(() => loadingLogin = true);
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        setState(() => loadingLogin = false);
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      });
    }
  }
}
