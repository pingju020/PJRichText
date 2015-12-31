//
//  PJTabbarButtonsBGView.h
//  PJRichText
//
//  Created by yangjuanping on 15/11/18.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJTabbarCustomButton.h"

@protocol PJTabbarButtonsDelegate <NSObject>
-(void)onSelectedWithButtonIndex:(NSInteger)index;
@end

@interface PJTabbarButtonsBGView : UIImageView

@property(nonatomic, assign) id<PJTabbarButtonsDelegate> delegate;

-(id)initWithFrame:(CGRect)frame withBarItems:(NSArray*)items;

- (void)refreshWithCurrentSelected:(NSInteger)index;
@end
