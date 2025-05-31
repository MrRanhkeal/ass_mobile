import 'package:flutter/material.dart';
import 'package:flutter_coffee/enum/status.dart';
import 'package:flutter_coffee/screens/home/view_model/home_view_model.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  var viewModel = Get.put(HomeViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text(
            "News",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  viewModel.logout();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 120,
                child: Obx(() {
                  switch (viewModel.loadingCategoryStatus.value) {
                    case Status.loading:
                      return Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                        ),
                      );
                    case Status.success:
                      return ListView.builder(
                        itemBuilder: (BuildContext context, index) {
                          var category =viewModel.categoriesList[index];
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(child: Text("${category.name}",style: TextStyle(color: Colors.white),)),
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: viewModel.categoriesList.length,
                      );
                    case Status.error:
                      return Center(
                        child: Text("ERRO"),
                      );
                  }
                }),
              )
            ],
          ),
        ));
  }
}
