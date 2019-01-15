//
//  KLGTableViewSectionItem.m
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import "KLGTableViewSectionItem.h"

@implementation KLGTableViewSectionItem

+ (instancetype)sectionItemWithHeaderViewItem:(id<KLGTableViewHeaderFooterViewItem>)headerViewItem
                               footerViewItem:(id<KLGTableViewHeaderFooterViewItem>)footerViewItem
                                    cellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems {
    return [self sectionItemWithHeadrTitle:nil footerTitle:nil headerHeight:0 footerHeight:0 headerViewItem:headerViewItem footerViewItem:footerViewItem cellItems:cellItems];
}

+ (instancetype)sectionItemWithHeaderTitle:(NSString *)headerTitle
                               footerTitle:(NSString *)footerTitle
                              headerHeight:(CGFloat)headerHeight
                              footerHeight:(CGFloat)footerHeight
                                 cellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems {
    return [self sectionItemWithHeadrTitle:headerTitle footerTitle:footerTitle headerHeight:headerHeight footerHeight:footerHeight headerViewItem:nil footerViewItem:nil cellItems:cellItems];
}

+ (instancetype)sectionItemWithHeadrTitle:(NSString *)headerTitle
                              footerTitle:(NSString *)footerTitle
                             headerHeight:(CGFloat)headerHeight
                             footerHeight:(CGFloat)footerHeight
                           headerViewItem:(id<KLGTableViewHeaderFooterViewItem>)headerViewItem
                           footerViewItem:(id<KLGTableViewHeaderFooterViewItem>)footerViewItem
                                cellItems:(NSArray<id<KLGTableViewCellItem>> *)cellItems {
    KLGTableViewSectionItem *sectionItem = [[KLGTableViewSectionItem alloc] init];
    
    sectionItem.headerTitle = headerTitle;
    sectionItem.footerTitle = footerTitle;
    sectionItem.headerHeight = headerHeight;
    sectionItem.footerHeight = footerHeight;
    sectionItem.headerViewItem = headerViewItem;
    sectionItem.footerViewItem = footerViewItem;
    sectionItem.cellItems = [cellItems mutableCopy];
    return sectionItem;
}

@end
