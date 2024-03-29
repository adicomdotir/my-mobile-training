import 'package:first_flutter/clean_architecture_app/app/di.dart';
import 'package:first_flutter/clean_architecture_app/presentation/main/home/home_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/model.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidgets(),
                    () {
                  _viewModel.start();
                }) ??
                Container();
          },
        ),
      ),
    );
  }

  Widget _getContentWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services),
        _getServices(),
        _getSection(AppStrings.stores),
        _getStores()
      ],
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<List<BannerAd>>(
        stream: _viewModel.outputBanners,
        builder: (context, snapshot) {
          return _getBanner(snapshot.data);
        });
  }

  Widget _getBanner(List<BannerAd>? banners) {
    if (banners != null) {
      return Container();
      // return CarouselSlider(
      //     items: banners
      //         .map((banner) => SizedBox(
      //               width: double.infinity,
      //               child: Card(
      //                 elevation: AppSize.s1_5,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(AppSize.s12),
      //                     side: BorderSide(
      //                         color: ColorManager.white, width: AppSize.s1_5)),
      //                 child: ClipRRect(
      //                   borderRadius: BorderRadius.circular(AppSize.s12),
      //                   child: Image.network(
      //                     banner.image,
      //                     fit: BoxFit.cover,
      //                   ),
      //                 ),
      //               ),
      //             ))
      //         .toList(),
      //     options: CarouselOptions(
      //         height: AppSize.s190,
      //         autoPlay: true,
      //         enableInfiniteScroll: true,
      //         enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  Widget _getServices() {
    return StreamBuilder<List<Service>>(
        stream: _viewModel.outputServices,
        builder: (context, snapshot) {
          return _getServicesWidget(snapshot.data);
        });
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding: EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s140,
          margin: EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
                      elevation: AppSize.s4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                              color: ColorManager.white, width: AppSize.s1_5)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.network(
                              service.image,
                              fit: BoxFit.cover,
                              width: AppSize.s100,
                              height: AppSize.s100,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                service.title,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStores() {
    return StreamBuilder<List<Store>>(
        stream: _viewModel.outputStores,
        builder: (context, snapshot) {
          return _getStoresWidget(snapshot.data);
        });
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    // navigate to store details screen
                    Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
