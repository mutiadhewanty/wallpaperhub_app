import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperhub_app/data/data.dart';
import 'package:wallpaperhub_app/widgets/widget.dart';
import '../model/categories_model.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];

  getTrendingWallpapers() async {
    var response = await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=15&page=1'),
    headers: {
      "Authorization" : apiKey
    });
    // print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      print(element);
    });
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: BrandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xfff5f8fd),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 24),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Search Wallpaper',
                            border: InputBorder.none),
                      ),
                    ),
                    Icon(Icons.search)
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        title: categories[index].categorieName,
                        imgUrl: categories[index].imgUrl,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String? imgUrl, title;
  CategoriesTile({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl!,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              )),
          Container(
            color: Colors.black26,
            height: 50, width: 100,
            alignment: Alignment.center,
            child: Text(title!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
            ))
        ],
      ),
    );
  }
}
