//
//  GoogleMapVC.h
//  ConnectorDemo
//
//  Created by huck on 2020/9/19.
//  Copyright © 2020 huck. All rights reserved.
//
// 因为谷歌地地图pod包太大，所以关闭了，要使用，就在Podfile中吧谷歌地图的pod引用打开，然后运行 pod update，下载谷歌地图三方的包
// 然后 选择BlocBlinds这个Target  就可以运行谷歌地图
// 注意：自己申请googleAPI后，需要在“API库和服务”中，开启Geocoding API 和MAPs SDK for ios 这两个服务，才能在到时候界面中显示地图
//简书： https://www.jianshu.com/p/fa9474400f9a

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN


@interface GoogleMapVC : BaseVC


@end

NS_ASSUME_NONNULL_END
