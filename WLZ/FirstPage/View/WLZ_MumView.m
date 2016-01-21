//
//  WLZ_MumView.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/21.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_MumView.h"

@interface WLZ_MumView ()
@property (nonatomic, retain) UIActivityIndicatorView *actIndic;

@end

@implementation WLZ_MumView

- (void)dealloc
{
    [_actIndic release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews
{
    self.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2 - self.bounds.size.width / 8, self.bounds.size.width / 2, self.bounds.size.width / 4, self.bounds.size.width / 4)];
    view.layer.cornerRadius = 10;
    [view setTag:10020];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [self addSubview:view];
    [view release];
    
    self.actIndic = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [self.actIndic setCenter:view.center];
    [self.actIndic setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self addSubview:self.actIndic];
    [self.actIndic startAnimating];
    [_actIndic release];
}

- (void)stopActivityIndicator
{
    [self.actIndic stopAnimating];
    UIView *view = (UIView *)[self viewWithTag:10020];
    [view removeFromSuperview];
    [self removeFromSuperview];
}

@end
