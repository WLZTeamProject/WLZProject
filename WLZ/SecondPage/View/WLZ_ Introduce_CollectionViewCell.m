//
//  WLZ_ Introduce_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_ Introduce_CollectionViewCell.h"

@interface WLZ__Introduce_CollectionViewCell () <UIWebViewDelegate>

@end

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
    self.webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 120)];
    self.webV.dataDetectorTypes = UIDataDetectorTypeAll;
    self.webV.delegate = self;
    [self addSubview:self.webV];
    [_webV release];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //字体颜色
    [self.webV stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor='green'"];
    
    //页面背景色
    [self.webV stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#5EA5E5'"];
    [self.webV stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 30.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [self.webV stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];

}

@end
