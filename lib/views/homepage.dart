import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newssources/helper/data.dart';
import 'package:newssources/helper/widgets.dart';
import 'package:newssources/models/sources_model.dart';
import 'package:newssources/views/sources_news.dart';
import '../helper/news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading;
  var newslist;
  List<String> data = ['Headlines'];
  List<String> id = ['none'];
  List<SourcesModel> categories = List<SourcesModel>();

  void getNews() async {
    News news = News();
    super.initState();
    sources s = sources();
    categories = await s.getCatagories();
    for(var i=0;i<categories.length;i++){
      data.add(categories[i].sourceName);
      id.add(categories[i].sourceId);
    }
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    int initPosition = 0;
    return Scaffold(
      appBar: MyAppBar(),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              ): CustomTabView(
          initPosition: initPosition,
          itemCount: data.length,
          tabBuilder: (context, index) => Tab(text: data[index]),
          pageBuilder: (context, index) {
            if(index==0){
              return Container(
                margin: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: newslist.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsTile(
                        imgUrl: newslist[index].urlToImage ?? "",
                        title: newslist[index].title ?? "",
                        desc: newslist[index].description ?? "",
                        content: newslist[index].content ?? "",
                        posturl: newslist[index].articleUrl ?? "",
                      );
                    }),
              );
            }
            else{
              return Center(child: SourcesNews(
                newsCategory: id[index],
              ),);
            }
            },
        ),
      ),
    );
  }
}

