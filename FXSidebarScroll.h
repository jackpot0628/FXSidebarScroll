//
//  FXSidebarScroll.h
//  Fenqile
//
//  Created by xformax on 15/12/31.
//  Copyright © 2015年 Miffy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FXSidebarScroll : UIView

@property (nonatomic, copy) void (^blockReturnScrollPrecent)(CGFloat precent);

@property (nonatomic, copy) void (^blockWillHiden)();

@property (nonatomic, copy) void (^blockDidHiden)();

@property (nonatomic, copy) void (^blockWillShow)();

- (instancetype)sidebarScrollWithsubView:(UIView *)subView withFrame:(CGRect)frame;

- (void)show;

- (void)hide;

@end
