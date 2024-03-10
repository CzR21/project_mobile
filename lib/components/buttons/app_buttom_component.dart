import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../settings/app_colors.dart';
import '../../settings/app_fonts.dart';

class AppButtomComponent extends StatefulWidget {

  final void Function() onPressed;
  final String text;
  final String? leadingIconAsset;
  final Color? primaryColor;
  final Color? textColor;
  final TextStyle? textFont;
  final bool outlined;
  final bool loading;
  final bool leadingIcon;
  final bool invertedLeadingIconPosition;
  final double? width;

  const AppButtomComponent({
    super.key,
    required this.onPressed,
    required this.text,
    this.leadingIconAsset,
    this.primaryColor,
    this.textColor,
    this.textFont,
    this.outlined = false,
    this.loading = false,
    this.leadingIcon = false,
    this.invertedLeadingIconPosition = false,
    this.width,
  });

  @override
  State<AppButtomComponent> createState() => _AppButtomComponentState();
}

class _AppButtomComponentState extends State<AppButtomComponent> {

  @override
  Widget build(BuildContext context) {

    final textColor = widget.textColor ?? (widget.outlined ? widget.primaryColor ?? AppColors.textGreyColor : AppColors.textWhiteColor);
    TextStyle textFont = widget.textFont ?? AppFonts.boldDefault;

    final loadingIcon = Center(
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          color: textColor,
          strokeWidth: 2,
        ),
      ),
    );

    return ElevatedButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        if (!widget.loading) {
          widget.onPressed.call();
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: widget.width == null ? 16 : 8,
          horizontal: 24,
        ),
        splashFactory: InkSplash.splashFactory,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          side: widget.outlined ? BorderSide(color: widget.primaryColor ?? AppColors.orangeColor,) : BorderSide.none,
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        backgroundColor: !widget.outlined ? widget.primaryColor ?? AppColors.orangeDarkColor : Colors.transparent,
        maximumSize: const Size(double.infinity, 50,),
        minimumSize: Size(widget.width ?? double.infinity, 50,),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(
              builder: (context) {
                if (widget.invertedLeadingIconPosition) {
                  if (widget.loading) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        loadingIcon,
                        const SizedBox(width: 16),
                      ],
                    );
                  }
                  if (widget.leadingIcon) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: SvgPicture.asset(
                            widget.leadingIconAsset!,
                            fit: BoxFit.contain,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    );
                  }
                }
                return const SizedBox();
              },
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth - (widget.leadingIcon || widget.loading ? 32 : 0),
              ),
              child: Text(widget.text, style: textFont.copyWith(color: textColor,),),
            ),
            Builder(
              builder: (context) {
                if (!widget.invertedLeadingIconPosition) {
                  if (widget.loading) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 16),
                        loadingIcon,
                      ],
                    );
                  }
                  if (widget.leadingIcon) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: SvgPicture.asset(
                            widget.leadingIconAsset!,
                            fit: BoxFit.contain,
                            color: textColor,
                          ),
                        ),
                      ],
                    );
                  }
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}