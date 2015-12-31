//
//  PJTabBarController.m
//  PJRichText
//
//  Created by yangjuanping on 15/11/18.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJTabBarController.h"
#import "PJTabbarButtonsBGView.h"
#import "PJMessageViewController.h"
#import "PJMoreViewController.h"

@interface PJTabBarController ()<PJTabbarButtonsDelegate>
@property(nonatomic,strong)NSArray *arrBarItems;
@property(nonatomic,retain)PJTabbarButtonsBGView* tabBarNew;
@end

@implementation PJTabBarController
- (id)init
{
    self = [super init];
    if (self)
    {
        [self initTabbarAndView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 初始化tabbar
-(void)initTabbarAndView{
    NSMutableArray *arrItems = [[NSMutableArray alloc]init];
    
    PJTabBarItem *item0 = [[PJTabBarItem alloc]init];
    item0.strTitle = @"微信";
    item0.strNormalImg = @"ic_back@2x";
    item0.strSelectImg = @"";
    item0.viewController = [[PJMessageViewController alloc]init];
//    [item0.viewController.view setBackgroundColor:[UIColor redColor]];
//    item0.viewController.title = @"测试主页1测试主页2测试主页3测试主页4测试主页5";
    [arrItems addObject:item0];
    
    PJTabBarItem *item1 = [[PJTabBarItem alloc]init];
    item1.strTitle = @"通讯录";
    item1.strNormalImg = @"";
    item1.strSelectImg = @"";
    item1.viewController = [[UIViewController alloc]init];
    [item1.viewController.view setBackgroundColor:[UIColor blueColor]];
    [arrItems addObject:item1];
    
    PJTabBarItem *item2 = [[PJTabBarItem alloc]init];
    item2.strTitle = @"CoreText";
    item2.strNormalImg = @"";
    item2.strSelectImg = @"";
    item2.viewController = [[PJMoreViewController alloc]init];
    //[item2.viewController.view setBackgroundColor:[UIColor yellowColor]];
    [arrItems addObject:item2];
    
    PJTabBarItem *item3 = [[PJTabBarItem alloc]init];
    item3.strTitle = @"我";
    item3.strNormalImg = @"";
    item3.strSelectImg = @"";
    item3.viewController = [[UIViewController alloc]init];
    [item3.viewController.view setBackgroundColor:[UIColor greenColor]];
    [arrItems addObject:item3];
    
    PJTabbarButtonsBGView * tabar = [[PJTabbarButtonsBGView alloc]initWithFrame:CGRectMake(0, MAIN_HEIGHT-HEIGHT_MAIN_BOTTOM, MAIN_WIDTH, HEIGHT_MAIN_BOTTOM) withBarItems:arrItems];
    tabar.delegate = self;
    [self.view addSubview:tabar];
    self.tabBarNew = tabar;
    
    self.viewControllers = [NSArray arrayWithObjects:item0.viewController, item1.viewController, item2.viewController, item3.viewController,nil];
    
    _arrBarItems = arrItems;
    [self onSelectedWithButtonIndex:0];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- PJTabbarButtonsDelegate
-(void)onSelectedWithButtonIndex:(NSInteger)index{
    self.selectedIndex = index;
    [self.tabBarNew refreshWithCurrentSelected:index];
    
    PJTabBarItem *item = _arrBarItems[index];
    self.title = item.strTitle;
}

@end
