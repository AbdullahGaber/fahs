import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logic/providers/general/shared_preferences_provider.dart';
import '../../logic/providers/general/regions_provider.dart';
import '../../logic/providers/general/cities_provider.dart';
import '../../helper/image_picker_dialog.dart';
import '../../logic/providers/changeData/change_password_provider.dart';
import '../../logic/providers/changeData/change_user_data_provider.dart';
import '../../logic/providers/changeData/change_phone_provider.dart';
import '../../widgets/profile_banner_widget.dart';
import '../../widgets/edit_profile_textfield_item.dart';
import '../../widgets/register_button.dart';
import '../../widgets/modal_bottom_widget.dart';
import '../../widgets/custom_new_dialog.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String zone = 'المنطقة';
  String city = 'المدينة';
  String phoneNum = '0965212514254';
  bool hideOldPassword = true;
  bool hideNewPassword = true;
  bool hideNewPasswordConfirm = true;
  File pickedImage;
  File insuranceImage;
  List<String> sections = ['المنطقة الجنوبية', 'المنطقة الشمالية'];
  List<String> cities = ['جدة', 'الرياض'];
  CustomDialog _dialog = CustomDialog();
  SharedPreferences prefs;
  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool isInit = true;
  bool isLoading = false;
  bool isLoadingCity = false;
  RegionsProvider regionsProvider;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      // prefs =
      //     Provider.of<SharedPreferencesProvider>(context, listen: false).prefs;
      regionsProvider = Provider.of<RegionsProvider>(context, listen: false);
      setState(() {
        isLoading = true;
      });
      prefs = await SharedPreferences.getInstance();
      zone = prefs.get('region_name');
      city = prefs.get('city_name');
      if (prefs.get('type') == 'عميل') {}
      await regionsProvider.getRegions();
      setState(() {
        isLoading = false;
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var changePassword = Provider.of<ChangePasswordProvider>(
      context,
      listen: false,
    );
    var changePhone = Provider.of<ChangePhoneProvider>(context, listen: false);
    var cityProvider = Provider.of<CitiesProvider>(context, listen: false);
    var changeData =
        Provider.of<ChangeUserDataProvider>(context, listen: false);
    var mediaQuery = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'حسابي',
              )),
          actions: [
            IconButton(
              icon: Icon(
                Icons.arrow_forward,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ProfileBannerWidget(
                name: '',
                // image: pickedImage == null
                //     ? (prefs.containsKey('image')
                //         ? NetworkImage(prefs.get('image'))
                //         :
                image: AssetImage('assets/images/log.png'),
                // : FileImage(pickedImage),
                isEdit: true,
                onTap: () {
                  ImagePickerDialog().show(
                      context: context,
                      onGet: (f) {
                        setState(() {
                          pickedImage = f;
                        });
                        changeData.image = f;
                      });
                },
              ),
               Stack(
              children: [
                CircleAvatar(
                  radius: 37,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/log.png'), 
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                    onTap: () {
                  ImagePickerDialog().show(
                    context: context,
                    onGet: (f) {
                      setState(() {
                        pickedImage = f;
                      });
                      changeData.image = f;
                    });
                },,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 13,
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
              EditProfileTextFieldItem(
                //initialValue: prefs.get('name'),
                hintText: 'الاسم',
                onChanged: (v) => changeData.name = v,
                icon: Icon(
                  FontAwesomeIcons.pencilAlt,
                  color: Colors.black,
                ),
              ),
              EditProfileTextFieldItem(
                //initialValue: prefs.get('email'),
                hintText: 'البريد الإلكتروني',
                onChanged: (v) => changeData.email = v,
                keyboardType: TextInputType.emailAddress,
                icon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
              // if (prefs.get('type') == 'مزود خدمة') ...[
              //   InkWell(
              //     onTap: () {
              //       ModalBottomWidget.showModalBottomWidget(
              //           context: context,
              //           items: regionsProvider.myRegions
              //               .map((e) => e.name)
              //               .toList(),
              //           mediaQuery: mediaQuery,
              //           onTap: (v) async {
              //             if (v != null) {
              //               setState(() {
              //                 zone = v;
              //                 isLoadingCity = true;
              //                 city = 'المدينة';
              //               });
              //               var selectedRegion = regionsProvider.myRegions
              //                   .firstWhere((element) => element.name == v);
              //               await cityProvider.getCities(
              //                   regionId: selectedRegion.id);
              //               setState(() {
              //                 isLoadingCity = false;
              //               });
              //             }
              //           });
              //     },
              //     child: EditProfileTextFieldItem(
              //       enablEditing: false,
              //       icon: Icon(
              //         Icons.arrow_drop_down,
              //         color: Colors.black,
              //       ),
              //       labelText: zone,
              //     ),
              //   ),
              //   InkWell(
              //     onTap: () {
              //       ModalBottomWidget.showModalBottomWidget(
              //           context: context,
              //           items:
              //               cityProvider.myCities.map((e) => e.name).toList(),
              //           mediaQuery: mediaQuery,
              //           onTap: (v) {
              //             if (v != null) {
              //               setState(() {
              //                 city = v;
              //               });
              //               var selectedCity = cityProvider.myCities
              //                   .firstWhere((element) => element.name == v);
              //               changeData.cityId = selectedCity.id;
              //               print(changeData.cityId);
              //             }
              //           });
              //     },
              //     child: EditProfileTextFieldItem(
              //       enablEditing: false,
              //       labelText: city,
              //       icon: isLoadingCity
              //           ? SpinKitCircle(
              //               color: Colors.black,
              //             )
              //           : Icon(
              //               Icons.arrow_drop_down,
              //               color: Colors.black,
              //             ),
              //     ),
              //   ),
              //   Stack(
              //     children: [
              //       Container(
              //           width: mediaQuery.width * 0.88,
              //           height: mediaQuery.height * 0.2,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(9),
              //           ),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(9),
              //             child: insuranceImage == null
              //                 ? Image.network(
              //                     prefs.get('com_image'),
              //                     fit: BoxFit.cover,
              //                   )
              //                 : Image.file(
              //                     insuranceImage,
              //                     fit: BoxFit.cover,
              //                   ),
              //           )),
              //       Positioned(
              //         left: mediaQuery.width * 0.01,
              //         top: mediaQuery.height * 0.01,
              //         child: Container(
              //           color: Colors.black87,
              //           padding: EdgeInsets.symmetric(
              //             horizontal: 10,
              //             vertical: 5,
              //           ),
              //           child: Text(
              //             'صورة السجل التجاري',
              //             style: TextStyle(color: Colors.black),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         right: mediaQuery.width * 0.01,
              //         top: mediaQuery.height * 0.01,
              //         child: CircleAvatar(
              //           backgroundColor: Colors.black.withOpacity(0.3),
              //           child: IconButton(
              //             icon: Icon(
              //               insuranceImage == null
              //                   ? Icons.camera_alt
              //                   : Icons.delete,
              //               color: insuranceImage == null
              //                   ? Theme.of(context).primaryColor
              //                   : Colors.red,
              //             ),
              //             onPressed: () {
              //               if (insuranceImage == null) {
              //                 ImagePickerDialog().show(
              //                     context: context,
              //                     onGet: (f) {
              //                       setState(() {
              //                         insuranceImage = f;
              //                       });
              //                       changeData.commercialImage = f;
              //                     });
              //               } else {
              //                 setState(() {
              //                   insuranceImage = null;
              //                 });
              //                 changeData.commercialImage = null;
              //               }
              //             },
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              //   EditProfileTextFieldItem(
              //     //initialValue: prefs.get('com_record'),
              //     hintText: 'رقم السجل التجاري',
              //     onChanged: (v) => changeData.commercialRecord = v,
              //     keyboardType: TextInputType.number,
              //     icon: Icon(
              //       Icons.email,
              //       color: Colors.black,
              //     ),
              //   ),
              // ],
              RegisterButton(
                title: 'تحديث البيانات',
                onPressed: () async {
                  await _dialog.showOptionDialog(
                    context: context,
                    msg: 'سيتم تحديث بياناتك الشخصية',
                    cancelFun: () {
                      return;
                    },
                    okFun: () async {
                      await changeData.changeData(context);
                    },
                    okMsg: 'نعم',
                    cancelMsg: 'لا',
                  );
                },
              ),
              EditProfileTextFieldItem(
                keyboardType: TextInputType.number,
                //initialValue: prefs.get('phone'),
                hintText: 'رقم الهاتف',
                onChanged: (v) => changePhone.phone = v,
                icon: Icon(
                  FontAwesomeIcons.pencilAlt,
                  color: Colors.black,
                ),
              ),
              RegisterButton(
                title: 'تحديث رقم الهاتف',
                onPressed: () async {
                  await _dialog.showOptionDialog(
                    context: context,
                    msg: 'سيتم تغيير رقم الهاتف , هل أنت متأكد؟',
                    cancelFun: () {
                      return;
                    },
                    okFun: () async {
                      await changePhone.changePhone(context);
                    },
                    okMsg: 'نعم',
                    cancelMsg: 'لا',
                  );
                },
              ),
              EditProfileTextFieldItem(
                hintText: 'كلمة المرور القديمة',
                hidePassword: hideOldPassword,
                controller: currentPasswordController,
                onChanged: (v) => changePassword.currentPassword = v,
                icon: IconButton(
                  icon: Icon(
                    hideOldPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      hideOldPassword = !hideOldPassword;
                    });
                  },
                ),
              ),
              EditProfileTextFieldItem(
                hintText: 'كلمة المرور الجديدة',
                hidePassword: hideNewPassword,
                controller: newPasswordController,
                onChanged: (v) => changePassword.newPassword = v,
                icon: IconButton(
                  icon: Icon(
                    hideNewPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      hideNewPassword = !hideNewPassword;
                    });
                  },
                ),
              ),
              EditProfileTextFieldItem(
                hintText: 'تأكيد كلمة المرور',
                controller: confirmPasswordController,
                hidePassword: hideNewPasswordConfirm,
                onChanged: (v) => changePassword.confirmPassword = v,
                icon: IconButton(
                  icon: Icon(
                    hideNewPasswordConfirm
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      hideNewPasswordConfirm = !hideNewPasswordConfirm;
                    });
                  },
                ),
              ),
              RegisterButton(
                title: 'تغيير كلمة المرور',
                onPressed: () async {
                  await _dialog.showOptionDialog(
                    msg: 'سيتم تغيير كلمة المرور , هل أنت متأكد؟',
                    context: context,
                    cancelMsg: 'لا',
                    okMsg: 'نعم',
                    okFun: () async {
                      var isEdited =
                          await changePassword.changePassword(context);
                      if (isEdited) {
                        currentPasswordController.clear();
                        newPasswordController.clear();
                        confirmPasswordController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    cancelFun: () {
                      return;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
