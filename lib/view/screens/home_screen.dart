// import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zylu/model/employee_data.dart';
import 'package:zylu/model/firebase_api.dart';
import 'package:zylu/view/css/css.dart';
import 'package:zylu/view/screens/add_details/detail_screen.dart';
import 'package:zylu/view_model/providers/image_provider.dart';
import 'package:zylu/view_model/providers/loader.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFECECEC),
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title:const Text( 'Zylu Employees'),

        ),
        body: StreamBuilder(
            stream: FirebaseApi.getEmployeeData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.docs[index];
                      EmployeeData employeeData = FirebaseApi.fromJson(data);

                      return Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                height: 10,
                                width: 50,
                                // color: Colors.red,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.all(5),
                                // height: 50,
                                // width: 50,

                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.15,
                                      height: 30,
                                      // color: Colors.greenAccent,
                                    ),
                                    Card(
                                      margin: EdgeInsets.zero,
                                      shape: const RoundedRectangleBorder(borderRadius: kBorderRadius),
                                      elevation: 4,
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: screenWidth * 0.7,
                                            padding: const EdgeInsets.only(
                                                top: 18, bottom: 18, right: 15, left: 50),
                                            decoration: const BoxDecoration(
                                                color: Colors.white, borderRadius: kBorderRadius),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: screenWidth * 0.45,
                                                      // color: Colors.red,
                                                      child: AutoSizeText(
                                                        employeeData.name,
                                                        maxFontSize: 19,
                                                        minFontSize: 17,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            overflow: TextOverflow.ellipsis,
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Text(
                                                      "CTC - ${employeeData.salary}",
                                                      style: const TextStyle(
                                                          fontSize: 14, color: Colors.black54),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Text(
                                                      "working years - ${employeeData.workingYears}",
                                                      style:
                                                          const TextStyle(fontSize: 16, color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            right: -5,
                                            top: 0,
                                            child: IconButton(
                                                onPressed: () {
                                                  Provider.of<MyImageProvider>(context, listen: false)
                                                      .changeProfilePic(null);

                                                  Provider.of<LoadingProvider>(context, listen: false)
                                                      .changeLoadingStatus(false);

                                                  Navigator.push(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) => DetailScreen(
                                                                name: employeeData.name,
                                                                edit: true,
                                                                salary: employeeData.salary,
                                                                isMale: employeeData.gender,
                                                                active: employeeData.active,
                                                                workingYear: employeeData.workingYears,
                                                                image: employeeData.image,
                                                                docId: data.id,
                                                              )));
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.black38,
                                                )),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              left: 10,
                              top: 10,
                              child: Container(
                                height: screenWidth * 0.25,
                                width: screenWidth * 0.25,
                                decoration: BoxDecoration(
                                    color: employeeData.active == true && employeeData.workingYears > 5
                                        ? Colors.green.shade500
                                        : Colors.lightBlueAccent.shade100,
                                    borderRadius: kBorderRadius,
                                    image: DecorationImage(
                                        image: NetworkImage(employeeData.image
                                            ),
                                        fit: BoxFit.cover),
                                    boxShadow:const [
                                      BoxShadow(
                                          color:
                                          Colors.black38,
                                          blurRadius: 10,
                                          spreadRadius: -3,
                                          offset: Offset(0, 12))
                                    ]),
                              )),
                          Positioned(
                              bottom: 30,
                              right: 10,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: kBorderRadius,
                                    color: employeeData.active == true && employeeData.workingYears > 5
                                        ? Colors.green.shade500
                                        : Colors.lightBlueAccent,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 15,
                                          spreadRadius: -6,
                                          offset: Offset(0, 12))
                                    ]),
                                child: Icon(
                                  employeeData.gender == true ? Icons.male : Icons.female,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )),
                          Positioned(
                              top: 14,
                              right: 30,
                              child: Text(
                                employeeData.active == true ? "Active" : "Inactive",
                                style: TextStyle(
                                    color: employeeData.active == true && employeeData.workingYears > 5
                                        ? Colors.green.shade500
                                        : employeeData.active == true
                                            ? Colors.blue
                                            : Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      );
                    });
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Provider.of<MyImageProvider>(context, listen: false).changeProfilePic(null);
            Provider.of<LoadingProvider>(context, listen: false).changeLoadingStatus(false);
            Navigator.push(context, CupertinoPageRoute(builder: (context) => DetailScreen()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
