import 'package:flutter/material.dart';
import 'package:market_place_app/bloc/merchant_offers/delete_offers/delete_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/delete_offers/delete_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/delete_offers/delete_offers_state.dart';
import 'package:market_place_app/bloc/merchant_offers/disable_offers/disable_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/disable_offers/disable_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/disable_offers/disable_offers_state.dart';
import 'package:market_place_app/bloc/merchant_offers/fetch_offers/fetch_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/fetch_offers/fetch_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/fetch_offers/fetch_offers_state.dart';
import 'package:market_place_app/bloc/merchant_offers/update_offers/update_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/update_offers/update_offers_state.dart';
import 'package:market_place_app/bloc/merchant_offers/view_offers_details/view_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/view_offers_details/view_offers_event.dart';
import 'package:market_place_app/data/models/fetchoffers_model.dart';
import 'package:market_place_app/screens/my_offers/create_offers.dart';
import 'package:market_place_app/screens/my_offers/view_offers_details.dart';
import 'package:market_place_app/screens/settings/dialogs.dart';
import 'package:market_place_app/utils/app_assets.dart';
import 'package:market_place_app/utils/app_colors.dart';
import 'package:market_place_app/utils/custom_appbar.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../../utils/exports.dart';

class MyOffersList extends StatelessWidget {
  const MyOffersList({super.key});

  Future refreshData(BuildContext context) async {
    context.read<FetchOffersBloc>().add(GetOffersEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.themeColor,
          onPressed: () => AppRouter().navigateTo(context, CreateOffers()),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Icon(Icons.add, color: AppColors.whiteColor)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteOffersBloc, DeleteOffersState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is DeleteOffersLoading) {
                EasyLoading.show();
              } else if (state is DeleteOffersSuccess) {
                final data = state.offersData;
                snackBar(context, data['message'].toString(), AppColors.green);
                refreshData(context);
              } else if (state is DeleteOffersFailure) {
                snackBar(context, state.error.toString(), AppColors.redColor);
                refreshData(context);
              } else if (state is DeleteOffersInvalidResult) {
                EasyLoading.dismiss();
              }else{
                EasyLoading.dismiss();
              }
            },
          ),
          BlocListener<DisableOffersBloc, DisableOffersState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is DisableOffersLoading) {
                EasyLoading.show();
              } else if (state is DisableOffersSuccess) {
                final message = state.disableOffersModel.message.toString();
                snackBar(context, message, AppColors.green);
                refreshData(context);
              } else if (state is DisableOffersFailure) {
                snackBar(context, state.error.toString(), AppColors.redColor);
              }
            },
          ),
          BlocListener<AddOffersBloc, AddOffersState>(
            listener: (context, state) {
              if (state is AddOffersSuccess) {
                refreshData(context);
              }
            },
          ),
          BlocListener<UpdateOffersBloc, UpdateOffersState>(
            listener: (context, state) {
              if (state is UpdateOffersSuccess) {
                refreshData(context);
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: () => refreshData(context),
          child: CustomScrollView(
            slivers: [
              customSliverAppbar(
                  expandedHeight: size.height * 0,
                  title: Text("My Offers",
                      style: AppStyle.medium_18(AppColors.themeColor))),
              BlocBuilder<FetchOffersBloc, FetchOffersState>(
                builder: (context, state) {
                  if (state is FetchOffersLoading) {
                    return SliverToBoxAdapter(
                        child: Center(child: notificationShimmerLoading()));
                  } else if (state is FetchOffersFailure) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          state.error.toString(),
                          style: AppStyle.medium_14(AppColors.redColor),
                        ),
                      ),
                    );
                  } else if (state is FetchOffersSuccess) {
                    final offersList = state.fetchOffersListModel.data;

                    if (offersList!.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height / 2.5),
                            child: Text(
                              "Offers Not Found",
                              style: AppStyle.medium_14(AppColors.themeColor),
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: offersList!.length,
                        (context, index) => Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                                top: size.width * 0.03),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: TicketWidget(
                                width: size.width,
                                height: size.height * 0.15,
                                color: AppColors.theme5,
                                isCornerRounded: false,
                                padding: EdgeInsets.all(12),
                                child: TicketData(data: offersList[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SliverToBoxAdapter(child: SizedBox());
                  }
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: size.height * 0.1))
            ],
          ),
        ),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  OffersList? data;
  TicketData({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FadeInImage(
                    height: size.height * 0.08,
                    width: size.height * 0.08,
                    fit: BoxFit.cover,
                    placeholder: AssetImage(Assets.redeemOffers),
                    image: NetworkImage(data!.offerImage ?? ''),
                    imageErrorBuilder: (_, child, st) =>
                        Image.asset(Assets.assign))),
            SizedBox(width: size.width * 0.03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        "Flat ${data!.discountPercentage.toString() ?? ''}% OFF",
                        style: AppStyle.semiBold_18(AppColors.blackColor)),
                    data!.status != 'active'
                        ? Icon(Icons.do_disturb_alt_outlined,
                            color: AppColors.redColor)
                        : SizedBox()
                  ],
                ),
                Text('on orders above ₹${data!.minBillAmount ?? ''}',
                    style: AppStyle.normal_14(AppColors.black20)),
                Text(data!.title ?? '',
                    style: AppStyle.medium_16(AppColors.blackColor)),
                Text(
                    'Max. Dis. ₹${data!.maxDiscountCap ?? ''}  Min. Bill ₹${data!.minBillAmount ?? ''} ',
                    style: AppStyle.normal_12(AppColors.black20)),
              ],
            )
          ],
        ),
        popMenusForOffers(context: context, data: data),
      ],
    );
  }
}

Widget popMenusForOffers(
    {required OffersList? data, required BuildContext context}) {
  // Decide options based on status
  List<Map<String, dynamic>> options = data!.status == 'active'
      ? [
          {"icon": Icons.visibility, "menu": "View Details", "menu_id": 1},
          {"icon": Icons.edit, "menu": "Update", "menu_id": 2},
          {"icon": Icons.delete, "menu": "Delete", "menu_id": 3},
          {"icon": Icons.visibility_off, "menu": "Disabled", "menu_id": 4},
        ]
      : [
          {"icon": Icons.visibility, "menu": "View Details", "menu_id": 1},
          {"icon": Icons.edit, "menu": "Update", "menu_id": 2},
          {"icon": Icons.delete, "menu": "Delete", "menu_id": 3},
          {"icon": Icons.local_offer_sharp, "menu": "Enabled", "menu_id": 4},
        ];

  return CircleAvatar(
    backgroundColor: AppColors.theme10,
    child: PopupMenuButton(
      elevation: 10,
      padding: EdgeInsets.zero,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: AppColors.black20, size: 25.0),
      offset: const Offset(0, 50),
      itemBuilder: (BuildContext bc) {
        return options
            .map(
              (selectedOption) => PopupMenuItem(
                padding: EdgeInsets.zero,
                value: selectedOption,
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 30),
                  child: Row(
                    children: [
                      Icon(selectedOption['icon'], color: AppColors.black20),
                      const SizedBox(width: 10),
                      Text(selectedOption['menu'] ?? "",
                          style: AppStyle.medium_14(AppColors.black20))
                    ],
                  ),
                ),
              ),
            )
            .toList();
      },
      onSelected: (value) async {
        if (value['menu_id'] == 1) {
          context.read<ViewOffersBloc>().add(ViewOffersDetailsEvent(
              context: context, offersId: data!.id.toString()));

          AppRouter().navigateTo(context, ViewOffersDetails());
        } else if (value['menu_id'] == 2) {
          AppRouter()
              .navigateTo(context, CreateOffers(data: data, forUpdate: true));
        } else if (value['menu_id'] == 3) {
          deleteOffersDialog(context, () {
            Navigator.pop(context);
            context.read<DeleteOffersBloc>().add(DeleteOffersSubmit(
                context: context, offersId: data.id.toString()));
          });
        } else if (value['menu_id'] == 4) {
          context.read<DisableOffersBloc>().add(DisableOffersSubmit(
              context: context,
              offersId: data.id.toString(),
              status: data.status == 'active' ? 'inactive' : 'active'));
        }
      },
    ),
  );
}
