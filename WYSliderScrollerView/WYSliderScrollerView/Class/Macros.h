//
//  Macros.h
//  WYSliderScrollerView
//
//  Created by 王王 on 16/1/20.
//  Copyright © 2016年 Jason. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IOS7_STATUS_BAR_HEGHT (IS_IOS7 ? 20.0f : 0.0f)



#pragma mark --屏幕
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define viewHeight HEIGHT-IOS7_STATUS_BAR_HEGHT



#pragma mark --颜色
#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]



#endif /* Macros_h */
