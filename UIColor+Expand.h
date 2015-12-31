//
//  UIColor+Expand.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/30.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Expand)
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
@end
