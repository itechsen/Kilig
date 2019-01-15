//
//  KLGViewModelProtocol.h
//  Pods
//
//  Created by chenyusen on 2018/6/12.
//

#ifndef KLGViewModelProtocol_h
#define KLGViewModelProtocol_h

#import <Foundation/Foundation.h>
#import "KLGTableViewAction.h"
#import "KLGTableViewModel.h"
#import "KLGViewModelRequestProtocol.h"

@protocol KLGViewViewModelProtocol;

@protocol KLGViewViewModelDelegateProtocol<NSObject>

/**
 数据开始加载
 
 @param viewViewModel 指定KLGViewViewModelProtocol协议实例对象
 @param forMore 是否是增量更新
 */
- (void)klg_viewViewModel:(id<KLGViewViewModelProtocol>)viewViewModel
      didStartLoadForMore:(BOOL)forMore;


/**
 数据成功加载完成回调
 
 @param viewViewModel 指定KLGViewViewModelProtocol协议实例对象
 @param data 成功加载的数据数组,由于请求是个数组,所以返回也是对应的数组
 @param forMore 是否是增量更新
 */
- (void)klg_viewViewModel:(id<KLGViewViewModelProtocol>)viewViewModel
    didFinishLoadWithData:(NSArray *)data
                  forMore:(BOOL)forMore;


/**
 数据加载失败回调
 
 @param viewViewModel 指定KLGViewViewModelProtocol协议实例对象
 @param errors 错误数组, 由于请求是个数组,所以返回也是对应的数组
 @param forMore 是否是增量更新
 */
- (void)klg_viewViewModel:(id<KLGViewViewModelProtocol>)viewViewModel
     didFailLoadWithError:(NSArray<NSError *> *)errors
                  forMore:(BOOL)forMore;

@end


/**
 支持分页加载的数据请求
 */
@protocol KLGViewViewModelProtocol<NSObject>
@required
/**
 是否正在加载
 */
@property (nonatomic, assign, readonly, getter=isLoading) NSInteger loading;

/**
 是否加载过数据
 */
@property (nonatomic, assign, readonly, getter=isLoaded) NSInteger loaded;

/**
 是否支持分页
 */
@property (nonatomic, assign) BOOL isPaged;

/**
 组成试图数据的请求数组
 */
@property (nonatomic, strong, readonly) NSArray<id<KLGViewModelRequestProtocol>> *requests;

/**
 代理回调
 */
@property (nonatomic, weak, readonly) id<KLGViewViewModelDelegateProtocol> delegate;

/**
 请求数据

 @param forMore 是否为请求更多数据
 */
- (void)updateDataForMore:(BOOL)forMore;
@end


@protocol KLGTableViewViewModelProtocol<KLGViewViewModelProtocol>

@property (nonatomic, strong, readonly) KLGTableViewModel *tableViewModel;
@property (nonatomic, strong, readonly) KLGTableViewAction *tableViewAction;

@end

#endif /* KLGViewModelProtocol_h */
