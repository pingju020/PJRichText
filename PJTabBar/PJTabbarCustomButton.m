//
//  PJTabbarCustomButton.m
//  PJRichText
//
//  Created by yangjuanping on 15/11/18.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJTabbarCustomButton.h"
@implementation PJTabBarItem
-(id)init{
    if ([super init]) {
        _unreadType = ENUM_UNREAD_NONE;
        _strTitle = @"";
        _strNormalImg = @"";
        _strSelectImg = @"";
        _viewController = nil;
    }
    return self;
}
@end

@implementation PJTabbarCustomButton
@synthesize btn = btn;

- (void)dealloc
{
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withUnselectedImg:(NSString *)unSelectedImg withSelectedImg:(NSString *)selecredImg withUnreadType:(UnreadNumType)type
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.adjustsImageWhenDisabled = NO;
        self.adjustsImageWhenHighlighted = NO;
        self.showsTouchWhenHighlighted = NO;
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.adjustsImageWhenDisabled = NO;
        btn.adjustsImageWhenHighlighted = NO;
        btn.showsTouchWhenHighlighted = NO;

        [btn setFrame:CGRectMake((self.frame.size.width-22)/2,10,22,22)];
        titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0,33, self.frame.size.width, 19)];
        [titleLab setBackgroundColor:[UIColor clearColor]];
        [titleLab setText:title];
        [titleLab setTextAlignment:NSTextAlignmentCenter];
        [titleLab setFont:[UIFont boldSystemFontOfSize:12]];
        [self addSubview:titleLab];
        
        [btn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:unSelectedImg] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:selecredImg] forState:UIControlStateSelected];
        
        [self addSubview:btn];
        
    }
    return self;
}


- (void)selected:(UIButton *)sender
{
    sender.selected = !sender.selected;
    //[self.m_delegate onSelectedIndex:self];
}


- (void)setButton:(BOOL)isSelected
{
    // [self setBackgroundColor:isSelected ? UIColorFromRGB(0x52a6e0):[UIColor clearColor]];
    [self setBackgroundColor:[UIColor clearColor]];
    btn.selected = isSelected;
    [titleLab setTextColor: isSelected ? COMMON_CORLOR_HIGHLIGHT :COMMON_CORLOR_NORMAL];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
