//
//  PJCoreTextData.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/29.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface PJCoreTextData : NSObject
@property (nonatomic,assign) CTFrameRef ctFrame;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) NSArray *imageArray;

-(void)DrawFrame:(CGContextRef)context;
@end
