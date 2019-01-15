//
//  KLGTableViewSectionItem.h
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import <Foundation/Foundation.h>
#import "KLGTableViewItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 提供一个实现KLGTableViewSectionItem协议的类,可以直接用或则继承自它
 */
@interface KLGTableViewSectionItem: NSObject <KLGTableViewSectionItem>

@property (nonatomic, copy, nullable) NSString *headerTitle;
@property (nonatomic, copy, nullable) NSString *footerTitle;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

@property (nonatomic, strong, nullable) id<KLGTableViewHeaderFooterViewItem> headerViewItem;
@property (nonatomic, strong, nullable) id<KLGTableViewHeaderFooterViewItem> footerViewItem;

@property (nonatomic, strong, nullable) NSMutableArray<id<KLGTableViewCellItem>> *cellItems;


#pragma mark - Initializer
+ (instancetype)sectionItemWithHeaderTitle:(nullable NSString *)headerTitle
                               footerTitle:(nullable NSString *)footerTitle
                              headerHeight:(CGFloat)headerHeight
                              footerHeight:(CGFloat)footerHeight
                                 cellItems:(nullable NSArray<id<KLGTableViewCellItem>> *)cellItems;

+ (instancetype)sectionItemWithHeaderViewItem:(nullable id<KLGTableViewHeaderFooterViewItem>)headerViewItem
                               footerViewItem:(nullable id<KLGTableViewHeaderFooterViewItem>)footerViewItem
                                    cellItems:(nullable NSArray<id<KLGTableViewCellItem>> *)cellItems;
@end
NS_ASSUME_NONNULL_END
