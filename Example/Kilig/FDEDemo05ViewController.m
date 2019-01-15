//
//  FDEDemo05ViewController.m
//  FDEExt_Example
//
//  Created by chenyusen on 2018/5/17.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "FDEDemo05ViewController.h"
@import Kilig;
#import "FDEDemo05CellItem.h"
#import "Demo01TableViewCell.h"

@interface FDEDemo05ViewController ()

@end

@implementation FDEDemo05ViewController {
    UITableView *_tableView;
    UIButton *_editButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"多行编辑选择模式";
    _editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_editButton setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_editButton setTitle:@"取消" forState:UIControlStateSelected];
    [_editButton addTarget:self action:@selector(editButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_editButton];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.rowHeight = 60;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:_tableView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *cellItems = [NSMutableArray array];
    for (NSInteger i = 0; i < 100; i++) {
        NSString *title = [NSString stringWithFormat:@"测试标题%ld",i];
        NSDictionary *attrubutes = @{
                                     KLGTableViewCellModelAttribute : @{@"title" : title},
                                     KLGTableViewCellClassAttribute : [Demo01TableViewCell class]
                                     };
        FDEDemo05CellItem *cellItem = [[FDEDemo05CellItem alloc] initWithAttributes:attrubutes];
        [cellItems addObject:cellItem];
    }
    
    __weak typeof(self) weakSelf = self;
    [_tableView.klg_tableViewAction tapWithCellItemClass:[FDEDemo05CellItem class]
                                           actionHandler:^BOOL(id<KLGTableViewCellItem>  _Nonnull cellItem, NSIndexPath * _Nonnull indexPath) {
                                               
                                               UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"弹框" message:((NSDictionary *)cellItem.model)[@"title"] preferredStyle:UIAlertControllerStyleAlert];
                                               [weakSelf presentViewController:alertVC animated:YES completion:^{
                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                       if (weakSelf) {
                                                           [alertVC dismissViewControllerAnimated:YES completion:nil];
                                                       }
                                                   });
                                               }];
                                               return YES;
                                           }];
    [_tableView.klg_tableViewModel addCellItems:cellItems];
}

#pragma mark - Button Action
- (void)editButtonPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    [_tableView setEditing:sender.isSelected animated:YES];
}

@end
