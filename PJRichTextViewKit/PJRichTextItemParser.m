//
//  PJRichTextParser.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/29.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJRichTextItemParser.h"


@implementation PJRichTextItemParser

-(id)initWithFont:(UIFont*)font withColor:(UIColor*)color{
    if (self == [super init]) {
        _font = font;
        _color = color;
    }
    
    return self;
}

-(id)init{
    if (self == [super init]) {
        _font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        _color = [UIColor blackColor];
    }
    return self;
}

-(NSAttributedString *)parseItermFromNSDictionary:(NSDictionary*)dic{
    return [[NSAttributedString alloc]initWithString:@""];
}

- (NSDictionary *)attributesWithDefault {
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)self.font.fontName, self.font.pointSize, NULL);
    CGFloat lineSpacing = self.lineSpace;
    
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpacing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpacing}
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor *textColor = self.color;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    
    return dict;
}

- (UIColor *)colorFromTemplate:(NSString *)color {
    
    if (color == nil) {
        return nil;
    }
    
    // 检查颜色是否是“#XXXXXX”类型的正则表达式：@"^#[0-9a-fA-F]{6}{1}$"或者 @"\\#[0-9a-fA-F]{6}"
    NSRegularExpression* colorStringRegex = [[NSRegularExpression alloc] initWithPattern:@"\\#[0-9a-fA-F]{6}" options:0 error:NULL];
    NSTextCheckingResult *colorStringMatch =[colorStringRegex firstMatchInString:color options:0 range:NSMakeRange(0, [color length])];
    if (colorStringMatch != nil) {
        return [UIColor colorWithHexString:[color substringWithRange:colorStringMatch.range]];
    }
    
    // 检查颜色是否是RGB（x, x, x）类型的正则表达式："^[rR][gG][Bb][\(]([\\s]*(2[0-4][0-9]|25[0-5]|[01]?[0-9][0-9]?)[\\s]*,){2}[\\s]*(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)[\\s]*[\)]{1}$"
    NSRegularExpression* colorRGBRegex = [[NSRegularExpression alloc] initWithPattern:@"^[rR][gG][Bb][\\(]([\\\\s]*(2[0-4][0-9]|25[0-5]|[01]?[0-9][0-9]?)[\\\\s]*,){2}[\\\\s]*(2[0-4]\\\\d|25[0-5]|[01]?\\\\d\\\\d?)[\\\\s]*[\\)]{1}$" options:0 error:NULL];
    NSTextCheckingResult *colorRGBMatch =[colorRGBRegex firstMatchInString:color options:0 range:NSMakeRange(0, [color length])];
    if (colorRGBMatch != nil) {
        color = [color substringFromIndex:4];
        color = [color substringToIndex:color.length-2];
        color = [color stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray* arrStr = [color componentsSeparatedByString:@","];
        if (arrStr.count == 3) {
            NSString *strColorR = arrStr[0];
            NSString *strColorG = arrStr[1];
            NSString *strColorB = arrStr[2];
            return  [UIColor colorWithRed:[strColorR floatValue] green:[strColorG floatValue] blue:[strColorB floatValue] alpha:1.0];
        }
    }
    
    // 处理颜色名的情况，如红色为red等等。
    else{
        SEL colorSel = NSSelectorFromString([NSString stringWithFormat: @"%@Color", color]);
        if([UIColor respondsToSelector:colorSel]){
            return [UIColor performSelector:colorSel];
        }
    }
    
    // 所有的都处理不了，则使用系统默认
    return nil;
}
@end
