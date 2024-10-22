import 'package:aissam_store_v2/app/buisness/features/authentication/core/failures.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/authentication/domain/usecases/usecases.dart';
import 'package:aissam_store_v2/app/buisness/features/user/core/params.dart';
import 'package:aissam_store_v2/app/buisness/features/user/domain/usecases/user.dart';
import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/bottomsheet/view.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/primary.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/secondary.dart';
import 'package:aissam_store_v2/app/presentation/core/views/dialog/view.dart';
import 'package:aissam_store_v2/app/presentation/core/views/error_card.dart';
import 'package:aissam_store_v2/core/utils/extentions/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:go_router/go_router.dart';

class ModifyEmaillBottomSheetContent extends StatefulWidget {
  const ModifyEmaillBottomSheetContent(
      {super.key, this.oldEmail, required this.context});
  final String? oldEmail;
  final BuildContext context;

  @override
  State<ModifyEmaillBottomSheetContent> createState() =>
      _ModifyEmaillBottomSheetContentState();
}

class _ModifyEmaillBottomSheetContentState
    extends State<ModifyEmaillBottomSheetContent> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _invalidEmail = false;
  bool _isLoading = false;
  Object? _responsError;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController()
      ..addListener(() {
        if (_invalidEmail) {
          setState(() {
            _invalidEmail = false;
          });
        }
      });
    _passwordController = TextEditingController()
      ..addListener(() {
        if (_invalidPassword || _wrongPassword) {
          setState(() {
            _invalidPassword = _wrongPassword = false;
          });
        }
      });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _obsecuringPassword = true;
  bool _invalidPassword = false;

  bool _wrongPassword = false;
  Future<void> _onSave() async {
    if (!_emailController.text.isEmail)
      setState(() {
        _invalidEmail = true;
      });
    else if (_passwordController.text.length <= 6) {
      setState(() {
        _invalidPassword = true;
      });
    } else {
      setState(() {
        _isLoading = true;
      });

      final resp = await UpdateAuthEmail().call(
        UpdateAuthEmailParams(
          password: _passwordController.text,
          newEmail: _emailController.text,
        ),
      );
      resp.fold(
        (fail) {
          if (fail is InvalidPassword) {
            if (mounted) {
              setState(() {
                _isLoading = false;
                _wrongPassword = true;
              });
            } else {
              _showResultDialog(fail);
            }
          } else {
            if (mounted) context.pop();
            _showResultDialog(fail);
          }
        },
        (_) {
          if (mounted) context.pop(_emailController.text);
          _showResultDialog();
        },
      );
    }
  }

  void _showResultDialog([Failure? failure]) {
    showDialog2(
      context: widget.context,
      body: _ResultDialog(failure: failure),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Bottomsheet2Skeleton(
      title: BottomSheet2Title(
        title: 'Modify email',
        applySaveIcon: _isLoading ? false : true,
        applyCancelIcon: true,
        onCancel: _isLoading ? null : context.pop,
        onSave: _onSave,
      ),
      body: AnimatedSize(
        alignment: Alignment.topCenter,
        curve: ViewConsts.animationCurve,
        duration: const Duration(milliseconds: 500),
        child: AnimatedSwitcher(
          switchInCurve: ViewConsts.animationCurve,
          switchOutCurve: ViewConsts.animationCurve.flipped,
          duration: const Duration(milliseconds: 3000),
          transitionBuilder: (child, animation) {
            return DualTransitionBuilder(
              animation: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
              forwardBuilder: (context, animation, child) {
                final slideAnimation =
                    Tween(begin: Offset.zero, end: const Offset(-1.5, 0))
                        .animate(animation);
                return SlideTransition(
                  position: slideAnimation,
                  child: child,
                );
              },
              reverseBuilder: (context, animation, child) {
                final slideAnimation =
                    Tween(begin: const Offset(1.5, 0), end: Offset.zero)
                        .animate(animation);
                return SlideTransition(
                  position: slideAnimation,
                  child: child,
                );
              },
            );
          },
          child: _isLoading
              ? const Padding(
                  key: ValueKey('c2'),
                  padding: EdgeInsets.all(50),
                  child: CircularProgressIndicator(strokeCap: StrokeCap.round),
                )
              : _responsError != null
                  ? ErrorCard(
                      error: _responsError!,
                      addPageMargine: true,
                    )
                  : Padding(
                      key: const ValueKey('c1'),
                      padding: const EdgeInsets.symmetric(
                          horizontal: ViewConsts.pagePadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (widget.oldEmail != null) ...[
                            Text(
                              'Old email',
                              style: context.textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller:
                                  TextEditingController(text: widget.oldEmail),
                              readOnly: true,
                              style: context.textTheme.bodyLarge,
                              decoration: InputDecoration(
                                focusedBorder:
                                    context.theme.inputDecorationTheme.border,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'New email',
                              style: context.textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: context.textTheme.bodyLarge,
                              decoration: InputDecoration(
                                errorText: _invalidEmail
                                    ? 'This email is invalid!'
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Account password',
                              style: context.textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: _obsecuringPassword,
                              style: context.textTheme.bodyLarge,
                              decoration: InputDecoration(
                                errorText: _invalidPassword
                                    ? 'Password should be more than 6 characters'
                                    : _wrongPassword
                                        ? 'Wrong password!'
                                        : null,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obsecuringPassword
                                        ? FluentIcons.eye_24_regular
                                        : FluentIcons.eye_off_24_regular,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obsecuringPassword =
                                          !_obsecuringPassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}

class _ResultDialog extends StatelessWidget {
  const _ResultDialog({this.failure});
  final Failure? failure;

  @override
  Widget build(BuildContext context) {
    return failure != null
        ? Dialog2Skeleton(
            title: const Dialog2Title(
              title: 'Operation failed!',
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: ErrorCard(
                    showDescription: true,
                    addPageMargine: true,
                    error: failure!,
                  ),
                ),
              ],
            ),
            action: [
              SecondaryRoundedButton(label: 'Cancel', onPressed: context.pop),
              const SizedBox(
                width: 8,
              ),
              const PrimaryRoundedButton(label: 'Rety'),
            ],
          )
        : Dialog2Skeleton(
            title: const Dialog2Title(
              title: 'Almost success!',
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const Icon(
                    FluentIcons.mail_48_regular,
                    size: 50,
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'To finish new email verification, you have to click on both links sent to your old and new emails to complete verfication process!',
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            action: [
              SecondaryRoundedButton(
                label: 'Ok!',
                onPressed: context.pop,
              ),
            ],
          );
  }
}
