//
//  PJFrameParser.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/29.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PJCoreTextData.h"
#import "PJFrameParserConfig.h"

@interface PJFrameParser : NSObject

/* 对整段富文本文字进行排版 */
+(PJCoreTextData*)parseRichText:(NSString *)text config:(PJFrameParserConfig *)config;

/* 自定义自己的排版 */
+ (PJCoreTextData *)parseTemplateFile:(NSString *)path config:(PJFrameParserConfig *)config;

/* 处理添加了文字属性的数组，可以处理的数组格式如下 */
/*
 {
 }
 */
+(PJCoreTextData*)parseRichTextArr:(NSArray *)arr config:(PJFrameParserConfig *)config;
@end
