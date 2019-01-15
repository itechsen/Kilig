//
//  KLGTableViewHeaderFooterViewItem.h
//  Kilig
//
//  Created by chenyusen on 2018/5/22.
//

#import <Foundation/Foundation.h>
#import "KLGTableViewItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString *KLGTableViewHeaderFooterViewItemKey NS_EXTENSIBLE_STRING_ENUM;

extern KLGTableViewHeaderFooterViewItemKey const KLGTableViewHeaderFooterViewModelAttribute; // KLGTableViewHeaderFooterViewItem的model的key
extern KLGTableViewHeaderFooterViewItemKey const KLGTableViewHeaderFooterViewHeightAttribute;  // KLGTableViewHeaderFooterViewItem的viewHeight的key
extern KLGTableViewHeaderFooterViewItemKey const KLGTableViewHeaderFooterViewClassAttribute;  // KLGTableViewHeaderFooterViewItem的viewClass的key




typedef CGFloat (^KLGHeaderFooterViewHeightBlock) (_Nullable id);



/**
 提供一个实现KLGTableViewHeaderFooterViewItem协议的类,可以直接用或则继承自它
 */
@interface KLGTableViewHeaderFooterViewItem: NSObject <KLGTableViewHeaderFooterViewItem>

@property (nonatomic, strong, nullable) id model;

@property (nonatomic, assign) CGFloat viewHeight;

@property (nonatomic, strong) Class viewClass;

@property (nonatomic, weak, nullable) __kindof UITableViewHeaderFooterView *currentView;

@property (nonatomic, strong) __kindof UITableViewHeaderFooterView *staticView;
#pragma mark - Initializer
/**
 默认构造器
 
 @param attributes KLGTableViewHeaderFooterViewItemKey的枚举值
 @return KLGTableViewHeaderFooterViewItem实例
 */
- (instancetype)initWithAttributes:(nullable NSDictionary *)attributes;


/**
 便捷构造器 内部实现initWithAttributes:方法
 
 @param model 视图数据
 @param viewClass 视图类型
 @param viewHeight 视图高度
 @return KLGTableViewHeaderFooterViewItem实例
 */
- (instancetype)initWithModel:(nullable id)model
                    viewClass:(nullable Class)viewClass
                   viewHeight:(CGFloat)viewHeight;
@end

NS_ASSUME_NONNULL_END
