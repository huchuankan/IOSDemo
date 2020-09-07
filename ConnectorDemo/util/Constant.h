//
//  Header.h
//  iCurtain
//
//  Created by moorgen on 2017/6/27.
//  Copyright © 2017年 dooya. All rights reserved.
//
/**
 *  此.h用来放常用杂项宏
 **/
#ifndef Header_h
#define Header_h


//#define DooyaSDK [DooyaAppClient SharedInstance]
#define BridgeSDK [BridgeManager SharedInstance]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/**
 *  最长等待时间
 **/
#define maxWaitTime   15


/**
 *  设备刷新状态时间
 **/
#define deviceDelaytime   0.5

#define CellLeftMargin 14

#define CellContentLeftMargin 14

#define CellShadowTop 4

#define CellShadowBottom 12

#define CellShadowLeft 8

#define AddBtnHeight 56

#define AddBtnWidth 56

#define AddBtnBottom 24

#define DelayTime 1

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#define Scale375 KScreenWidth/375.0

#define Scale667 KScreenHeight/(812-34.0)

#define Scale812 KScreenHeight/(812-34.0)

#define OraginX(view) view.frame.origin.x
#define OraginY(view) view.frame.origin.y
#define SizeHeight(view) view.frame.size.height
#define SizeWidth(view) view.frame.size.width

//图标最大索引值
#define MaxRoomIconIndex            15
#define MaxLocationIconIndex        9
#define MaxSceneIconIndex           18
#if BlocBlinds
    #define MaxDeviceIconIndex          18
#else
    #define MaxDeviceIconIndex          16
#endif
#define LBXScan_Define_Native  //下载了native模块
//#define LBXScan_Define_ZXing   //下载了ZXing模块
//#define LBXScan_Define_ZBar   //下载了ZBar模块
#define LBXScan_Define_UI     //下载了界面模块

#define SliderTouchType (UIControlEventTouchUpInside|UIControlEventTouchUpOutside)

#define WifiPassword @"WifiPassword"

#endif /* Header_h */


//
//  CSize.h
//  iCurtain
//
//  Created by moorgen on 2017/6/27.
//  Copyright © 2017年 dooya. All rights reserved.
//

/**
 *  此.h用来放常用宽高
 **/
#ifndef CSize_h
#define CSize_h

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

#define KScreenHeight [UIScreen mainScreen].bounds.size.height

/**
 *  导航栏及状态栏高度和
 */
#define KiPhoneX (((int)((KScreenHeight/KScreenWidth)*100) == 216)?YES:NO)
//判断是否为 iPhoneXS  Max，iPhoneXS，iPhoneXR，iPhoneX
//#define KiPhoneX ([UIScreen mainScreen].bounds.size.height==812)
#define KNavigationBarHeight 44 //自定义高度
#define KStatusBarH (KiPhoneX?44:20)

#define KStatusNavBarHeight  (KNavigationBarHeight+KStatusBarH)

#define Bottom34 (34*floor(KScreenHeight/812))

#define ContentHeight (KScreenHeight - Bottom34 - KStatusNavBarHeight)


/**
 *  TabBar高度
 */
#define KTabBarHeight  48

/**
 *  高度缩放系数
 */
#define hightCoefficient        [UIScreen mainScreen].bounds.size.height/667.0

/**
 *  宽度缩放系数
 */
#define widthCoefficient        [UIScreen mainScreen].bounds.size.width/375.0

/**
 *  view除去导航栏之后的高度
 **/
#define viewheight              (self.view.frame.size.height-64)

/**
 *  主Cell高度
 */
#define hightMainCell    112.f

/**
 *  折叠cell默认高度
 **/
#define hightDefaultFoldCell  136.f

/**
 *  折叠cell两倍高度
 **/
#define hightDoubleFoldCell 248.f

/**
 *  折叠cell三倍高度
 **/
#define hightTrebleFoldCell 360.f

#define hightAutoCell    80

#define hightSpaceSection   24

/**
 *  子Cell高度
 */
#define hightsubCell     44

/**
 *  Cell头部视图高度
 */
#define hightCellHeaderView   41

/**
 *  Cell属性高度（名字，图片）
 */
#define hightAttributeCell   50

/**
 *  Cell设备高度
 */
#define hightDeviceCell   64

/**
 *  Cell设备两倍展开高度
 */
#define hightDoubleDeviceCell   178

/**
 *  Cell设备三倍展开高度
 */
#define hightTrebleDeviceCell   290

/**
 *  左边边距距离
 */
#define kLeftMargin 14

/**
 左边内边距
 */
#define KLeftPadding 14

/**
 *  去除左右留白后的宽度
 **/
#define kClearWidth (KScreenWidth-2*kLeftMargin)


#define KScaleHeight (KScreenHeight/667.0)

#define KScaleWidth  (KScreenWidth/375.0)

#define KScaleMinInWidthAndHeight MIN(KScaleHeight, KScaleWidth)

#define KBtnHeight (42*KScaleHeight)

#define KBtnBottom (64*KScaleMinInWidthAndHeight)


#endif /* CSize_h */
