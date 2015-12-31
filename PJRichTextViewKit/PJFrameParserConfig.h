//
//  PJFrameParserConfig.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/29.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PJFrameParserConfig : NSObject

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,assign) CGFloat lineSpace;
@property (nonatomic,strong) UIColor *textColor;

@end
