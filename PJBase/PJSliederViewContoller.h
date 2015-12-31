//
//  PJSliederViewContoller.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/1.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJBaseViewController.h"

typedef NS_ENUM(NSInteger, PJSlider_Modal){
    PJSlider_Modal_No = 0x00,            // 不使用抽屉效果
    PJSlider_Modal_Left=0x01,            // 左抽屉效果
    PJSlider_Modal_Right=0x02,           // 右抽屉效果
};

@interface PJSliederViewContoller : UIViewController

// 纵向缩小的最大比率取值0~0.5
@property(nonatomic, assign)CGFloat fScal;


-(id)initWithLeft:(PJBaseViewController*)leftView Main:(PJBaseViewController*)mainView Right:(PJBaseViewController*)rightView;

-(void)setSlideModal:(PJSlider_Modal)slideModal Scal:(CGFloat)scal;


@end
