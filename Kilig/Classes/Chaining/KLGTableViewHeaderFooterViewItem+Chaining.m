//
//  KLGTableViewHeaderFooterViewItem+Chaining.m
//  Kilig
//
//  Created by chenyusen on 2018/5/22.
//

#import "KLGTableViewHeaderFooterViewItem+Chaining.h"
#import <objc/runtime.h>

static char headerFooterViewItemPropertyMakerKey;

@implementation KLGTableViewHeaderFooterViewItemPropertyMaker {
    BOOL _destroyTag;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _destroyTag = NO;
    }
    return self;
}

- (KLGTableViewHeaderFooterViewItemPropertyMaker *(^)(id))model {
    return ^(id model) {
        self.viewItem.model = model;
        [self destroy];
        return self;
    };

}
- (KLGTableViewHeaderFooterViewItemPropertyMaker *(^)(CGFloat))viewHeight {
    return ^(CGFloat viewHeight) {
        self.viewItem.viewHeight = viewHeight;
        [self destroy];
        return self;
    };
}
- (KLGTableViewHeaderFooterViewItemPropertyMaker *(^)(Class))viewClass {
    return ^(Class viewClass) {
        self.viewItem.viewClass = viewClass;
        [self destroy];
        return self;
    };
}

- (KLGTableViewHeaderFooterViewItemPropertyMaker * _Nonnull (^)(__kindof UITableViewHeaderFooterView * _Nullable))staticView {
    return ^(UITableViewHeaderFooterView *staticView) {
        self.viewItem.staticView = staticView;
        [self destroy];
        return self;
    };
}

-(void)destroy {
    if (!_destroyTag) {
        _destroyTag = YES;
        // 链式调用时,暂且认为调用者会一次性赋值,赋完值后maker就可以在下个runloop回收了
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.viewItem) {
                objc_setAssociatedObject(self.viewItem, &headerFooterViewItemPropertyMakerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        });
    }
}

@end

@implementation KLGTableViewHeaderFooterViewItem (Chaining)

- (KLGTableViewHeaderFooterViewItemPropertyMaker *)maker {
    KLGTableViewHeaderFooterViewItemPropertyMaker *maker = objc_getAssociatedObject(self, &headerFooterViewItemPropertyMakerKey);
    if (!maker) {
        maker = [[KLGTableViewHeaderFooterViewItemPropertyMaker alloc] init];
        maker.viewItem = self;
        objc_setAssociatedObject(self, &headerFooterViewItemPropertyMakerKey, maker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return maker;
}

@end
