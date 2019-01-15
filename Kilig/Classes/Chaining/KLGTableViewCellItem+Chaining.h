//
//  KLGTableViewCellItem+Chaining.h
//  Kilig
//
//  Created by chenyusen on 2018/5/22.
//

#import "KLGTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface KLGTableViewCellItemPropertyMaker: NSObject

@property (nonatomic, weak) KLGTableViewCellItem *cellItem;

- (KLGTableViewCellItemPropertyMaker *(^)(_Nullable id))model;
- (KLGTableViewCellItemPropertyMaker *(^)(CGFloat))cellHeight;
- (KLGTableViewCellItemPropertyMaker *(^)(_Nullable Class))cellClass;
- (KLGTableViewCellItemPropertyMaker *(^)(UINib * _Nullable))cellNib;
- (KLGTableViewCellItemPropertyMaker *(^)(UITableViewCellStyle))cellStyle;
- (KLGTableViewCellItemPropertyMaker *(^)(NSArray<UITableViewRowAction *> * _Nullable))rowActions;
- (KLGTableViewCellItemPropertyMaker *(^)(UIColor * _Nullable))highlightColor;
- (KLGTableViewCellItemPropertyMaker *(^)(__kindof UITableViewCell * _Nullable))staticCell;


@end

@interface KLGTableViewCellItem (Chaining)

@property (nonatomic, strong, readonly) KLGTableViewCellItemPropertyMaker *maker;
@end

NS_ASSUME_NONNULL_END
