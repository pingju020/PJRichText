//
//  PJRichTextParser.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/30.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJRichTextParser.h"
#import "PJCoreTextImageData.h"
#import "PJRichTextParserForTxt.h"
#import "PJRichTextParserForImg.h"

@interface PJRichTextParser()
@property (nonatomic, strong) NSArray* arrImg;
@end

@implementation PJRichTextParser

+(id)getInstance{
    static PJRichTextParser *_m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _m = [PJRichTextParser new];
    });
    return _m;
}

-(NSArray*)arryFromMarkup:(NSString*)markup
{
    // 匹配类似<font>...</font>对，或者<font/>，匹配对时<font>...</font>中间的文字信息中不能存在回车换行符。
    NSRegularExpression* regex = [[NSRegularExpression alloc]
                                  initWithPattern:@"<(\\S*?) [^>]*>.*?</\\1>|<.*? />"
                                  options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                  error:nil]; //2
    NSArray* chunks = [regex matchesInString:markup options:0 range:NSMakeRange(0, [markup length])];
    //NSArray * arr = [markup componentsMatchedByRegex:@"<(\\S*?) [^>]*>.*?</\\1>|<.*? />"];
    
    NSMutableArray* arrParsered = [[NSMutableArray alloc]init];
    NSRange range = NSMakeRange(0,0);
    for (NSTextCheckingResult* b in chunks) {
        if (b.range.location != range.location) {
            range.length = b.range.location-range.location;
            NSString *strNormal = [markup substringWithRange:range];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:strNormal forKey:@"content"];
            [dic setObject:@"txt" forKey:@"type"];
            [arrParsered addObject:dic];
        }
        
        NSString* strAttr = [markup substringWithRange:b.range];
        NSRegularExpression* regex1 = [[NSRegularExpression alloc]
                                       initWithPattern:@"<(\\/\\s*)?!?((\\w+:)?\\w+)(\\w+(\\s*=?\\s*(([\"\"\'])(\\\\[\"\"\'tbnr]|[^\\7])*?\\7|\\w+)|.{0})|\\s)*?(\\/\\s*)?>"
                                       options:NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators
                                       error:nil];
        NSArray* arrAll = [regex1 matchesInString:strAttr options:0 range:NSMakeRange(0, [strAttr length])];
        
        // 匹配的是样式
        if (arrAll.count > 1) {
            NSTextCheckingResult* strat = arrAll[0];
            NSRange rangeStart = strat.range;
            NSTextCheckingResult* end = arrAll[1];
            NSRange rangeEnd = end.range;
            NSRange rangeString = NSMakeRange(rangeStart.length + rangeStart.location, rangeEnd.location-rangeStart.location-rangeStart.length);
            
            NSString *str = [strAttr substringWithRange:rangeString];
            
            NSString* tag = [strAttr substringWithRange:rangeStart];
            NSRegularExpression* styleRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=style=\")\\w+" options:0 error:NULL];
            NSTextCheckingResult *styleMatch =[styleRegex firstMatchInString:tag options:0 range:NSMakeRange(0, [tag length])];
            if (nil!=styleMatch) {
                NSString* strStyle = [tag substringWithRange:styleMatch.range];
                NSArray *arrSep = [strStyle componentsSeparatedByString:@";"];
            }
            
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:@"txt" forKey:@"type"];
            [dic setObject:str forKey:@"content"];
            NSRegularExpression* colorRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=color=\")\\w+" options:0 error:NULL];
            NSTextCheckingResult *colormatch =[colorRegex firstMatchInString:tag options:0 range:NSMakeRange(0, [tag length])];
            if (colormatch != nil) {
                [dic setObject:[tag substringWithRange:colormatch.range] forKey:@"color"];
            }
            
            NSRegularExpression* faceRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=face=\")[^\"]+" options:0 error:NULL];
            NSTextCheckingResult *facematch =[faceRegex firstMatchInString:tag options:0 range:NSMakeRange(0, [tag length])];
            if (facematch != nil) {
                [dic setObject:[tag substringWithRange:facematch.range] forKey:@"name"];
            }
            [arrParsered addObject:dic];
        }
        
        // 匹配的是img属性,img属性的格式类似<img height="400" width="400" src="name.jpg"/>
        else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            
            NSRegularExpression* heightRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=height=\")\\w+" options:0 error:NULL];
            NSTextCheckingResult *heightmatch =[heightRegex firstMatchInString:strAttr options:0 range:NSMakeRange(0, [strAttr length])];
            if (heightmatch != nil) {
                [dic setObject:[strAttr substringWithRange:heightmatch.range] forKey:@"height"];
            }
            
            NSRegularExpression* widthRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=width=\")\\w+" options:0 error:NULL];
            NSTextCheckingResult *widthmatch =[widthRegex firstMatchInString:strAttr options:0 range:NSMakeRange(0, [strAttr length])];
            if (widthmatch != nil) {
                [dic setObject:[strAttr substringWithRange:widthmatch.range] forKey:@"width"];
            }
            
            NSRegularExpression* nameRegex = [[NSRegularExpression alloc] initWithPattern:@"(?<=src=\")\\w+" options:0 error:NULL];
            NSTextCheckingResult *namematch =[nameRegex firstMatchInString:strAttr options:0 range:NSMakeRange(0, [strAttr length])];
            if (namematch != nil) {
                [dic setObject:[strAttr substringWithRange:namematch.range] forKey:@"name"];
            }
            
            [dic setObject:@"img" forKey:@"type"];
            [arrParsered addObject:dic];
        }
        
        range.location = b.range.location+b.range.length;
    }
    
    if (range.location < markup.length) {
        range.length = markup.length-range.location;
        NSString *strNormal = [markup substringWithRange:range];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"txt" forKey:@"type"];
        [dic setObject:strNormal forKey:@"content"];
        [arrParsered addObject:dic];
    }
    
    return arrParsered;
}

-(NSAttributedString*)ParserArry:(NSArray*)arr{
    
    NSMutableAttributedString* result =
    [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableArray *imageArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in arr) {
        NSString *type = dict[@"type"];
        PJRichTextItemParser* parser = nil;
        if ([type isEqualToString:@"txt"]) {
            
            parser = [[PJRichTextParserForTxt alloc]init];
            NSAttributedString *as = [parser parseItermFromNSDictionary:dict];
            [result appendAttributedString:as];
        } else if ([type isEqualToString:@"img"]) {
            PJCoreTextImageData *imageData = [[PJCoreTextImageData alloc] init];
            imageData.name = dict[@"name"];
            [imageArray addObject:imageData];
            
            parser = [[PJRichTextParserForImg alloc]init];
            NSAttributedString *as = [parser parseItermFromNSDictionary:dict];
            [result appendAttributedString:as];
        }
    }
    _arrImg = imageArray;
    return result;
}

-(NSAttributedString*)ParserRichText:(NSString*)text{
  return [self ParserArry:[self arryFromMarkup:text]];
}

-(NSArray*)getImages{
    return _arrImg;
}

@end
