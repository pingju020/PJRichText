//
//  PublicDefine.h
//  PJRichText
//
//  Created by yangjuanping on 15/11/17.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h


// 判断系统版本号
#define  OS_ABOVE_IOS8_2               ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.2)
#define  OS_ABOVE_IOS7                 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 1 : 0)
#define  OS_ABOVE_IOS6                 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define  OS_ABOVE_IOS4                 ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0)


// 颜色处理的宏：
//16进制色值参数转换
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// 添加系统屏幕宽高定义
#define SCREENWIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREENHEIGHT ([UIScreen mainScreen].bounds.size.height)

#define is_iOS_7 ([[[[[UIDevice currentDevice]systemVersion]componentsSeparatedByString:@"."]objectAtIndex:0]intValue]>=7)
#define is_iPhone4_4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone6_plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define is_iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#endif /* PublicDefine_h */
