// import '../../utils/exports.dart';
//
// class FetchBusinessProfile extends StatefulWidget {
//
//   Widget profileData();
//   const FetchBusinessProfile({super.key});
//
//   @override
//   State<FetchBusinessProfile> createState() => _FetchBusinessProfileState();
// }
//
// class _FetchBusinessProfileState extends State<FetchBusinessProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ViewOffersBloc, ViewOffersState>(builder: (context, state) {
//       if (state is ViewOffersLoading) {
//         return Center(child: BurgerKingShimmer());
//       } else if (state is ViewOffersFailure) {
//         return Padding(
//           padding: const EdgeInsets.all(40),
//           child: Center(
//             child: Text(
//               state.error.toString(),
//               textAlign: TextAlign.center,
//               style: AppStyle.medium_14(AppColors.redColor),
//             ),
//           ),
//         );
//       } else if (state is ViewOffersSuccess) {
//         final offersData = state.offersDetailModel.data;
//         return
//   }
// }
