//
//  UILabel+Extension.h
//  MVC-Demo
//
//  Created by cs on 2019/4/17.
//  Copyright © 2019 cs. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)

- (void)fitSizeWidth;

- (void)fitSizeHeight;

- (void)fitSizeHeight:(float)padding;

- (void)fitSizeWidth:(float)padding;

@end

NS_ASSUME_NONNULL_END
