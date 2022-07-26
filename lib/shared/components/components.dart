import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';import 'package:news/shared/Bloc/cubit.dart';

import '../../modules/web_view.dart';

Widget buildArticleItem(article, context, index) {

  Future<void>? _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await UrlLauncherPlatform.instance.canLaunch(url)) {
      await UrlLauncherPlatform.instance.launch(
        url,
        useSafariVC: false,
        useWebView: false,
        enableJavaScript: false,
        enableDomStorage: false,
        universalLinksOnly: false,
        headers: <String, String>{},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  return Container(
      color: Platform.isWindows && NewsCubit.get(context).selectedItem == index
          ? Colors.deepOrange
          : null,
      child: InkWell(
        onDoubleTap: () {
          if (Platform.isWindows) {
            NewsCubit.get(context).selectedCategoryItem(index);
            _launched = _launchInBrowser(article['url']).then((value) => _launched).catchError((onError){
              pint(onError.toString());
            });
          } else {
            navigateTo(
                context,
                WebViewExample(
                  url: '${article['url']}',
                ));
          }
        },
        onTap: () {
          if (Platform.isWindows) {
            NewsCubit.get(context).selectedCategoryItem(index);

          } else {
            navigateTo(
                context,
                WebViewExample(
                  url: '${article['url']}',
                ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 8.0, right: 8.0),
          child: Row(
            children: [
              Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: article['urlToImage'] != '' &&
                            article['urlToImage'] != null
                        ? NetworkImage('${article['urlToImage']}')
                        : const AssetImage('assets/images/imageBroken.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: SizedBox(
                  height: 130.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Text(
                          '${article['title']}',
                          style: Theme.of(context).textTheme.subtitle2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${article['publishedAt']}',
                        style:
                            const TextStyle(fontSize: 10.0, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
}



Widget articleBuilder(data, context, {bool? search = false}) =>
    ConditionalBuilder(
      condition: data.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItem(data[index], context, index),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
        ),
        itemCount: data.length,
      ),
      fallback: (context) => search!
          ? Container()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Future navigate2(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

void pint(String input)
{
  debugPrint(input);
}