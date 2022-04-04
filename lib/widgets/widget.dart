import 'package:flutter/material.dart';

import '../model/wallpaper_model.dart';

Widget BrandName(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,

    children: <Widget>[
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
      ),
      Text(
        "Hub",
        style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
      )
    ],
  );
}

Widget wallpapersList(List<WallpaperModel> wallpapers, context){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: Container(
            child: Image.network(wallpaper.src!.portrait!),
          ));
      }).toList(),
      ),
  );
}