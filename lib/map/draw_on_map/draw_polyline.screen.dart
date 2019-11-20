import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_fluttify_demo/utils/misc.dart';
import 'package:amap_fluttify_demo/widgets/setting.widget.dart';
import 'package:decorated_flutter/decorated_flutter.dart';
import 'package:flutter/material.dart';

final _networkIcon = Uri.parse(
    'https://w3.hoopchina.com.cn/30/a7/6a/30a76aea75aef69e4ea0e7d3dee552c7001.jpg');
final _assetsIcon = Uri.parse('images/arrow.png');

class DrawPolylineScreen extends StatefulWidget {
  DrawPolylineScreen();

  factory DrawPolylineScreen.forDesignTime() => DrawPolylineScreen();

  @override
  _DrawPolylineScreenState createState() => _DrawPolylineScreenState();
}

class _DrawPolylineScreenState extends State<DrawPolylineScreen> {
  AmapController _controller;
  Polyline _currentPolyline;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('绘制线')),
      body: DecoratedColumn(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: AmapView(
              onMapCreated: (controller) async {
                _controller = controller;
                if (await requestPermission()) {
                  await controller.showMyLocation(false);
                }
              },
            ),
          ),
          Flexible(
            child: DecoratedColumn(
              divider: kDividerTiny,
              children: <Widget>[
                ListTile(
                  title: Center(child: Text('添加线')),
                  onTap: () async {
                    _currentPolyline =
                        await _controller?.addPolyline(PolylineOption(
                      latLngList: [
                        LatLng(39.999391, 116.135972),
                        LatLng(39.898323, 116.057694),
                        LatLng(39.900430, 116.265061),
                        LatLng(39.955192, 116.140092),
                      ],
                      width: 10,
                      strokeColor: Colors.green,
                    ));
                  },
                ),
                ListTile(
                  title: Center(child: Text('添加线(自定义纹理)')),
                  onTap: () async {
                    await _currentPolyline?.remove();
                    _currentPolyline =
                        await _controller?.addPolyline(PolylineOption(
                      latLngList: [
                        LatLng(39.999391, 116.135972),
                        LatLng(39.898323, 116.057694),
                        LatLng(39.900430, 116.265061),
                        LatLng(39.955192, 116.140092),
                      ],
                      width: 10,
                      customTexture: _assetsIcon,
                      imageConfig: createLocalImageConfiguration(context),
                    ));
                  },
                ),
                ListTile(
                  title: Center(child: Text('删除折线')),
                  onTap: () => _currentPolyline?.remove(),
                ),
                DiscreteSetting(
                  head: '选择始末端样式',
                  options: [
                    '普通头',
                    '扩展头',
                    '箭头',
                    '圆形头',
                  ],
                  onSelected: (value) async {
                    LineCapType type;
                    switch (value) {
                      case '普通头':
                        type = LineCapType.Butt;
                        break;
                      case '扩展头':
                        type = LineCapType.Square;
                        break;
                      case '箭头':
                        type = LineCapType.Arrow;
                        break;
                      case '圆形头':
                        type = LineCapType.Round;
                        break;
                    }
                    await _currentPolyline?.remove();
                    _currentPolyline =
                        await _controller?.addPolyline(PolylineOption(
                      latLngList: [
                        LatLng(39.999391, 116.135972),
                        LatLng(39.898323, 116.057694),
                        LatLng(39.900430, 116.265061),
                        LatLng(39.955192, 116.140092),
                      ],
                      width: 10,
                      strokeColor: Colors.green,
                      lineCapType: type,
                    ));
                  },
                ),
                DiscreteSetting(
                  head: '选择连接点样式',
                  options: [
                    '斜面连接点',
                    '斜接连接点',
                    '圆角连接点',
                  ],
                  onSelected: (value) async {
                    LineJoinType type;
                    switch (value) {
                      case '斜面连接点':
                        type = LineJoinType.Bevel;
                        break;
                      case '斜接连接点':
                        type = LineJoinType.Miter;
                        break;
                      case '圆角连接点':
                        type = LineJoinType.Round;
                        break;
                    }
                    await _currentPolyline?.remove();
                    _currentPolyline =
                        await _controller?.addPolyline(PolylineOption(
                      latLngList: [
                        LatLng(39.999391, 116.135972),
                        LatLng(39.898323, 116.057694),
                        LatLng(39.900430, 116.265061),
                        LatLng(39.955192, 116.140092),
                      ],
                      width: 10,
                      strokeColor: Colors.green,
                      lineJoinType: type,
                    ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
