//
//  PJRichTextParser.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/30.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PJRichTextParser : NSObject

+(id)getInstance;
-(NSAttributedString*)ParserRichText:(NSString*)text;
-(NSArray*)getImages;
-(NSAttributedString*)ParserArry:(NSArray*)arr;

@end
