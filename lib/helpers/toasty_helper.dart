import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_mobile/config/app_assets.dart';
import 'package:project_mobile/config/app_colors.dart';
import 'package:project_mobile/config/app_fonts.dart';

enum MessageType { success, alert, error }

class QueueItem {
  final BuildContext context;
  final OverlayEntry overlayEntry;

  QueueItem({
    required this.context,
    required this.overlayEntry,
  });
}

class ToastHelper {

  static final List<QueueItem> _queue = [];
  static bool _serviceHasStarted = false;
  static bool _stopService = false;
  static bool _waitingEntryToBeRemoved = false;

  static void startService() async {
    _stopService = false;
    _serviceHasStarted = true;
    do {
      if (_queue.isNotEmpty && !_waitingEntryToBeRemoved) {
        final nextItem = _queue.first;
        if (!nextItem.context.mounted || !Overlay.of(nextItem.context).mounted) {
          _queue.remove(nextItem);
          continue;
        }
        try {
          Overlay.of(nextItem.context).insert(nextItem.overlayEntry);
        } catch (e) {
          print(e);
        }
        _waitingEntryToBeRemoved = true;
      }
      await Future.delayed(const Duration(milliseconds: 100));
    } while (!_stopService);
    _serviceHasStarted = false;
  }

  static void stopService() {
    _stopService = true;
  }

  static void removeCurrentEntry() {
    try {
      if (_queue.isNotEmpty && _waitingEntryToBeRemoved) {
        _queue.first.overlayEntry.remove();
        _queue.removeAt(0);
        _waitingEntryToBeRemoved = false;
      }
    } catch (e) {
      print(e);
    }
  }

  static void showMessage({
    required BuildContext context,
    required MessageType messageType,
    required String message,
  }) {
    if (message.isNotEmpty) {
      _queue.add(QueueItem(
        context: context,
        overlayEntry: OverlayEntry(
          builder: (context) => _ToastWidget(messageType: messageType, message: message,),
        ),
      ));
      if (!_serviceHasStarted) {
        startService();
      }
    }
  }
}

class _ToastWidget extends StatefulWidget {
  final MessageType messageType;
  final String message;

  const _ToastWidget({
    super.key,
    required this.messageType,
    required this.message,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> {

  late final Duration timeUntilVanish;
  late final Duration fadeDuration;
  late bool isVisible;

  @override
  void initState() {
    timeUntilVanish = Duration(milliseconds: widget.message.length * 100);
    fadeDuration = const Duration(milliseconds: 200);
    isVisible = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (mounted) setState(() => isVisible = true);

      await Future.delayed(fadeDuration);
      await Future.delayed(timeUntilVanish);

      if (mounted) setState(() => isVisible = false);

      await Future.delayed(fadeDuration);
      ToastHelper.removeCurrentEntry();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IgnorePointer(
        ignoring: !isVisible,
        child: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.all(16),
          child: AnimatedOpacity(
            opacity: isVisible ? 1 : 0,
            duration: fadeDuration,
            child: GestureDetector(
              onTap: () async {
                if (mounted) {
                  setState(() {
                    isVisible = false;
                  });
                }
                await Future.delayed(fadeDuration);
                ToastHelper.removeCurrentEntry();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      offset: const Offset(0, 6),
                      blurRadius: 16,
                      spreadRadius: -4,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(999),
                  color: widget.messageType == MessageType.error
                      ? AppColors.semanticRedColor
                      : widget.messageType == MessageType.alert
                      ? AppColors.semanticYellowColor
                      : AppColors.semanticGreenColor,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 16,
                      width: 16,
                      child: SvgPicture.asset(
                        widget.messageType == MessageType.success
                            ? AppAssets.successIcon
                            : widget.messageType == MessageType.alert
                            ? AppAssets.warningIcon
                            : AppAssets.errorIcon,
                        fit: BoxFit.contain,
                        color: AppColors.textWhiteColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(widget.message, style: AppFonts.regularDefault.copyWith(color: AppColors.textWhiteColor,),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
