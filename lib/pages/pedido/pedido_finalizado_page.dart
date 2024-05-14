import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/components/buttons/app_buttom_component.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';

import '../../config/app_fonts.dart';

class PedidoFinalizadoPage extends StatefulWidget {

  const PedidoFinalizadoPage({Key? key}) : super(key: key);

  @override
  State<PedidoFinalizadoPage> createState() => _PedidoFinalizadoPageState();
}

class _PedidoFinalizadoPageState extends State<PedidoFinalizadoPage> with SingleTickerProviderStateMixin {

  bool loading = true;

  double _progress = 0.0;
  Timer? _timer;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _setAnimation();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_progress >= 1) {
        setState(() => loading = false);
        timer.cancel();
      } else {
        setState(() => _progress += 0.2);
      }
    });
  }

  void _setAnimation(){
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() => setState(() {}));

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(loading ? "Finalizando pedido..." : "Pedido realizado com sucesso!!!", style: AppFonts.title.copyWith(color: AppColors.darkColor), textAlign: TextAlign.center,),
              const SizedBox(height: 30,),
              loading ? LinearProgressIndicator(
                minHeight: 40,
                color: AppColors.orangeDarkColor,
                backgroundColor: AppColors.orangeLiteColor,
                borderRadius: BorderRadius.circular(50),
                value: _animation.value,
              ) : SvgPicture.asset(AppAssets.pedidoConcluidoImage, width: 100,),
              const SizedBox(height: 30,),
              Text(loading ? "Enviando seu pedido para o restaurante" : "Logo logo o restaurante começará a preparar seu pedido.", style: AppFonts.subTitle2.copyWith(color: AppColors.darkColor), textAlign: TextAlign.center),
              const SizedBox(height: 30,),
              Visibility(
                visible: !loading,
                child: AppButtomComponent(
                  onPressed: () => Navigator.of(context).popUntil((route) => route.settings.name == '/home'),
                  text: "Voltar para home"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
