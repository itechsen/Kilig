//
//  KLGTableViewCellItem+Chaining.m
//  Kilig
//
//  Created by chenyusen on 2018/5/22.
//

#import "KLGTableViewCellItem+Chaining.h"
#import <objc/runtime.h>

static char cellItemPropertyMakerKey;

@implementation KLGTableViewCellItemPropertyMaker {
    BOOL _destroyTag;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _destroyTag = NO;
    }
    return self;
}

- (KLGTableViewCellItemPropertyMaker *(^)(id))model {
    return ^(id model) {
        self.cellItem.model = model;
        [self destroy];
        return self;
    };
}

- (KLGTableViewCellItemPropertyMaker *(^)(CGFloat))cellHeight {
    return ^(CGFloat cellHeight) {
        self.cellItem.cellHeight = cellHeight;
        [self destroy];
        return self;
    };
}

- (KLGTableViewCellItemPropertyMaker *(^)(Class))cellClass {
    return ^(Class cellClass) {
        self.cellItem.cellClass = cellClass;
        [self destroy];
        return self;
    };
}

- (KLGTableViewCellItemPropertyMaker *(^)(UINib *))cellNib {
    return ^(UINib *cellNib) {
        self.cellItem.cellNib = cellNib;
        [self destroy];
        return self;
    };
}

- (KLGTableViewCellItemPropertyMaker *(^)(NSArray<UITableViewRowAction *> *))rowActions {
    return ^(NSArray<UITableViewRowAction *> *rowActions) {
        self.cellItem.rowActions = rowActions;
        [self destroy];
        return self;
    };
}

- (KLGTableViewCellItemPropertyMaker *(^)(UITableViewCellStyle))cellStyle {
    return ^(UITableViewCellStyle cellStyle) {
        self.cellItem.cellStyle = cellStyle;
        [self destroy];
        return self;
    };
}

- (KLGTableViewCellItemPropertyMaker * _Nonnull (^)(UIColor * _Nullable))highlightColor {
    return ^(UIColor *highlightColor) {
        self.cellItem.highlightColor = highlightColor;
        [self destroy];
        return self;
    };
}

- (KLGTableViewCellItemPropertyMaker * _Nonnull (^)(__kindof UITableViewCell * _Nullable))staticCell {
    return ^(UITableViewCell *staticCell) {
        self.cellItem.staticCell = staticCell;
        [self destroy];
        return self;
    };
}

-(void)destroy {
    if (!_destroyTag) {
        _destroyTag = YES;
        // 链式调用时,暂且认为调用者会一次性赋值,赋完值后maker就可以在下个runloop回收了
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.cellItem) {
                objc_setAssociatedObject(self.cellItem, &cellItemPropertyMakerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        });
    }
}

@end


@implementation KLGTableViewCellItem (Chaining)

- (KLGTableViewCellItemPropertyMaker *)maker {
    KLGTableViewCellItemPropertyMaker *maker = objc_getAssociatedObject(self, &cellItemPropertyMakerKey);
    if (!maker) {
        maker = [[KLGTableViewCellItemPropertyMaker alloc] init];
        maker.cellItem = self;
        objc_setAssociatedObject(self, &cellItemPropertyMakerKey, maker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return maker;
}

@end
