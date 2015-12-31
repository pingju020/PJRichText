//
//  ViewController.m
//  PJRichText
//
//  Created by yangjuanping on 15/11/17.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "ViewController.h"
#import "PJTabBarController.h"
#import "PJSliederViewContoller.h"
#import "PJRichTextView.h"

@interface ViewController ()
@property(nonatomic,strong)UIButton *btnEnter;
@end

@implementation ViewController

-(id)init{
    if (self == [super init]) {
        _btnEnter = [[UIButton alloc]initWithFrame:CGRectMake(30, MAIN_HEIGHT/2-15, MAIN_WIDTH-60, 30)];
        [_btnEnter setBackgroundColor:COMMON_CORLOR_HIGHLIGHT];
        [_btnEnter setTitle:@"进入体验" forState:UIControlStateNormal];
        [_btnEnter addTarget:self action:@selector(Clicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btnEnter];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"测试主页12";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Clicked{
    //PJSliederViewContoller *mainVC  = [[PJSliederViewContoller alloc]init];
    PJTabBarController *mainVC  = [[PJTabBarController alloc]init];
    //SideslipViewController *sliderVC = [[SideslipViewController alloc]initWithLeftView:nil andMainView:mainVC andRightView:nil andBackgroundImage:nil];
    [self.navigationController pushViewController:mainVC animated:YES];
}

@end
