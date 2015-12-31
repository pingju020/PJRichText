//
//  PJCoreTextData.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/29.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJCoreTextData.h"
#import "PJCoreTextImageData.h"

@implementation PJCoreTextData
- (void)setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame != ctFrame) {
        if(_ctFrame != nil) {
            CFRelease(_ctFrame);
        }
        
        CFRetain(ctFrame);
        _ctFrame = ctFrame;
    }
}

- (void)dealloc {
    if (_ctFrame != nil) {
        CFRelease(_ctFrame);
        _ctFrame = nil;
    }
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    [self fillImagePosition];
}

- (void)fillImagePosition {
    if (self.imageArray.count == 0) return;
    NSArray *lines = (NSArray *)CTFrameGetLines(self.ctFrame);
    NSInteger lineCount = lines.count;
    // 每行的起始坐标
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(self.ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    int imageIndex = 0;
    PJCoreTextImageData *imageData = self.imageArray[0];
    for (int i = 0; i < lineCount; i++) {
        if (!imageData) break;
        
        CTLineRef line = (__bridge CTLineRef)(lines[i]);
        NSArray *runObjectArray = (NSArray *)CTLineGetGlyphRuns(line);
        for (id runObject in runObjectArray) {
            CTRunRef run = (__bridge CTRunRef)(runObject);
            NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)([runAttributes valueForKey:(id)kCTRunDelegateAttributeName]);
            // 如果delegate是空，表明不是图片
            if (!delegate) continue;
            
            NSDictionary *metaDict = CTRunDelegateGetRefCon(delegate);
            if (![metaDict isKindOfClass:[NSDictionary class]]) continue;
            
            /* 确定图片run的frame */
            CGRect runBounds;
            CGFloat ascent,descent;
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            // 计算出图片相对于每行起始位置x方向上面的偏移量
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            
            imageData.imagePosition = runBounds;
            imageIndex++;
            if (imageIndex == self.imageArray.count) {
                imageData = nil;
                break;
            } else {
                imageData = self.imageArray[imageIndex];
            }
        }
    }
}

-(void)DrawFrame:(CGContextRef)context{
    
    CTFrameDraw(self.ctFrame, context);
    
    // 绘制出图片
    for (PJCoreTextImageData *imageData in self.imageArray) {
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
}

@end
