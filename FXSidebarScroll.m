//
//  FXSidebarScroll.m
//  ;
//
//  Created by xformax on 15/12/31.
//  Copyright © 2015年 Miffy. All rights reserved.
//

#import "FXSidebarScroll.h"

@interface FXSidebarScroll ()<UIScrollViewDelegate> {
    UIView *_subView;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@end

static CGFloat const background_MaxAlpha = 0.7;
static CGFloat const background_minAlpha = 0.0;

@implementation FXSidebarScroll

- (instancetype)sidebarScrollWithsubView:(UIView *)subView withFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.scrollView];
        
        [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
        
        _subView = subView;
        [self.scrollView addSubview:_subView];
        [_subView setFrame:CGRectMake(frame.size.width, 0, _subView.frame.size.width, _subView.frame.size.height)];
        [self.scrollView setContentSize:CGSizeMake(_subView.frame.size.width * 2, _subView.frame.size.height)];
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        
        self.hidden = YES;
    }
    return self;
}

- (void)show {
    if(_subView) {
        self.hidden = NO;
        if (self.blockWillShow) {
            self.blockWillShow();
        }
        [self.scrollView setContentOffset:CGPointMake(_subView.frame.size.width, 0) animated:YES];
    }
}

- (void)hide {
    if (_subView) {
        if (self.blockWillHiden) {
            self.blockWillHiden();
        }
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [_subView endEditing:YES];
    }
}

#pragma UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGFloat precent = background_minAlpha + (scrollView.contentOffset.x / scrollView.frame.size.width) * background_MaxAlpha;
        
        if (precent <= 0) {
            self.hidden = YES;
            if (self.blockDidHiden) {
                self.blockDidHiden();
            }
        }
        else if (precent > background_MaxAlpha) {
            precent = background_MaxAlpha;
        }
        
        if (self.blockReturnScrollPrecent) {
            self.blockReturnScrollPrecent(precent);
        }
    }
}

#pragma Instance

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

@end
