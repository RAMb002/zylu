import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zylu/view/css/css.dart';
import 'package:zylu/view_model/providers/loader.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(child: Consumer<LoadingProvider>(
      builder: (context,loading,child)=>
          Visibility(
            visible:loading.status ,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width:  MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
    ));
  }
}
