import 'package:flutter/material.dart';
import 'package:project_mobile/settings/app_colors.dart';

class BottomSheetHelper {

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    ScrollController? scrollController,
    bool isDismissible = true,
    bool handleWillPopOnDismiss = true,
    bool isPadded = true,
    bool isScrollable = true,
    bool useMaximumHeight = false,
    bool enableDrag = true,
    bool useFullScreen = false,
    bool? showDragHandle,
    Color backgroundColor = AppColors.backgroundColor,
    void Function()? onClose,
  }) async {

    final returnValue = await showModalBottomSheet<T>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag ? isDismissible : false,
      showDragHandle: showDragHandle ?? isDismissible,
      backgroundColor: backgroundColor,
      barrierColor: Colors.black.withOpacity(0.5),
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      useSafeArea: true,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(handleWillPopOnDismiss ? isDismissible : true),
        child: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: (useFullScreen ? MediaQuery.of(context).size.height : 2 * MediaQuery.of(context).size.height / 3 + MediaQuery.of(context).viewInsets.bottom) - MediaQuery.of(context).viewInsets.top,
            ),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom,),
                child: SizedBox(
                  height: useMaximumHeight ? double.infinity : null,
                  child: isScrollable ? isPadded ? SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: child,
                  ) : SingleChildScrollView(
                    controller: scrollController,
                    child: child,
                  ) : isPadded ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: child,
                  ) : child,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    onClose?.call();
    return returnValue;
  }
}
