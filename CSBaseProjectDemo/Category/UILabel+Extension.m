//
//  UILabel+Extension.m
//  MVC-Demo
//
//  Created by cs on 2019/4/17.
//  Copyright © 2019 cs. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (void)fitSizeWidth {
    [self fitSizeWidth:0];
}

- (void)fitSizeHeight {
    [self fitSizeHeight:0];
}

- (void)fitSizeHeight:(float)padding {
    float srcWidth = self.width;
    [self sizeToFit];
    float srcHeight = self.height;
    self.width = srcWidth;
    self.height = srcHeight + padding * 2;
}

- (void)fitSizeWidth:(float)padding {
    float srcHeight = self.height;
    [self sizeToFit];
    self.width = self.width + padding * 2;
    self.height = srcHeight;
}

@end
