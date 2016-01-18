//
//  WLZ_LunBo_View.h
//  WLZ
//
//  Created by 왕닝 on 16/1/18.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLZ_LunBo_View : UIView<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;
- (void)createSubviews;
@end
