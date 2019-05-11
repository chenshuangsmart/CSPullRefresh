//
//  UIView+CSExtension.m
//  CSBaseProjectDemo
//
//  Created by cs on 2019/5/11.
//  Copyright © 2019 cs. All rights reserved.
//

#import "UIView+CSExtension.h"

@implementation UIView (CSExtension)

- (void)setCs_x:(CGFloat)cs_x {
    CGRect frame = self.frame;
    frame.origin.x = cs_x;
    self.frame = frame;
}

- (CGFloat)cs_x {
    return self.frame.origin.x;
}

- (void)setCs_y:(CGFloat)cs_y {
    CGRect frame = self.frame;
    frame.origin.y = cs_y;
    self.frame = frame;
}

- (CGFloat)cs_y {
    return self.frame.origin.y;
}

- (void)setCs_width:(CGFloat)cs_width {
    CGRect frame = self.frame;
    frame.size.width = cs_width;
    self.frame = frame;
}

- (CGFloat)cs_width {
    return self.frame.size.width;
}

- (void)setCs_height:(CGFloat)cs_height {
    CGRect frame = self.frame;
    frame.size.height = cs_height;
    self.frame = frame;
}

- (CGFloat)cs_height {
    return self.frame.size.height;
}

- (void)setCs_size:(CGSize)cs_size {
    CGRect frame = self.frame;
    frame.size = cs_size;
    self.frame = frame;
}

- (CGSize)cs_size {
    return self.frame.size;
}

- (void)setCs_origin:(CGPoint)cs_origin {
    CGRect frame = self.frame;
    frame.origin = cs_origin;
    self.frame = frame;
}

- (CGPoint)cs_origin {
    return self.frame.origin;
}

@end
