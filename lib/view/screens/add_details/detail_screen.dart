import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zylu/model/employee_data.dart';
import 'package:zylu/model/firebase_api.dart';
import 'package:zylu/view/css/css.dart';
import 'package:zylu/view/screens/add_details/widgets/image_display.dart';
import 'package:zylu/view/screens/add_details/widgets/loader.dart';
import 'package:zylu/view/screens/add_details/widgets/my_textformfield.dart';
import 'package:zylu/view_model/providers/gender.dart';
import 'package:zylu/view_model/providers/image_provider.dart';
import 'package:zylu/view_model/providers/loader.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen(
      {Key? key,
      this.edit = false,
      this.active = false,
      this.isMale = false,
      this.salary = 0,
      this.name = "",
      this.workingYear = 0,
      this.image = "",
      this.docId = ""})
      : super(key: key);

  final bool edit;
  final String name;
  final int salary;
  final int workingYear;
  final bool? isMale;
  final bool? active;
  final String image;
  final String docId;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _workingYearsController = TextEditingController();

  final TextEditingController _salaryController = TextEditingController();

  // final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit) {
      final pGender = Provider.of<GenderProvider>(context, listen: false);
      _nameController.text = widget.name;
      _salaryController.text = widget.salary.toString();
      _workingYearsController.text = widget.workingYear.toString();
      if (widget.isMale == true) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          pGender.changeMaleGender(true);
          pGender.changeFemaleGender(false);
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          pGender.changeMaleGender(false);
          pGender.changeFemaleGender(true);
        });
      }
      if (widget.active == true) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          pGender.changeActiveStatus(true);
          pGender.changeInactiveStatus(false);
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          pGender.changeActiveStatus(false);
          pGender.changeInactiveStatus(true);
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameController.dispose();
    _workingYearsController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pLoader = Provider.of<LoadingProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity,55),
          child: Stack(
            children: [
              AppBar(
                backgroundColor: kPrimaryColor,
                leading: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    pLoader.changeLoadingStatus(false);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                title: const Text(
                  "Add an employee",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
          Positioned(child: Consumer<LoadingProvider>(
            builder: (context,loading,child)=>
                Visibility(
                  visible:loading.status ,
                  child: Container(
                    height: 55,
                    width:  MediaQuery.of(context).size.width,
                    color: Colors.black.withOpacity(0.5),

                  ),
                ),
          )),
            ],
          ),
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              children: [
                Center(
                  child: CustomImageDisplay(
                    photoUrl: widget.edit ? widget.image : "",
                    kBorderRadius: 20,
                    kPrimaryBoxColor: Colors.green,
                    context: context,
                    height: 200,
                    width: 200,
                    color: Colors.black,
                    boxColor: kFormColor,
                  ),
                ),
                const SizedBox(
                  height: kDPSizedBoxHeightAfterWidget,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      MyTextFormField(
                          isNumber: false,
                          headingText: "Employee Name",
                          controller: _nameController,
                          hintText: "Enter employee name",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (_nameController.text.isEmpty) {
                              return "This field is required";
                            } else
                              return null;
                          }),
                      MyTextFormField(
                          headingText: "Working Years",
                          isNumber: true,
                          controller: _workingYearsController,
                          hintText: "Enter the number of years",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (_nameController.text.isEmpty) {
                              return "This field is required";
                            } else
                              return null;
                          }),
                      Consumer<GenderProvider>(
                        builder: (context, gender, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TickSide(
                              text: 'Male',
                              // theme: theme,
                              tickValue: gender.isMale,
                              onChanged: (value) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                gender.changeMaleGender(value);
                                if (value == true) {
                                  if (gender.isFemale == true) {
                                    gender.changeFemaleGender(false);
                                  }
                                }
                              },
                            ),
                            TickSide(
                              text: 'Female',
                              // theme: theme,
                              tickValue: gender.isFemale,
                              onChanged: (value) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                gender.changeFemaleGender(value);
                                if (value == true) {
                                  if (gender.isMale == true) {
                                    gender.changeMaleGender(false);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: kDPSizedBoxHeightAfterWidget,
                      ),
                      MyTextFormField(
                          isNumber: true,
                          headingText: "Salary",
                          controller: _salaryController,
                          hintText: "Enter the salary",
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (_nameController.text.isEmpty) {
                              return "This field is required";
                            } else
                              return null;
                          }),
                      Consumer<GenderProvider>(
                        builder: (context, gender, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TickSide(
                              text: 'Active',
                              // theme: theme,
                              tickValue: gender.active,
                              onChanged: (value) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                gender.changeActiveStatus(value);
                                if (value == true) {
                                  if (gender.inActive == true) {
                                    gender.changeInactiveStatus(false);
                                  }
                                }
                              },
                            ),
                            TickSide(
                              text: 'Inactive',
                              // theme: theme,
                              tickValue: gender.inActive,
                              onChanged: (value) {
                                FocusScope.of(context).requestFocus(FocusNode());
                                gender.changeInactiveStatus(value);
                                if (value == true) {
                                  if (gender.active == true) {
                                    gender.changeActiveStatus(false);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: kDPSizedBoxHeightAfterWidget,
                      ),
                      CupertinoButton(
                          color: kPrimaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(widget.edit ? "Update" : "Upload")
                            ],
                          ),
                          onPressed: () async {
                            final form = _formKey.currentState!;

                            if (form.validate()) {
                              FocusScope.of(context).unfocus();
                              final pGender = Provider.of<GenderProvider>(context, listen: false);
                              pLoader.changeLoadingStatus(true);
                              try {
                                if (!widget.edit) {
                                  EmployeeData employeeData = EmployeeData(
                                      name: _nameController.text,
                                      gender: pGender.isMale == true ? true : false,
                                      workingYears: int.parse(_workingYearsController.text),
                                      active: pGender.active == true ? true : false,
                                      image: "",
                                      salary: int.parse(_salaryController.text));

                                  if (Provider.of<MyImageProvider>(context, listen: false).getProfilePic() !=
                                      null) {
                                    employeeData.image = await uploadImage(
                                      context,
                                      // employeeData,
                                    );
                                  }
                                  FirebaseApi.setEmployeeData(
                                    employeeData,
                                  );
                                }
                                else{
                                  if (Provider.of<MyImageProvider>(context, listen: false).getProfilePic() !=
                                      null) {
                                    String image = await uploadImage(
                                      context,
                                      // image,
                                    );

                                    FirebaseApi.updateEmployeeImage(widget.docId, image);
                                  }
                                    if(widget.isMale!=pGender.isMale){
                                      FirebaseApi.updateEmployeeGender(widget.docId, pGender.isMale==true ? true : false);
                                    }
                                    if(widget.active!=pGender.active){
                                      FirebaseApi.updateEmployeeActive(widget.docId, pGender.active==true ? true : false);
                                    }
                                    if(widget.name!=_nameController.text){
                                      FirebaseApi.updateEmployeeName(widget.docId, _nameController.text);
                                    }
                                    if(widget.salary!=int.parse(_salaryController.text)){
                                      FirebaseApi.updateEmployeeSalary(widget.docId, int.parse(_salaryController.text));
                                    }
                                    if(widget.workingYear!=int.parse(_workingYearsController.text)){
                                      print('hit');
                                      FirebaseApi.updateEmployeeWorkYear(widget.docId, int.parse(_workingYearsController.text));
                                    }

                                }
                              } catch (e) {
                                pLoader.changeLoadingStatus(false);
                              }
                              pLoader.changeLoadingStatus(false);
                              Navigator.pop(context);
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
            const Loader()
          ],
        ),
      ),
    );
  }

  Future<String> uploadImage(
    BuildContext context,
  ) async {
    var getImageProvider = Provider.of<MyImageProvider>(context, listen: false);
    final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    Reference ref = FirebaseStorage.instance.ref().child('photos').child("image1" + time.toString() + '.jpg');
    UploadTask task = ref.putFile(File(getImageProvider.getProfilePic()!.path));
    TaskSnapshot storageTaskSnapshot = await task.whenComplete(() => print('completed'));
    String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}

class TickSide extends StatelessWidget {
  const TickSide({
    required this.text,
    required this.tickValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final String text;
  final bool? tickValue;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: const BoxDecoration(color: kFormColor, borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 20,
          ),
          Checkbox(
              side: const BorderSide(
                // set border color here
                color: Colors.blue,
              ),
              activeColor: kPrimaryColor.shade400,
              focusColor: Colors.grey,
              checkColor: Colors.white,
              value: tickValue,
              onChanged: onChanged)
        ],
      ),
    );
  }
}
