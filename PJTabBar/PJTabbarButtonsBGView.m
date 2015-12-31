//
//  PJTabbarButtonsBGView.m
//  PJRichText
//
//  Created by yangjuanping on 15/11/18.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJTabbarButtonsBGView.h"

@interface PJTabbarButtonsBGView()
@property(nonatomic, strong)NSArray* arrBGButton;
@end

@implementation PJTabbarButtonsBGView

- (void)dealloc
{
}

//#define MORE_HIGH  0
-(id)initWithFrame:(CGRect)frame withBarItems:(NSArray*)items{
    self = [super initWithFrame:frame];
    if (self){
        self.layer.cornerRadius = 0;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColorFromRGB(0xbdbdbd).CGColor;
        self.userInteractionEnabled = YES;
        [self setBackgroundColor:[UIColor whiteColor]];
        NSMutableArray * arr = [NSMutableArray array];
        
        NSInteger i = 0;
        for (PJTabBarItem *item in items) {
            PJTabbarCustomButton * btn = [[PJTabbarCustomButton alloc]initWithFrame:CGRectMake((MAIN_WIDTH/items.count)*i,0, (MAIN_WIDTH/items.count), HEIGHT_MAIN_BOTTOM) withTitle:item.strTitle withUnselectedImg:item.strNormalImg withSelectedImg:item.strSelectImg withUnreadType:item.unreadType];
            //btn.m_delegate = self;
            btn.tag = i++;
            [btn addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            [arr addObject:btn];
        }
        
        _arrBGButton = arr;
        
    }
    return self;
}

- (void)selected:(PJTabbarCustomButton *)sender
{
    if(self.delegate &&[self.delegate respondsToSelector:@selector(onSelectedWithButtonIndex:)])
    {
        [self.delegate onSelectedWithButtonIndex:(int)sender.tag];
    }
}



- (void)refreshWithCurrentSelected:(NSInteger)index
{
    for(NSInteger i=0;i<self.arrBGButton.count;i++)
    {
        PJTabbarCustomButton *btn = [self.arrBGButton objectAtIndex:i];
        [btn setButton:(index==i)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
