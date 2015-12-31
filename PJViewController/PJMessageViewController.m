//
//  PJMessageViewController.m
//  PJRichText
//
//  Created by yangjuanping on 15/12/22.
//  Copyright © 2015年 yangjuanping. All rights reserved.
//

#import "PJMessageViewController.h"

@interface PJMessageViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableMsgList;
@end

@implementation PJMessageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.tableMsgList setFrame:CGRectMake(CGRectGetMinX(_tableMsgList.frame), CGRectGetMinY(_tableMsgList.frame), CGRectGetWidth(_tableMsgList.frame), CGRectGetHeight(_tableMsgList.frame))];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView*)tableMsgList{
    if (!_tableMsgList) {
        _tableMsgList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT) style:UITableViewStyleGrouped];
        _tableMsgList.delegate = self;
        _tableMsgList.dataSource = self;
        [self.view addSubview:_tableMsgList];
    }
    return _tableMsgList;
}

#pragma mark -- UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

@end
