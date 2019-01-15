//
//  KLGTableViewHeaderFooterViewItem.m
//  Kilig
//
//  Created by chenyusen on 2018/5/22.
//

#import "KLGTableViewHeaderFooterViewItem.h"

KLGTableViewHeaderFooterViewItemKey const KLGTableViewHeaderFooterViewModelAttribute = @"com.kilig.KLGTableViewHeaderFooterViewItemKey.KLGTableViewHeaderFooterViewModelAttribute";
KLGTableViewHeaderFooterViewItemKey const KLGTableViewHeaderFooterViewHeightAttribute = @"com.kilig.KLGTableViewHeaderFooterViewItemKey.KLGTableViewHeaderFooterViewHeightAttribute";
KLGTableViewHeaderFooterViewItemKey const KLGTableViewHeaderFooterViewClassAttribute = @"com.kilig.KLGTableViewHeaderFooterViewItemKey.KLGTableViewHeaderFooterViewClassAttribute";

@implementation KLGTableViewHeaderFooterViewItem


- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        if (attributes) {
            self.model = attributes[KLGTableViewHeaderFooterViewModelAttribute];
            self.viewClass = attributes[KLGTableViewHeaderFooterViewClassAttribute];
            self.viewHeight = [attributes[KLGTableViewHeaderFooterViewHeightAttribute] doubleValue];
        }
    }
    return self;
}

- (instancetype)initWithModel:(id)model
                    viewClass:(Class)viewClass
                   viewHeight:(CGFloat)viewHeight {
    NSDictionary *attributes = @{
                                 KLGTableViewHeaderFooterViewModelAttribute : model ?: @{},
                                 KLGTableViewHeaderFooterViewHeightAttribute : @(viewHeight),
                                 KLGTableViewHeaderFooterViewClassAttribute : viewClass ?: [UITableViewHeaderFooterView class]
                                 };
    return [self initWithAttributes:attributes];
}

@end
