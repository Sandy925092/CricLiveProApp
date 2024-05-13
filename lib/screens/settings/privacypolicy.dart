import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/privacy_policy_response.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  PrivacyPolicyResponse privacyPolicyResponse = PrivacyPolicyResponse();
  @override
  void initState() {
    _getPrivacyPolicyApi();
    super.initState();
  }
  Future<void> _getPrivacyPolicyApi() async {
    BlocProvider.of<LiveScoreCubit>(context).privacyPolicyCall();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
     // backgroundColor: bgColor,
      appBar:  CustomAppBar(
        title: "Privacy Policy",
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<LiveScoreCubit,LiveScoreState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == LiveScoreStatus.privacyPolicySuccess){
            Loader.hide();
            privacyPolicyResponse = state.responseData?.response as PrivacyPolicyResponse;
          }
          if(state.status == LiveScoreStatus.privacyPolicyError){
            Loader.hide();
            String message = state.errorData?.message ?? state.error ?? '';
            UiHelper.toastMessage( message);
          }
        },
        builder: (context,state){
          if (state.status == LiveScoreStatus.privacyPolicyLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
            );
          }
          if (state.status == LiveScoreStatus.privacyPolicyError) {
            int statusCode = state.errorData?.code ?? 0;
            String? error = state.errorData?.message ?? state.error;
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: screenHeight * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //  Image.asset('assets/images/error.png', height: 45, width: 45),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left :50.0 , right: 50.0),
                      child: statusCode == 401
                          ? mediumText14(
                        context, error ?? '',//'You  have no internet connection Please enable Wi-fi or Mobile Data\nPull to refresh.',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ) : mediumText14 (
                          context, '$error\nPull to refresh.',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                 // padding: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.only(left: 14,right: 14,top: 14),
                  child: RefreshIndicator(
                    key: const Key('some_value'),
                    onRefresh: _getPrivacyPolicyApi,
                    child: privacyPolicyResponse.data?.length==0?
                    Column(
                      children: [
                        const SizedBox(height: 200,),
                        Center(child: largeText16(context, 'There is no Earning History',fontWeight: FontWeight.w600,fontSize: 20)),
                      ],
                    ):
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: privacyPolicyResponse.data?.length ?? 0,
                      itemBuilder: (context, index) {

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child:HtmlWidget(privacyPolicyResponse.data![index].policyText??''),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );

        },
      ),
    );
  }
}
