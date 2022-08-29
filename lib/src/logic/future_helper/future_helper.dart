import 'package:engagementwallet/src/utils/colors.dart';
import 'package:flutter/material.dart';

class FutureHelper<T> extends StatelessWidget {
  final Future<T> task;
  final Future<void> Function()? onRefresh;
  final Widget? whenEmpty;
  final Widget? Function(BuildContext context, T data) builder;
  final Function? actionWhenData;
  final Widget loader;
  final Widget? noData;

  const FutureHelper(
      {Key? key, required this.task,
        this.whenEmpty,
        required this.builder,
        this.actionWhenData,
        this.onRefresh,
        required this.loader,
        this.noData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: task,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          debugPrint('data is in the home ${snapshot.data}');
          if (actionWhenData != null) {
            debugPrint('something');
            actionWhenData!(snapshot.data);
          }
          if (onRefresh != null) {
            return RefreshIndicator(
            backgroundColor: secondaryColor,
            color: Colors.white,
            onRefresh: onRefresh!,
            child: builder(context, snapshot.data!)!,
          );
          } else {
            return builder(context, snapshot.data!)!;
          }
        } else if (snapshot.hasError) {
          debugPrint('error: ${snapshot.error}');
          return snapshot.error.toString().startsWith('S')
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'No Internet Connection',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Check your internet connection settings and try again.',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
              : noData ?? const SizedBox();
        }
        // By default, show a loading spinner.
        return loader;
      },
    );
  }
}

