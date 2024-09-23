import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/Routes/app_routes.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_constant.dart';
import '../../Utils/app_images.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_widget.dart';
import '../App_Widgets/empty_widget.dart';
import '../Home_View/Controller/bottom_controller.dart';
import '../Home_View/Model/product_model.dart';
import 'cart_controller.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => AppbarWidget(
                title: 'Carts',
                isClearCart:
                    cartController.cartListModel.value.productData?.isEmpty ??
                            true
                        ? false
                        : true,
                isCart: false,
                isSearch: false,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async =>
                    cartController.cartListApi(isLoadingShow: false),
                color: AppColors.orangeColor,
                child: Obx(
                  () => Skeletonizer(
                    enabled: cartController.isLoading.value,
                    child: cartController
                                .cartListModel.value.productData?.isEmpty ??
                            true
                        ? const EmptyWidget()
                        : ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Divider(color: AppColors.greyColor),
                            ),
                            itemCount: cartController
                                    .cartListModel.value.productData?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              var productData = cartController
                                  .cartListModel.value.productData?[index];
                              return cartCardWidget(
                                  ind: index.obs, productData: productData);
                            },
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Obx(
              () => Visibility(
                visible: cartController
                        .cartListModel.value.productData?.isNotEmpty ??
                    false,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Total", style: AppTextStyle.lableLarge),
                      ),
                      Obx(
                        () => Text(
                          "${cartController.currentUserController.currency.value}${cartController.cartListModel.value.productData?.fold<double>(0, (t, e) => t + double.parse(e.variantDetails?.sellingPrice ?? '0.0') * e.cartItem!.value).toStringAsFixed(2) ?? ''}",
                          style: AppTextStyle.bodyLargeGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Obx(
              () => Visibility(
                visible: cartController
                        .cartListModel.value.productData?.isNotEmpty ??
                    false,
                child: Divider(color: AppColors.greyColor),
              ),
            ),
            const SizedBox(height: 4),
            Obx(
              () => Visibility(
                visible: cartController
                        .cartListModel.value.productData?.isNotEmpty ??
                    false,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      final BottomController bottomController =
                          Get.put(BottomController());
                      bottomController.myIndex.value = 0;
                      Get.offAllNamed(AppRoutes.mainBottomView);
                    },
                    child: Text(
                      "Continue Shopping",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyLargeDarkGray16
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Visibility(
          visible: !cartController.isLoading.value,
          child: Visibility(
            visible:
                cartController.cartListModel.value.productData?.isNotEmpty ??
                    false,
            child: Container(
              height: 54,
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: ButtonWidget(
                title: "CHECKOUT",
                onTap: () {
                  Get.toNamed(AppRoutes.checkout);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cartCardWidget({required RxInt ind, ProductsModel? productData}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.productDetails,
                arguments: [productData?.intGlcode, productData?.varTitle]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 6,
                  surfaceTintColor: AppColors.whiteColor,
                  shadowColor: AppColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: productData?.varImage?.isNotEmpty ?? false
                        ? Image.network(
                            productData!.varImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Skeletonizer(
                                enabled: true,
                                child: Image.asset(
                                  AppImages.icProductImg,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          )
                        : SizedBox(
                            height: 100,
                            width: 100,
                            child: Icon(
                              Icons.image,
                              color: AppColors.gray,
                              size: 40,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Text(productData?.varTitle ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.lableLarge),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${cartController.currentUserController.currency.value}${productData?.variantDetails?.sellingPrice}",
                        style: AppTextStyle.bodyLargeGreen,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          qtyWidget(
                            title: '-',
                            onTap: () => {
                              productData?.cartItem?.value--,
                              if (productData!.cartItem!.value <
                                      int.parse(productData
                                              .variantDetails?.varStock ??
                                          '0') &&
                                  productData.cartItem!.value > 0)
                                {
                                  cartController.currentUserController
                                      .cartAddUpdateApi(
                                          fkProduct:
                                              productData.intGlcode ?? '',
                                          fkVariant: productData
                                                  .variantDetails?.variantId ??
                                              '',
                                          qty: productData.cartItem?.value
                                                  .toString() ??
                                              '0'),
                                }
                              else
                                {
                                  if (productData.cartItem!.value > 0)
                                    {
                                      AppConstant().snackbars("Info",
                                          "Currently we have only ${productData.variantDetails?.varStock} In Stock."),
                                    }
                                  else
                                    {
                                      productData.cartItem?.value++,
                                    }
                                },
                            },
                          ),
                          Obx(
                            () => qtyWidget(
                                title: productData?.cartItem.toString() ?? ''),
                          ),
                          qtyWidget(
                            title: '+',
                            onTap: () => {
                              if (productData!.cartItem!.value <
                                  int.parse(
                                      productData.variantDetails?.varStock ??
                                          '0'))
                                {
                                  productData.cartItem?.value++,
                                  cartController.currentUserController
                                      .cartAddUpdateApi(
                                          fkProduct:
                                              productData.intGlcode ?? '',
                                          fkVariant: productData
                                                  .variantDetails?.variantId ??
                                              '',
                                          qty: productData.cartItem?.value
                                                  .toString() ??
                                              '0'),
                                }
                              else
                                {
                                  AppConstant().snackbars("Info",
                                      "Currently we have only ${productData.variantDetails?.varStock} In Stock."),
                                }
                            },
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () => {
                                  setState(() {
                                    cartController
                                        .cartListModel.value.productData
                                        ?.remove(productData);
                                  }),
                                  cartController.cartDeleteProductApi(
                                    fkProduct: productData?.intGlcode ?? '',
                                    fkVariant: productData
                                            ?.variantDetails?.variantId ??
                                        '',
                                  ),
                                },
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: SvgPicture.asset(AppImages.icDelete),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // const SizedBox(height: 20),
          // Divider(color: AppColors.greyColor),
        ],
      ),
    );
  }
}

Widget qtyWidget({required String title, void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            border: Border.all(color: AppColors.lightGrayColor),
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: AppTextStyle.titleLarge.copyWith(fontSize: 16),
        ),
      ),
    ),
  );
}
