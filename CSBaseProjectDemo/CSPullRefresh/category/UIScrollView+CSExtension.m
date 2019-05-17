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

#pragma mark - UIEdgeInsets

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

- (CGFloat)cs_insetBottom {
    return self.cs_inset.bottom;
}

- (void)setCs_insetBottom:(CGFloat)cs_insetBottom {
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = cs_insetBottom;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.bottom -= (self.adjustedContentInset.bottom - self.contentInset.bottom);
    }
#endif
}

- (CGFloat)cs_insetLeft {
    return self.cs_inset.left;
}

- (void)setCs_insetLeft:(CGFloat)cs_insetLeft {
    UIEdgeInsets inset = self.contentInset;
    inset.left = cs_insetLeft;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.left -= (self.adjustedContentInset.left - self.contentInset.left);
    }
#endif
    self.contentInset = inset;
}

- (CGFloat)cs_insetRight {
    return self.cs_inset.right;
}

- (void)setCs_insetRight:(CGFloat)cs_insetRight {
    UIEdgeInsets inset = self.contentInset;
    inset.right = cs_insetRight;
#ifdef __IPHONE_11_0
    if (respondsToAdjustedContentInset_) {
        inset.right -= (self.adjustedContentInset.right - self.contentInset.right);
    }
#endif
    self.contentInset = inset;
}

#pragma mark - contentOffset

- (CGFloat)cs_offsetX {
    return self.contentOffset.x;
}

- (void)setCs_offsetX:(CGFloat)cs_offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = cs_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)cs_offsetY {
    return self.contentOffset.y;
}

- (void)setCs_offsetY:(CGFloat)cs_offsetY {
    CGPoint offset = self.contentOffset;
    offset.y = cs_offsetY;
    self.contentOffset = offset;
}

#pragma mark - contentSize

- (CGFloat)cs_contentWidth {
    return self.contentSize.width;
}

- (void)setCs_contentWidth:(CGFloat)cs_contentWidth {
    CGSize size = self.contentSize;
    size.width = cs_contentWidth;
    self.contentSize = size;
}

- (CGFloat)cs_contentHeight {
    return self.contentSize.height;
}

- (void)setCs_contentHeight:(CGFloat)cs_contentHeight {
    CGSize size = self.contentSize;
    size.height = cs_contentHeight;
    self.contentSize = size;
}

@end

#pragma clang diagnostic pop
