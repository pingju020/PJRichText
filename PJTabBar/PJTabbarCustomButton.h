//
//  PJTabbarCustomButton.h
//  PJRichText
//
//  Created by yangjuanping on 15/11/18.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJTabBarItem : NSObject
@property(nonatomic, assign)UnreadNumType       unreadType;
@property(nonatomic, strong)NSString            *strTitle;
@property(nonatomic, strong)NSString            *strNormalImg;
@property(nonatomic, strong)NSString            *strSelectImg;
@property(nonatomic, retain)UIViewController    *viewController;
@end


@interface PJTabbarCustomButton : UIButton
{
    UILabel * titleLab;
    UIButton * btn;
}
//@property(assign)id<TabbarCustomButtonDelegate>m_delegate;
@property (nonatomic, strong) UIButton *btn;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withUnselectedImg:(NSString *)unSelectedImg withSelectedImg:(NSString *)selecredImg withUnreadType:(UnreadNumType)type;

- (void)setButton:(BOOL)isSelected;
@end
