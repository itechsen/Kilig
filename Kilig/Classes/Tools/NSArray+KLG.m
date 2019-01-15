//
//  NSArray+KLG.m
//  Kilig
//
//  Created by chenyusen on 2018/5/18.
//

#import "NSArray+KLG.h"

@implementation NSArray (KLG)

- (instancetype)klg_mapBlock:(id(^)(id obj))mapBlock {
    if (!mapBlock) { return nil; };
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:self.count];
    for (id obj in self) {
        id newObj = mapBlock(obj);
        if (newObj) {
        [arrayM addObject:newObj];
        }
    }
    return arrayM.copy;
}

- (nullable instancetype)klg_filterBlock:(BOOL (^)(_Nullable id obj))filterBlock {
    if (!filterBlock) { return nil; };
    NSMutableArray *arrayM = [NSMutableArray array];
    for (id obj in self) {
        if (filterBlock(obj)) {
            [arrayM addObject:obj];
        }
    }
    return arrayM.copy;
}
@end
