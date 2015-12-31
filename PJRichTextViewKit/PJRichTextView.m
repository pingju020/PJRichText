//
//  PJRichTextView.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/24.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//
//#import "PJRichTextMarkupParser.h"
#import "PJRichTextView.h"
#import "PJCoreTextData.h"
#import "PJFrameParserConfig.h"
#import "PJFrameParser.h"
#import "PJCoreTextImageData.h"
@interface PJRichTextView()
@property (nonatomic,strong) PJCoreTextData *data;
@end

@implementation PJRichTextView

-(id)initWithFrame:(CGRect)frame withContext:(NSString*)strContext{
    if (self == [super initWithFrame:frame]) {
        self.fWidth = self.frame.size.width;
        self.backgroundColor = [UIColor clearColor];
        
        PJFrameParserConfig *config = [[PJFrameParserConfig alloc] init];
        config.width = self.fWidth;
        
        PJCoreTextData *data = [PJFrameParser parseRichText:strContext config:config];
        
        // 传递数据给CTDisplayView，然后绘制内容
        self.data = data;
        
        // 设置CTDisplayView的高度
        self.fHeight = data.height;
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, self.fHeight)];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame withContextArr:(NSArray*)arr{
    if (self == [super initWithFrame:frame]) {
        self.fWidth = self.frame.size.width;
        self.backgroundColor = [UIColor clearColor];
        
        PJFrameParserConfig *config = [[PJFrameParserConfig alloc] init];
        config.width = self.fWidth;
        PJCoreTextData *data = [PJFrameParser parseRichTextArr:arr config:config];
        
        // 传递数据给CTDisplayView，然后绘制内容
        self.data = data;
        
        // 设置CTDisplayView的高度
        self.fHeight = data.height;
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, self.fHeight)];
    }
    
    return self;
}

-(id)initWithFrame:(CGRect)frame withFile:(NSString*)fileName{
    if (self == [super initWithFrame:frame]) {
        self.fWidth = self.frame.size.width;
        self.backgroundColor = [UIColor clearColor];
        
        PJFrameParserConfig *config = [[PJFrameParserConfig alloc] init];
        config.width = self.fWidth;
        
        if (fileName==nil) {
            fileName = @"test.plist";
        }
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        PJCoreTextData *data = [PJFrameParser parseTemplateFile:path config:config];
        
        // 传递数据给CTDisplayView，然后绘制内容
        self.data = data;
        
        // 设置CTDisplayView的高度
        self.fHeight = data.height;
        [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, self.fHeight)];
    }
    
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if (self.data) {
        [self.data DrawFrame:context];
    }
}
@end
