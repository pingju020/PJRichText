//
//  PJCoreTextImageData.h
//  PJRichText
//
//  Created by yangjuanping on 15/12/30.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

@interface PJCoreTextImageData : NSObject
@property (nonatomic,copy) NSString *name;
// 此坐标是 CoreText 的坐标系，而不是UIKit的坐标系
@property (nonatomic,assign) CGRect imagePosition;
@end