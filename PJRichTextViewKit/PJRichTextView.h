//
//  PJRichTextView.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/24.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface PJRichTextView : UIView

@property(nonatomic, assign)CGFloat fWidth;
@property(nonatomic, assign)CGFloat fHeight;

-(id)initWithFrame:(CGRect)frame withContext:(NSString*)strContext;
@end
