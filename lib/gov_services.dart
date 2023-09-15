import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CovServices extends StatefulWidget {
  final String url;

  const CovServices({Key? key, required this.url}) : super(key: key);

  @override
  State<CovServices> createState() => _CovServicesState();
}

class _CovServicesState extends State<CovServices> {
  InAppWebViewController? _appWebViewController;
  PullToRefreshController? pullToRefreshController;
  TextEditingController search = TextEditingController();
  double progress = 0;

  @override
  void initState() {
    pullToRefreshController = PullToRefreshController(
      onRefresh: () {
        _appWebViewController?.reload();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: search,
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                      onPressed: () {
                        // _appWebViewController?.goBack();
                        _appWebViewController?.goBack();
                      },
                      icon: Icon(Icons.arrow_back)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchOnWebView();
                    },
                    icon: Icon(Icons.send),
                  )),
              onFieldSubmitted: (value) {
                searchOnWebView();
              },
            ),
            if (progress != 1) LinearProgressIndicator(value: progress),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                onWebViewCreated: (controller) {
                  _appWebViewController = controller;
                },
                pullToRefreshController: pullToRefreshController,
                onLoadStart: (controller, url) {
                  search.text = url.toString();
                },
                onProgressChanged: (controller, progress) {
                  print(progress);

                  this.progress = progress / 100;
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchOnWebView() {
    String searchText = "https://www.google.com/search?q=${search.text}";
    _appWebViewController?.loadUrl(
        urlRequest: URLRequest(url: Uri.parse(searchText)));
    // FocusScope.of(context).nextFocus();
    FocusScope.of(context).unfocus();
  }
}
