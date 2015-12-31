//
//  PJFrameParserConfig.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/29.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJFrameParserConfig.h"

@implementation PJFrameParserConfig

- (instancetype)init {
    if (self = [super init]) {
        self.width = MAIN_WIDTH;
        self.fontSize = [UIFont systemFontSize];
        self.lineSpace = 8.0f;
        self.textColor = [UIColor blackColor];
    }
    return  self;
}

@end
