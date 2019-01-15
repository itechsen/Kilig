//
//  KLGDemo02ViewController.m
//  KLGExt_Example
//
//  Created by chenyusen on 2018/5/16.
//  Copyright © 2018年 TechSen. All rights reserved.
//

#import "FDEDemo02ViewController.h"
@import Kilig;
#import "Demo01TableViewCell.h"

@interface FDEDemo02ViewController ()

@end

@implementation FDEDemo02ViewController {
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"多组默认title多行";
    
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
            
            NSDictionary *attrubutes = @{
                                         KLGTableViewCellModelAttribute : @{@"title" : title},
                                         KLGTableViewCellClassAttribute : [Demo01TableViewCell class]
                                         };
            KLGTableViewCellItem *cellItem = [[KLGTableViewCellItem alloc] initWithAttributes:attrubutes];
            [cellItems addObject:cellItem];
        }
        
        
        KLGTableViewSectionItem *sectionItem = [KLGTableViewSectionItem sectionItemWithHeaderTitle:[NSString stringWithFormat:@"Section%ld", i]
                                                                                       footerTitle:nil
                                                                                      headerHeight:70
                                                                                      footerHeight:0
                                                                                         cellItems:cellItems];
        [sectionItems addObject:sectionItem];
    }
    [_tableView.klg_tableViewModel addSectionItems:sectionItems];
}

- (void)dealloc {
    
}
@end
