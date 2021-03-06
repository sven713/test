//
//  SVTableViewCellHeightAutoTestVC.m
//  test
//
//  Created by sven on 16/11/16.
//  Copyright © 2016年 sven. All rights reserved.
//

#import "SVTableViewCellHeightAutoTestVC.h"
#import "SVAutoHeightCell.h"
#import "UITableViewCell+SVAutoCalcuCellHeight.h"
#import "FMDBTestViewController.h"
#import "TouchEventTestViewController.h"
#import "KVOTestViewController.h"
#import "CoreGraphicTestViewController.h"
#import "NSOperationDownloadImgViewController.h"
#import "NSNotificatinoTestViewController.h"
#import "ObjRemoveObserveTestViewController.h"
#import "MRCNotificationTestViewController.h"

@interface SVTableViewCellHeightAutoTestVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SVTableViewCellHeightAutoTestVC

#pragma mark - lifeCycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

#pragma mark - UI
- (void)configUI {
    self.title = @"自动计算cell行高";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.hidden = NO;
}

-(void)postNotification {
    NSLog(@"发广播啦---");
    [[NSNotificationCenter defaultCenter]postNotificationName:@"removeTest" object:nil];
}

#pragma mark - TableView delegate datasource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SVAutoHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SVAutoHeightCell"];
    [cell configWithString:self.dataSource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [SVAutoHeightCell hdf_heightForIndexPath:indexPath configBlock:^(UITableViewCell *cell) {
        SVAutoHeightCell *mycell = (SVAutoHeightCell *)cell;
        [mycell configWithString:self.dataSource[indexPath.row]];
    } ];
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        FMDBTestViewController *vc = [FMDBTestViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 0) {
        TouchEventTestViewController *vc = [TouchEventTestViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        KVOTestViewController *vc = [KVOTestViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[CoreGraphicTestViewController new] animated:YES];
    }else if (indexPath.row == 4) {
        [self.navigationController pushViewController:[NSOperationDownloadImgViewController new] animated:YES];
    }else if (indexPath.row == 5) {
//        [self postNotification];
        [self.navigationController pushViewController:[NSNotificatinoTestViewController new] animated:YES];
    }else if (indexPath.row == 6) {
        [self.navigationController pushViewController:[ObjRemoveObserveTestViewController new] animated:YES];
    }else if (indexPath.row == 7) {
        [self.navigationController pushViewController:[MRCNotificationTestViewController new] animated:YES];
    }
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        [_tableView registerClass:[SVAutoHeightCell class] forCellReuseIdentifier:@"SVAutoHeightCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 0.5)]; // 去掉多余的cell
    }
    return _tableView;
}

-(NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"一行,响应事件test",@"kvoTest",@"三行\n大师傅\ndasf\n push FMDB测试页面",@"Core Graphic",@"NSOperation 下载图片",@"NSNotification test",@"不remove广播Test-无限转圈",@"MRC 广播不remove test"];
    }
    return _dataSource;
}

@end
