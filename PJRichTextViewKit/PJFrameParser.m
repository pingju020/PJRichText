//
//  PJFrameParser.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/29.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJFrameParser.h"
#import "PJCoreTextImageData.h"
#import "PJRichTextParser.h"

@implementation PJFrameParser

+ (PJCoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(PJFrameParserConfig *)config {
    // 创建CTFramesetterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    // 获得要绘制区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    // 生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    // 将生成好的CTFrameRef实例和计算好的绘制高度保存到CoreTextData实例中，并返回
    PJCoreTextData *data = [[PJCoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    
    // 内存释放
    CFRelease(frame);
    CFRelease(framesetter);
    
    return data;
}

+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter config:(PJFrameParserConfig *)config height:(CGFloat)height {
    
    NSLog(@"createFrameWithFramesetter width:%f, height%f", config.width, height);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}

/* 自定义自己的排版 */
+ (PJCoreTextData *)parseTemplateFile:(NSString *)path config:(PJFrameParserConfig *)config {
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    if (array) {
        NSAttributedString *content  =  [[PJRichTextParser getInstance]ParserArry:array];
        PJCoreTextData *data = [self parseAttributedContent:content config:config];
        data.imageArray = [[PJRichTextParser getInstance] getImages];
        return data;
    }
    return nil;
}

+(PJCoreTextData*)parseRichText:(NSString *)text config:(PJFrameParserConfig *)config{
    //NSMutableArray *imageArray = [NSMutableArray array];
    NSAttributedString *content = [[PJRichTextParser getInstance]ParserRichText:text];
    PJCoreTextData *data = [self parseAttributedContent:content config:config];
    data.imageArray = [[PJRichTextParser getInstance] getImages];
    return data;
}

+(PJCoreTextData*)parseRichTextArr:(NSArray *)arr config:(PJFrameParserConfig *)config{
    NSAttributedString *content = [[PJRichTextParser getInstance]ParserArry:arr];
    PJCoreTextData *data = [self parseAttributedContent:content config:config];
    data.imageArray = [[PJRichTextParser getInstance] getImages];
    return data;
}

@end
