//
//  KLGTableViewHeaderFooterViewItem+Chaining.h
//  Kilig
//
//  Created by chenyusen on 2018/5/22.
//

#import "KLGTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface KLGTableViewHeaderFooterViewItemPropertyMaker: NSObject

@property (nonatomic, weak) KLGTableViewHeaderFooterViewItem *viewItem;

- (KLGTableViewHeaderFooterViewItemPropertyMaker *(^)(_Nullable id))model;
- (KLGTableViewHeaderFooterViewItemPropertyMaker *(^)(CGFloat))viewHeight;
- (KLGTableViewHeaderFooterViewItemPropertyMaker *(^)(_Nullable Class))viewClass;
- (KLGTableViewHeaderFooterViewItemPropertyMaker *(^)(__kindof UITableViewHeaderFooterView * _Nullable))staticView;
@end

@interface KLGTableViewHeaderFooterViewItem (Chaining)

@property (nonatomic, strong, readonly) KLGTableViewHeaderFooterViewItemPropertyMaker *maker;

@end

NS_ASSUME_NONNULL_END
