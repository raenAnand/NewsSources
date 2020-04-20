import 'package:flutter/cupertino.dart';
import 'package:newssources/models/sources_model.dart';
import 'package:http/http.dart' as http;
import 'package:newssources/models/article.dart';
import 'dart:convert';

class sources{
  Future<List<SourcesModel>> getCatagories() async{

    List<SourcesModel> myCategories = List<SourcesModel>();
    SourcesModel sourcesModel;
    String url= "https://newsapi.org/v2/sources?&country=us&apiKey=dab692e85b0f4cdbbcffe906ef11d171";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=='ok'){
      jsonData["sources"].forEach((element){
        sourcesModel = new SourcesModel();
        sourcesModel.sourceId = element["id"];
        sourcesModel.sourceName = element["name"];
        myCategories.add(sourcesModel);
      });
    }
    return myCategories;

  }
}
