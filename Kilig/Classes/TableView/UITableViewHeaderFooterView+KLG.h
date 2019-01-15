//
//  UITableViewHeaderFooterView+KLG.h
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import <UIKit/UIKit.h>
#import "KLGTableViewItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN
@interface UITableViewHeaderFooterView (KLG)
@property (nonatomic, strong, nullable) id<KLGTableViewHeaderFooterViewItem> klg_headerFooterViewItem;

/**
 在创建此类UITableViewHeaderFooterView时,是否需要拼接其绑定的KLGTableViewHeaderFooterViewItem信息,用于不复用的静态绑定
 
 @return 是否拼接, 默认不拼接
 */
+ (BOOL)klg_shouldAppendHeaderFooterViewItemToReuseIdentifier;

/**
 更新当前UITableViewHeaderFooterView的数据, 需要在方法中先调用父类方法
 
 @param headerFooterViewItem 数据模型
 @return 是否需要更新
 */
- (BOOL)klg_updateHeaderFooterViewItem:(nullable id<KLGTableViewHeaderFooterViewItem>)headerFooterViewItem NS_REQUIRES_SUPER;
@end
NS_ASSUME_NONNULL_END
