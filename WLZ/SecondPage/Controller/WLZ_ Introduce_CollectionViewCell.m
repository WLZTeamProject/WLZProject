//
//  WLZ_ Introduce_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_ Introduce_CollectionViewCell.h"

@implementation WLZ__Introduce_CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)setUrl:(NSString *)url
{
    if (_url != url) {
        [_url release];
        _url = [url copy];
    }
    NSURL *URL = [NSURL URLWithString:self.url];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [_webV loadRequest:request];
}


- (void)createSubviews
{
    self.webV = [[UIWebView alloc] initWithFrame:self.bounds];
    self.webV.dataDetectorTypes = UIDataDetectorTypeAll;
    [self addSubview:self.webV];
    [_webV release];
}

@end
