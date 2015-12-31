//
//  PJRichTextParser.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/29.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <CoreText/CoreText.h>

@interface PJRichTextItemParser : NSObject
@property (strong, nonatomic) UIFont* font;
@property (strong, nonatomic) UIColor* color;
@property (assign, nonatomic) CGFloat lineSpace;

//-(id)initWithFont:(UIFont*)font withColor:(UIColor*)color;
-(NSAttributedString *)parseItermFromNSDictionary:(NSDictionary*)dic;

- (NSDictionary *)attributesWithDefault;

- (UIColor *)colorFromTemplate:(NSString *)color;
@end
