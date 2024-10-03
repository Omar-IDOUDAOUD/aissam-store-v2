// import 'package:aissam_store_v2/core/failure.dart';
// import 'package:aissam_store_v2/app/presentation/config/constants.dart';
// import 'package:aissam_store_v2/app/presentation/core/shared/buttons/content.dart';
// import 'package:aissam_store_v2/app/presentation/core/shared/buttons/primary_button.dart';
// import 'package:aissam_store_v2/app/presentation/core/shared/buttons/secondary_button.dart';
// import 'package:aissam_store_v2/app/presentation/pages/home/tabs/search/views/sub_views/filter_dialog/widgets/text_field.dart';
// import 'package:aissam_store_v2/utils/extentions/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class EmailVerificationDialog extends StatelessWidget {
//   const EmailVerificationDialog(
//       {super.key, required this.newEmail, required this.oldEmail});
//   final String newEmail;
//   final String? oldEmail;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: context.theme.colors.a,
//       elevation: 10,
//       shadowColor: Colors.black.withOpacity(.2),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(ViewConsts.pagePadding),
//         child: Column(
//           children: [
//             Text(
//               'Email verification',
//               style: context.textTheme.bodyLarge,
//             ),
//             const SizedaBox(height: 10),
//             Text(
//               oldEmail != null
//                   ? 'To verify your new email address, you have to click the both links we sent to your new email "$newEmail" and your old email "$oldEmail". '
//                   : 'To verify your email "$newEmail", We sent you a verification link!',
//               style: context.textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 10),
//             PrimaryButton(
//               onPressed: context.pop,
//               child: const ButtonFormat1(label: 'Ok'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PhoneNumberVerificationDialog extends StatefulWidget {
//   const PhoneNumberVerificationDialog(
//       {super.key,
//       required this.phoneNumber,
//       required this.onApply,
//       required this.onCancel});
//   final String phoneNumber;
//   final Future<Failure?> Function(int code) onApply;
//   final Function() onCancel;

//   @override
//   State<PhoneNumberVerificationDialog> createState() =>
//       _PhoneNumberVerificationDialogState();
// }

// class _PhoneNumberVerificationDialogState
//     extends State<PhoneNumberVerificationDialog> {
//   Failure? _applyResult;

//   String _code = '';
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: context.theme.colors.a,
//       elevation: 10,
//       shadowColor: Colors.black.withOpacity(.2),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(ViewConsts.pagePadding),
//         child: Column(
//           children: [
//             Text(
//               'Phone number verification',
//               style: context.textTheme.bodyLarge,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'We have sent a verification code to your new phone number "${widget.phoneNumber}".',
//               style: context.textTheme.bodyMedium,
//             ),
//             const SizedBox(height: 10),
//             TextField2(
//               hint: '000000',
//               onChange: (code) {
//                 _code = code;
//               },
//             ),
//             const SizedBox(height: 10),
//             if (_applyResult != null)
//               Text(_applyResult!.message ?? _applyResult!.code),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 SecondaryButton(
//                   onPressed: () {
//                     widget.onCancel();
//                     context.pop();
//                   },
//                   child: const ButtonFormat1(label: 'Cancel'),
//                 ),
//                 PrimaryButton(
//                   onPressed: () async {
//                     if (_code.length == 6 && int.tryParse(_code) != null) {
//                       _applyResult = await widget.onApply(int.parse(_code));
//                       if (!mounted) return;
//                       if (_applyResult != null) {
//                         setState(() {});
//                       } else {
//                         context.pop();
//                       }
//                     }
//                   },
//                   child: const ButtonFormat1(label: 'Verify'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
