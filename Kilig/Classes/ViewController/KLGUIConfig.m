//
//  KLGUIConfig.m
//  Kilig
//
//  Created by chenyusen on 2018/6/29.
//

#import "KLGUIConfig.h"

static Class kLoadingViewClass;
static KLGUIStatusViewConfig *kStatusView;

static NSString *kEmptyString = @"暂无数据";
static NSString *kErrorString = @"数据异常";
static NSString *kNoNetworkString = @"无网络";

static UIImage *kEmptyImage;
static UIImage *kErrorImage;
static UIImage *kNonetworkImage;

static CGFloat kContentOffSetY = 0;

@implementation KLGUIConfig

+ (Class)loadingViewClass {
    return kLoadingViewClass;
}

+ (void)setLoadingViewClass:(Class)loadingViewClass {
    kLoadingViewClass = loadingViewClass;
}


+ (KLGUIStatusViewConfig *)statusView {
    if (!kStatusView) {
        kStatusView = [[KLGUIStatusViewConfig alloc] init];
    }
    return kStatusView;
}

@end


@implementation KLGUIStatusViewConfig

+ (NSString *)emptyString {
    return kEmptyString;
}

+ (void)setEmptyString:(NSString *)emptyString {
    kEmptyString = emptyString;
}

+ (NSString *)errorString {
    return kErrorString;
}

+ (void)setErrorString:(NSString *)errorString {
    kErrorString = errorString;
}

+ (NSString *)noNetworkString {
    return kNoNetworkString;
}

+ (void)setNoNetworkString:(NSString *)noNetworkString {
    kNoNetworkString = noNetworkString;
}

+ (UIImage *)emptyImage {
    return kEmptyImage;
}

+ (void)setEmptyImage:(UIImage *)emptyImage {
    kEmptyImage = emptyImage;
}

+ (UIImage *)errorImage {
    return kErrorImage;
}

+ (void)setErrorImage:(UIImage *)errorImage {
    kErrorImage = errorImage;
}

+ (UIImage *)noNetworkImage {
    return kNonetworkImage;
}

+ (void)setNoNetworkImage:(UIImage *)noNetworkImage {
    kNonetworkImage = noNetworkImage;
}

+ (CGFloat)contentOffSetY {
    return kContentOffSetY;
}

+ (void)setContentOffSetY:(CGFloat)contentOffSetY {
    kContentOffSetY = contentOffSetY;
}

@end
