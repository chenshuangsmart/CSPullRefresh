//
//  CSRefreshConst.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSRefreshConst : NSObject

#pragma mark - 常量

// 数值常量
extern const CGFloat kRefreshLabelLeftInset;
extern const CGFloat kRefreshHeaderHeight;
extern const CGFloat kRefreshFooterHeight;
extern const CGFloat kRefreshFastAnimationDuration;
extern const CGFloat kRefreshSlowAnimationDuration;

#pragma mark - observer

extern NSString *const kRefreshKeyPathContentOffset;
extern NSString *const kRefreshKeyPathContentInset;
extern NSString *const kRefreshKeyPathContentSize;
extern NSString *const kRefreshKeyPathPanState;

#pragma mark - 宏定义

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 异步主线程执行,不强持有 self
#define CSRefreshDispatchAsyncOnMainQueue(code)     \
__weak typeof (self) weakSelf = self;   \
dispatch_async(dispatch_get_main_queue(), ^{    \
    typeof (weakSelf) self = weakSelf;  \
    {code}  \
}); \

// 运行时objc_msgSend
#define CSRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define CSRefreshMsgTarget(target) (__bridge void *)(target)

@end

NS_ASSUME_NONNULL_END
