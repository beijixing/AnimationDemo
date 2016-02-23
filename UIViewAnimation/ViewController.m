//
//  ViewController.m
//  UIViewAnimation
//
//  Created by ybon on 16/2/17.
//  Copyright © 2016年 ybon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_classArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _classArr = [[NSMutableArray alloc] initWithObjects:@"BaseAniamtionTest",
                 @"FoldMenuTest",
                 nil];
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellName"];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _classArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellName"];
    cell.textLabel.text = _classArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *VCName = _classArr[indexPath.row];
    UIViewController *vc = [[NSClassFromString(VCName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
