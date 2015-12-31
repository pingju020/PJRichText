//
//  PJRichTextParserForTxt.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/30.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJRichTextParserForTxt.h"

@implementation PJRichTextParserForTxt

-(NSAttributedString *)parseItermFromNSDictionary:(NSDictionary*)dic{
    
    [super parseItermFromNSDictionary:dic];
    
    NSMutableDictionary *attributes = (NSMutableDictionary *)[self attributesWithDefault];
    
    UIColor *color = [self colorFromTemplate:dic[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    
    // 获取字体颜色和大小，如果某一个值未获取到，则没取到的值使用默认字体对应的值
    CGFloat fontSize = [dic[@"size"] floatValue];
    NSString* strFontName = dic[@"name"];
    if (strFontName == nil) {
        strFontName = self.font.fontName;
    }
    if (fontSize <= 0) {
        fontSize = self.font.pointSize;
    }
    
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)strFontName, fontSize, NULL);
    attributes[(id)kCTFontAttributeName] = (__bridge id)(fontRef);
    CFRelease(fontRef);
    
    NSString *content = dic[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}
@end
