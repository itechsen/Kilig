//
//  NSArray+KLG.h
//  Kilig
//
//  Created by chenyusen on 2018/5/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSArray (KLG)

/**
 映射到新对象数组

 @param mapBlock 映射规则
 @return 新的映射数组
 */
- (nullable NSArray *)klg_mapBlock:(_Nullable id(^)(_Nullable id obj))mapBlock;


/**
 筛选数组

 @param filterBlock 筛选规则
 @return 筛选出的数组
 */
- (nullable NSArray *)klg_filterBlock:(BOOL (^)(_Nullable id obj))filterBlock;

@end


NS_ASSUME_NONNULL_END
