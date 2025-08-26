import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kisma_livescore/commonwidget.dart';
import 'package:kisma_livescore/customwidget/commonwidget.dart';
import 'package:kisma_livescore/responses/getprofile.dart';
import 'package:kisma_livescore/utils/shared_preference.dart';

import '../../constants.dart';
import '../../cubit/livescore_cubit.dart';
import '../../utils/custom_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String image = "";
  File? filePath;

  final ImagePicker _picker = ImagePicker();
  String mediaImage = "";

  GetProfileResponse getProfileResponse = GetProfileResponse();

  String token = "";

  Future<void> loadCameraAssets() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 300,
        maxWidth: 300,
      );
      if (pickedFile != null) {
        setState(() {
          filePath = File(pickedFile.path);
          mediaImage = filePath!.path;
        });
        log("Success from camera: $mediaImage");
      }
    } catch (e) {
      log("Failed to load image from camera: $e");
    }
  }

  Future<void> _openGallery() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          filePath = File(pickedFile.path);
          mediaImage = filePath!.path;
        });
        log("Success from gallery: $mediaImage");
      }
    } catch (e) {
      log("Failed to load image from gallery: $e");
    }
  }

  camerapopup() {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Choose Options",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.cancel_sharp),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              loadCameraAssets();
            },
            child: optionButton(context, "Camera"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              _openGallery();
            },
            child: optionButton(context, "Gallery"),
          ),
        ],
      ),
    );
  }

  Widget optionButton(BuildContext context, String label) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffFFFFFF), Color(0xffD3D3D3)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: Text(label)),
    );
  }

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1A3C), // dark blue background
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1A3C),
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const Text(
              "Profile",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
      body: BlocConsumer<LiveScoreCubit, LiveScoreState>(
        listener: (context, state) {
          if (state.status == LiveScoreStatus.getProfileSuccess) {
            getProfileResponse =
                state.responseData?.response as GetProfileResponse;

            nameController.text =
                getProfileResponse.data?.fullName.toString() ?? "";
            emailController.text =
                getProfileResponse.data?.email.toString() ?? "";
            countryController.text =
                getProfileResponse.data?.country.toString() ?? "";

            image = getProfileResponse.data?.profile.toString() ?? "";
          }

          if (state.status == LiveScoreStatus.updateProfileSuccess) {
            showToast(
                context: context, message: "Profile Updated Successfully");
            Navigator.pop(context);
          }

          if (state.status == LiveScoreStatus.updateProfileError) {
            showToast(
                context: context,
                message: state.errorData?.message.toString() ?? "");
          }
        },
        builder: (context, state) {
          if (state.status == LiveScoreStatus.getProfileLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Center(
                    child: filePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              filePath!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : image.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: CachedNetworkImage(
                                  imageUrl: image,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("assets/images/iv_dummy.png"),
                                  fit: BoxFit.cover,
                                  height: 100,
                                  width: 100,
                                ),
                              )
                            : Image.asset(
                                'assets/images/iv_dummy.png',
                                width: 100,
                                height: 100,
                              ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      print("On tap is calling");
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return camerapopup();
                        },
                      );
                    },
                    child: commonText(
                        data: "Change Profile",
                        fontSize: 14,
                        color: Colors.white)),
                const SizedBox(height: 20),
                dashboardTextField(
                  controller: nameController,
                  hintText: 'Name',
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Image.asset(
                    "assets/images/profile.png",
                    height: 16,
                    width: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                dashboardTextField(
                  controller: emailController,
                  hintText: 'Email Id',
                  isEnabled: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Image.asset(
                    "assets/images/email.png",
                    height: 16,
                    width: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                dashboardTextField(
                  readOnly: true,
                  controller: countryController,
                  hintText: 'Country',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: Image.asset(
                    "assets/images/country.png",
                    height: 16,
                    width: 16,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Image.asset(
                      "assets/images/down.png",
                      height: 12,
                      width: 14,
                    ),
                  ),
                  onTap: () {
                    showCountryPicker(
                      context: context,
                      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                      //    exclude: <String>['KN', 'MF'],
                      //     favorite: <String>['SE'],
                      //Optional. Shows phone code before the country name.
                      showPhoneCode: false,
                      onSelect: (Country country) {
                        print(
                            'Select country: ${country.displayNameNoCountryCode}');
                        countryController.text =
                            country.displayNameNoCountryCode;
                      },
                      // Optional. Sheet moves when keyboard opens.
                      moveAlongWithKeyboard: false,
                      // Optional. Sets the theme for the country list picker.
                      countryListTheme: CountryListThemeData(
                        // Optional. Sets the border radius for the bottomsheet.
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        // Optional. Styles the search field.
                        inputDecoration: InputDecoration(
                          labelText: 'Search',
                          hintText: 'Start typing to search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: const Color(0xFF8C98A8).withOpacity(0.2),
                            ),
                          ),
                        ),
                        // Optional. Styles the text in the search field
                        searchTextStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: state.status == LiveScoreStatus.updateProfileLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: neonColor,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () async {
                            if (isValidation()) {
                              if (filePath != null) {
                                print("image section");
                                print(filePath.toString());

                                String profileImage =
                                    filePath!.path.split('/').last;

                                var data = {'profile': filePath};

                                FormData formData = FormData.fromMap({
                                  "fullName": nameController.text.toString(),
                                  "country": countryController.text.toString(),
                                  "profile": data["profile"] == null
                                      ? null
                                      : await MultipartFile.fromFile(
                                          filePath!.path,
                                          filename: profileImage),
                                });

                                print("Data ==");
                                print(formData.fields);

                                isInternetConnected().then((value) async {
                                  if (value == true) {
                                    await BlocProvider.of<LiveScoreCubit>(
                                            context)
                                        .updateProfile(token, formData);
                                  } else {
                                    showToast(
                                        context: context,
                                        message: notConnected);
                                  }
                                });
                              } else {
                                print("image  not section");

                                FormData formData = FormData.fromMap({
                                  "fullName": nameController.text.toString(),
                                  "country": countryController.text.toString(),
                                });

                                print("Data ==");
                                print(formData.fields);

                                isInternetConnected().then((value) async {
                                  if (value == true) {
                                    await BlocProvider.of<LiveScoreCubit>(
                                            context)
                                        .updateProfile(token, formData);
                                  } else {
                                    showToast(
                                        context: context,
                                        message: notConnected);
                                  }
                                });
                              }
                            }

                            // setState(() {
                            //   isEditing = !isEditing;
                            // });
                          },
                          child: Text(
                              isEditing ? "Update Profile" : "Update Profile"),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void getToken() {
    token = PreferenceManager.getStringValue(key: "token") ?? '';

    isInternetConnected().then((value) async {
      if (value == true) {
        await BlocProvider.of<LiveScoreCubit>(context).getProfile(token);
      } else {
        showToast(context: context, message: notConnected);
      }
    });
  }

  bool isValidation() {
    if (nameController.text.toString().isEmpty) {
      showToast(context: context, message: "Please enter name ");
      return false;
    }
    return true;
  }
}
