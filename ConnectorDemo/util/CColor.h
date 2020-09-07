//
//  CColor.h
//  moorgeniPad
//
//  Created by moorgen on 2017/3/15.
//  Copyright © 2017年 moorgen. All rights reserved.
//
/**
 *  此.h用来放常用色值
 **/
#ifndef CColor_h
#define CColor_h

#define colorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define colorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define colorBlue HexRGB(0x438AF3)

/**
 *  字体主色调
 **/
#define colorTextMain      colorFromRGBA(0x5A,0x5A,0x5A,1)

/**
 *  输入框字体颜色
 **/

#define colorTFText      colorFromRGBA(0x60,0x60,0x60,1)

#define colorFor32C5FF HexRGB(0x32C5FF)
#define colorFor73E0F9 HexRGB(0x73E0F9)

/**
 *  背景色
 **/
#define colorBackGround HexRGB(0xe9ecf0)

/**
 *  7E91AD
 **/
#define colorFor7E91AD HexRGB(0x7E91AD)

/**
 *  438AF3
 **/
#define colorFor438AF3 HexRGB(0x438AF3)

/**
 *  29456F
 **/
#define colorFor29456F HexRGB(0x29456F)

/**
 *  2E4972
 **/
#define colorFor2E4972 HexRGB(0x2E4972)

/**
 *  E9ECF0
 **/
#define colorForE9ECF0 HexRGB(0xE9ECF0)
#define colorForF3F6FF HexRGB(0xF3F6FF)

/**
 *  Cell高亮
 **/
#define colorForCellHighlighted colorFromRGBA(0xff,0xff,0xff,0.7)

#endif /* CColor_h */
