//
//  UIView+CSExtension.h
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 UIView 相关分类
 */
@interface UIView (CSExtension)

@property (assign, nonatomic) CGFloat cs_x;
@property (assign, nonatomic) CGFloat cs_y;
@property (assign, nonatomic) CGFloat cs_width;
@property (assign, nonatomic) CGFloat cs_height;
@property (assign, nonatomic) CGSize cs_size;
@property (assign, nonatomic) CGPoint cs_origin;

@end

NS_ASSUME_NONNULL_END
