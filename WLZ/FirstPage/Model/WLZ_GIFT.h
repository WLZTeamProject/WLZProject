//
//  WLZ_GIFT.h
//  WLZ
//
//  Created by 왕닝 on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLZ_GIFT : UIView

+ (void)show;
+ (void)showWithOverlay;
+ (void)dismiss;

+ (void)setGifWithImages:(NSArray *)images;
+ (void)setGifWithImageName:(NSString *)imageName;
+ (void)setGifWithURL:(NSURL *)gifUrl;
+ (UIImage *)animatedImageWithAnimatedGIFURL:(NSURL *)url;

@end
