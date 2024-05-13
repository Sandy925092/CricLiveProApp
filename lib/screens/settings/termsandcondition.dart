import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kisma_livescore/cubit/livescore_cubit.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/terms_and_conditions_response.dart';
import 'package:kisma_livescore/utils/colorfile.dart';
import 'package:kisma_livescore/utils/custom_widgets.dart';
import 'package:kisma_livescore/utils/ui_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  TermsAndConditionsResponse termsAndConditionsResponse = TermsAndConditionsResponse();
  @override
  void initState() {
    _getTermsAndConditionsApi();

    super.initState();
  }
  Future<void> _getTermsAndConditionsApi() async {
    BlocProvider.of<LiveScoreCubit>(context).termsAndConditionCall();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Terms and Conditions",
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<LiveScoreCubit,LiveScoreState>(
        listener: (context,state){
          print("sate.status:${state.status}");
          if(state.status == LiveScoreStatus.termsAndConditionsSuccess){
            termsAndConditionsResponse = state.responseData?.response as TermsAndConditionsResponse;
          }
          if(state.status == LiveScoreStatus.termsAndConditionsError){
            String message = state.errorData?.message ?? state.error ?? '';
            UiHelper.toastMessage( message);
          }
        },
        builder: (context,state){
          if (state.status == LiveScoreStatus.termsAndConditionsLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF0DA9AF)),
            );
          }
          if (state.status == LiveScoreStatus.termsAndConditionsError) {
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
              /*   customAppbar(context: context, title: "Earning History", onBackTap: () {
                Navigator.of(context).pop();
              }),*/
              Expanded(
                child: Padding(
                  // padding: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.only(left: 14,right: 14,top: 14),
                  child: RefreshIndicator(
                    key: const Key('some_value'),
                    onRefresh: _getTermsAndConditionsApi,
                    child: termsAndConditionsResponse.data?.length==0?
                    Column(
                      children: [
                        const SizedBox(height: 200,),
                        Center(child: largeText16(context, 'There is no Earning History',fontWeight: FontWeight.w600,fontSize: 20)),
                      ],
                    ):
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: termsAndConditionsResponse.data?.length ?? 0,
                      itemBuilder: (context, index) {

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child:HtmlWidget(termsAndConditionsResponse.data![index].termsText??''),
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
