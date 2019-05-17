//
//  UIScrollView+CSExtension.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 UIEdgeInsets 相关属性分类
 */
@interface UIScrollView (CSExtension)

@property (readonly, nonatomic) UIEdgeInsets cs_inset;

@property (assign, nonatomic) CGFloat cs_insetTop;
@property (assign, nonatomic) CGFloat cs_insetBottom;
@property (assign, nonatomic) CGFloat cs_insetLeft;
@property (assign, nonatomic) CGFloat cs_insetRight;

@property (assign, nonatomic) CGFloat cs_offsetX;
@property (assign, nonatomic) CGFloat cs_offsetY;

@property (assign, nonatomic) CGFloat cs_contentWidth;
@property (assign, nonatomic) CGFloat cs_contentHeight;

@end

NS_ASSUME_NONNULL_END
