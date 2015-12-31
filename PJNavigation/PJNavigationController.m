//
//  PJNavigationController.m
//  PJRichText
//
//  Created by yangjuanping on 15/11/18.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJNavigationController.h"

@interface PJNavigationController ()

@end

@implementation PJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* 自定义导航栏样式的方法有两种：
1.通过 [UINavigationBar apperance]  来给整个应用上的所有的navigationbar添加样式，这是一个全局的样式设置。
2.当然如果你想要给当前的某一特定的navigationbar添加特定样式就可以通过self.navigationController.navigatinoBar 找到当前bar实例，再进行样式设置。
第二种方法，想必大家都知道，相关资料一搜一大把，不累赘了。
主要说说第一种方法，如果给整个应用的话，可以自定义一个CustomNavigationController继承自UINavigationController，然后在CustomNavController中重写init方法 */



#pragma mark -- 下面是使用第一种方法做的定制，存在问题，页面切换的时候能看到系统默认的返回按钮

+ (void)initialize {
    
    // 1.appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    [navigationBar setBarTintColor:NavigationBarColor];
    
    [navigationBar setTintColor:NavigationTitleColor];// iOS7的情况下,设置NavigationBarItem文字的颜色
    
    // 3.设置导航栏文字的主题
    NSShadow *shadow = [[NSShadow alloc]init];
    [shadow setShadowOffset:CGSizeZero];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : NavigationTitleColor,
                                            NSShadowAttributeName : shadow}];
    //    [navigationBar setBackgroundImage:[UIImage imageNamed:@"ic_cell_bg_selected"] forBarMetrics:UIBarMetricsDefault];
    
    // 4.修改所有UIBarButtonItem的外观
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    if (OS_ABOVE_IOS7) {
        [barButtonItem setTintColor:NavigationTitleColor];
    }else {
        // 修改item的背景图片
        //[barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        //[barItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        // 修改item上面的文字样式
        NSDictionary *dict =@{NSForegroundColorAttributeName:NavigationTitleColor,
                              NSShadowAttributeName : shadow};
        [barButtonItem setTitleTextAttributes:dict forState:UIControlStateNormal];
        [barButtonItem setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    }
    
    //修改返回按钮样式
    [barButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                      forBarMetrics:UIBarMetricsDefault];
    [barButtonItem setBackButtonBackgroundImage:[UIImage imageNamed:@"ic_back@2x"] forState:UIControlStateNormal barMetrics:UIBarMetricsCompact];
    
    //[barButtonItem setTitlePositionAdjustment:UIOffsetMake(60, 0) forBarMetrics:UIBarMetricsDefault];
    // 5.设置状态栏样式
    //[[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

//重写返回按钮
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >2) {
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
}

-(UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"ic_back@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    //或[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
}

-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}



/*关于导航栏的小细节：
ios7  之后，默认样式的状态栏和导航栏是连在一起的，但是实际上导航栏的位置和大小是和之前系统版本一样的，依然是贴在状态栏下面，依然是高44px；之所以用户看来它们是连在一起，这是因为UINavigationBar里面的_UINavigationBarBackground定位在y方向-20px的位置，然后高度增加到64px，这样就可以同时充当了两者的背景。所以你需要提供高度为64px的导航条背景图。*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
