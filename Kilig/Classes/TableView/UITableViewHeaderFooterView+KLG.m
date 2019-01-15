//
//  UITableViewHeaderFooterView+KLG.m
//  Kilig
//
//  Created by chenyusen on 2018/5/17.
//

#import "UITableViewHeaderFooterView+KLG.h"
#import "KLGMethodSwizzleTool.h"
#import <objc/runtime.h>

static char headerFooterViewItemKey;

@implementation UITableViewHeaderFooterView (KLG)
+ (void)load {
    KLGSwizzleInstanceMethod([NSClassFromString(@"UITableViewHeaderFooterView") class],
                             @selector(prepareForReuse),
                             @selector(klg_prepareForReuse));
}

+ (BOOL)klg_shouldAppendHeaderFooterViewItemToReuseIdentifier {
    return NO;
}

- (BOOL)klg_updateHeaderFooterViewItem:(id<KLGTableViewHeaderFooterViewItem>)headerFooterViewItem {
    if (!self.klg_headerFooterViewItem || [[self class] klg_shouldAppendHeaderFooterViewItemToReuseIdentifier]) {
        self.klg_headerFooterViewItem = headerFooterViewItem;
        if ([headerFooterViewItem respondsToSelector:@selector(setCurrentView:)]) {
            headerFooterViewItem.currentView = self;
        }
        return YES;
    } else {
        return NO;
    }
}


- (void)klg_prepareForReuse {
    if (![[self class] klg_shouldAppendHeaderFooterViewItemToReuseIdentifier]) {
        if ([self.klg_headerFooterViewItem respondsToSelector:@selector(currentView)] && self.klg_headerFooterViewItem.currentView == self) {
            if ([self.klg_headerFooterViewItem respondsToSelector:@selector(setCurrentView:)]) {
                self.klg_headerFooterViewItem.currentView = nil;
            }
        }
        self.klg_headerFooterViewItem = nil;
    }
    [self klg_prepareForReuse];
}

#pragma mark - getter && setter
- (id<KLGTableViewHeaderFooterViewItem>)klg_headerFooterViewItem {
    return objc_getAssociatedObject(self, &headerFooterViewItemKey);
}

- (void)setKlg_headerFooterViewItem:(id<KLGTableViewHeaderFooterViewItem>)klg_headerFooterViewItem {
    if ([klg_headerFooterViewItem respondsToSelector:@selector(staticView)] && !!klg_headerFooterViewItem.staticView) { // 防止循环引用
        objc_setAssociatedObject(self, &headerFooterViewItemKey, klg_headerFooterViewItem, OBJC_ASSOCIATION_ASSIGN);
    } else {
        objc_setAssociatedObject(self, &headerFooterViewItemKey, klg_headerFooterViewItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

@end
