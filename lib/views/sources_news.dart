import 'package:flutter/material.dart';
import 'package:newssources/helper/news.dart';
import 'package:newssources/helper/widgets.dart';

//class designed to fetch news from particular source

class SourcesNews extends StatefulWidget {

  final String newsCategory;

  SourcesNews({this.newsCategory});

  @override
  _SourcesNewsState createState() => _SourcesNewsState();
}

class _SourcesNewsState extends State<SourcesNews> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForSource news = NewsForSource();//function defined in news.dart to fetch news for each sources.
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }
  //building news for the a particular Source.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
            child: Container(
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
            ),
        ),
      ),
    );
  }
}
