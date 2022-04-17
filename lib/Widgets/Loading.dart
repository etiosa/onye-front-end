

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        height: MediaQuery.of(context).size.height / 1.8,
        padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Expanded(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 48,
                            height: 48,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 1.0),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 10.0,
                                color: Colors.white,
                              ),
                              Container(
                                width: double.infinity,
                                height: 10.0,
                                color: Colors.white,
                              ),
                              Container(
                                width: double.infinity,
                                height: 10.0,
                                color: Colors.white,
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                  )))
        ]));
  }
}
