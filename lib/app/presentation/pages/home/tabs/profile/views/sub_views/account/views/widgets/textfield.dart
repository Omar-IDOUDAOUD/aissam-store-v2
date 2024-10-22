



// class TextField2 extends StatelessWidget {
//   const TextField2(
//       {super.key,
      
//        this.controller,
//       this.hint,
//       this.autofocus = false, 
//       this.onSubmitter, this.readOnly = false, this.onTap, });
//   final TextEditingController? controller;
//   final String? hint;
//   final Function()? onSubmitter;
//   final bool readOnly; 
//   final Function()? onTap; 
//   final bool autofocus; 

//   @override
//   Widget build(BuildContext context) {
//     return  SliverAware(
//       child:  _child(context)
//     )  ;
//   }

//   _child(BuildContext context){
//     final border = OutlineInputBorder(
//             borderRadius: BorderRadius.circular(ViewConsts.radius),
//             borderSide: BorderSide(
//               color: context.theme.colors.t,
//               width: 2,
//             ),
//           );
//     return TextField(
//       autofocus: autofocus, 
//         readOnly: readOnly,
//         onTap: onTap,
//         controller: controller,
//         style: context.textTheme.bodyLarge,
//         onSubmitted: (_) => onSubmitter?.call(),
//         decoration: InputDecoration(
//           hintText: hint,
//           filled: false,
//           focusedBorder: readOnly ? border : null,
//           enabledBorder: border, 
//         ),
//       );
//   }
// }