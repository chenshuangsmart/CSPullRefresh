//
//  UIScrollView+CSExtension.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import "UIScrollView+CSExtension.h"
#import <objc/runtime.h>

/// 去除编译警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@implementation UIScrollView (CSExtension)

static BOOL respondsToAdjustedContentInset_;    // 是否支持adjustedContentInset方法

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        respondsToAdjustedContentInset_ = [self instancesRespondToSelector:@selector(adjustedContentInset)];
    });
}

- (UIEdgeInsets)cs_inset {
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        return self.adjustedContentInset;
    }
#endif
    return self.contentInset;
}

- (CGFloat)cs_insetTop {
    return self.cs_inset.top;
}

- (void)setCs_insetTop:(CGFloat)cs_insetTop {
    UIEdgeInsets inset = self.contentInset;
    inset.top = cs_insetTop;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.top -= (self.adjustedContentInset.top - self.contentInset.top);
    }
#endif
    self.contentInset = inset;
}

@end

#pragma clang diagnostic pop
