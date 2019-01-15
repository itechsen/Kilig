//
//  KLGUIConfig.h
//  Kilig
//
//  Created by chenyusen on 2018/6/29.
//

#import <Foundation/Foundation.h>

@class KLGUIStatusViewConfig;

@interface KLGUIConfig : NSObject

@property (nonatomic, strong, class) Class loadingViewClass;

@property (nonatomic, strong, readonly, class) KLGUIStatusViewConfig *statusView;

@end


/* 默认状态视图相关配置
 */
@interface KLGUIStatusViewConfig : NSObject
@property (nonatomic, strong, class) NSString *emptyString;
@property (nonatomic, strong, class) NSString *errorString;
@property (nonatomic, strong, class) NSString *noNetworkString;

@property (nonatomic, strong, class) UIImage *emptyImage;
@property (nonatomic, strong, class) UIImage *errorImage;
@property (nonatomic, strong, class) UIImage *noNetworkImage;

@property (nonatomic, assign, class) CGFloat contentOffSetY;

@end
