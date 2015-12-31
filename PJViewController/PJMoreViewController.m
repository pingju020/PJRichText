//
//  PJMoreViewController.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/24.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJMoreViewController.h"
#import "PJRichTextView.h"

@implementation PJMoreViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    _viewScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT-44)];
    [self.view addSubview:_viewScroll];
    
    NSString *strText = @"<font color=\"red\">This collection of documents is the API reference for the Core Text framework. </font>Core Text provides a modern, low-level programming interface for laying out text and handling fonts. The Core Text layout engine is designed for high performance, ease of use, and close integration with Core Foundation. <img src=\"hb_fdpic.png\" height=\"30\" width=\"40\" />The text layout API provides high-quality typesetting, including character-to-glyph conversion, with ligatures, kerning, and so on. The complementary Core Text font technology provides automatic font substitution (cascading), font descriptors and collections, easy access to font metrics and glyph data, and many other features.\r\nMulticore Considerations: All individual functions in Core Text are thread safe. Font objects (CTFont, CTFontDescriptor, and associated objects) can be used simultaneously by multiple operations, work queues, or threads. However, the layout objects (CTTypesetter, CTFramesetter, CTRun, CTLine, CTFrame, and associated objects) should be used in a single operation, work queue, or thread.";
    PJRichTextView *view = [[PJRichTextView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT) withContext:strText];
    [_viewScroll setContentSize:CGSizeMake(MAIN_WIDTH, view.fHeight)];
    
    [_viewScroll addSubview:view];
}
@end
