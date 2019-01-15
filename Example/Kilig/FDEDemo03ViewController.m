//
//  FDEDemo03ViewController.m
//  FDEExt_Example
//
//  Created by chenyusen on 2018/5/16.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "FDEDemo03ViewController.h"
@import Kilig;
#import "Demo01TableViewCell.h"
#import "Demo03TableViewHeaderView.h"

@interface FDEDemo03ViewController ()

@end

@implementation FDEDemo03ViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"多组自定义Header多行";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSMutableArray *sectionItems = [NSMutableArray array];
    for (NSInteger i = 0; i < 5; i++) {
        
        NSMutableArray *cellItems = [NSMutableArray array];
        for (NSInteger j = 0; j < 20; j++) {
            NSString *title = [NSString stringWithFormat:@"Cell%ld %ld",i, j];
            NSDictionary *attribute = @{
                                        KLGTableViewCellModelAttribute : @{@"title" : title},
                                        KLGTableViewCellClassAttribute : [Demo01TableViewCell class]
                                        };
            KLGTableViewCellItem *cellItem = [[KLGTableViewCellItem alloc] initWithAttributes:attribute];
            cellItem.maker.highlightColor([UIColor redColor]);
            [cellItems addObject:cellItem];
        }
        NSDictionary *attribute = @{
                                    KLGTableViewHeaderFooterViewModelAttribute : @{@"title": [NSString stringWithFormat:@"Section%ld", i]},
                                    KLGTableViewHeaderFooterViewClassAttribute : [Demo03TableViewHeaderView class],
                                    KLGTableViewHeaderFooterViewHeightAttribute : @(50)
                                    };
        KLGTableViewHeaderFooterViewItem *headerViewItem = [[KLGTableViewHeaderFooterViewItem alloc] initWithAttributes:attribute];
    
        KLGTableViewSectionItem *sectionItem = [KLGTableViewSectionItem sectionItemWithHeaderViewItem:headerViewItem
                                                                                       footerViewItem:nil
                                                                                            cellItems:cellItems];
    
        [sectionItems addObject:sectionItem];
    }
    [_tableView.klg_tableViewModel addSectionItems:sectionItems];
    
    
}


@end
