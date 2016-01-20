//
//  WLZ_LunBo_View.m
//  WLZ
//
//  Created by 왕닝 on 16/1/18.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_LunBo_View.h"
#import "WLZ_PCH.pch"
#import "UIImageView+WebCache.h"
@interface WLZ_LunBo_View ()<UIScrollViewDelegate>
@property (nonatomic, retain) UIScrollView *scrollV;    //
@property (nonatomic, retain) UIPageControl *pageC;     //
@property (nonatomic, assign) NSInteger previousPage;   //当前图片页数
@property (nonatomic, retain) NSTimer *timer;
@end

@implementation WLZ_LunBo_View
- (void)dealloc
{
    [_newsTitleArr release];
    [_imageArr release];
    [_scrollV release];
    [_pageC release];
    [_timer release];
    [super dealloc];
}

//照片数组setter
- (void)setImageArr:(NSArray *)imageArr {
    
    if (_imageArr != imageArr) {
        [_imageArr release];
        _imageArr = [imageArr retain];
        
    }
    //刷新scrollView
    [self reloadDataScrollView];
    
    //创建计时器
    [self setUpTimer];
    
}
- (void) reloadDataScrollView {
    //page 页数
    self.pageC.numberOfPages = self.imageArr.count;
    //scrollView
    self.scrollV.contentSize = CGSizeMake(self.bounds.size.width * (self.imageArr.count + 2), 0);
    [self addImagesToScrollView];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}
- (void)createView {
    //创建scrollView
    [self createScrollView];
    //创建PageControl
    [self createPageControl];
}
/**
 *  时间计数器
 */
- (void)setUpTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5. target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    //加入主循环池中
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    _timer = timer;
    
}

/**
 *  定时器方法
 */
- (void)timerAction {
    if(self.imageArr.count > 1) {
        //每次都把pageControl往下加一个
        self.pageC.currentPage = (self.pageC.currentPage + 1) % self.imageArr.count;
        //执行pageControl 值改变方法
        [self pageAction];
    }
}
/**
 *  往scroll上添加图片
 */
- (void) addImagesToScrollView {
    
    for (NSInteger i = 0;i < self.imageArr.count + 2; i++) {
        //创建一个imageView 往scroll铺
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width * i , 0, self.bounds.size.width, self.bounds.size.height)];
        imageV.userInteractionEnabled = YES;
        imageV.layer.cornerRadius = 8;
        imageV.layer.masksToBounds = YES;
        //此处重点:多加两张图(最后一张和第一张)
        if (0 == i) {
            //第一张图 的位置 最后一张
            [imageV sd_setImageWithURL:[NSURL URLWithString:[self.imageArr lastObject]] placeholderImage:[UIImage imageNamed:@"kafei"]];

        }else if(self.imageArr.count + 1 == i) {
            //最后一张的位置 铺第一张图
            //            imageV.image = self.imageArr[0] ;
            [imageV sd_setImageWithURL:[NSURL URLWithString:[self.imageArr firstObject]] placeholderImage:[UIImage imageNamed:@"kafei"]];
        }else {
            //i - 1: scroll是从 1 开始的 不是 0
            //            imageV.image = self.imageArr[i - 1];
            [imageV sd_setImageWithURL:[NSURL URLWithString:self.imageArr[i - 1]] placeholderImage:[UIImage imageNamed:@"kafei"]];
        }
        //添加手势
        UITapGestureRecognizer *imageTap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
        [imageV addGestureRecognizer:imageTap];
        [imageTap release];
        [self.scrollV addSubview:imageV];
        [imageV release];
    }
}
/**
 *  轻拍手势方法
 *
 *  @param sender
 */
- (void)imageTapAction:(UIImageView *)sender {
    
    //协议方法  传送点击是轮播图的哪一页
    [self.delegate sendTapImfo:self.pageC.currentPage];
}

/**
 *  创建ScrollView
 */
- (void)createScrollView {
    self.scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.scrollV.showsHorizontalScrollIndicator = NO;
    self.scrollV.delegate = self;
    self.scrollV.pagingEnabled = YES;
    self.scrollV.contentOffset = CGPointMake(self.bounds.size.width, 0);
    [self addSubview:self.scrollV];
    [_scrollV release];
    self.previousPage = 1;
}

/**
 *  创建PageControl
 */
- (void)createPageControl {
    self.pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, VHEIGHT - 10, 10, 5)];
    self.pageC.backgroundColor = [UIColor clearColor];
    self.pageC.currentPageIndicatorTintColor = [UIColor blueColor];
    self.pageC.pageIndicatorTintColor = [UIColor whiteColor];
    [self.pageC addTarget:self action:@selector(pageAction) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageC];
    [_pageC release];
}

//页随点动
/**
 *  pageControl 值改变 调用此方法
 */
- (void)pageAction {
    
    
    //记住每一次改变后的图片前一页是哪一张
    self.previousPage = self.scrollV.contentOffset.x / self.bounds.size.width;
    
    [self.scrollV setContentOffset: CGPointMake(self.bounds.size.width * (self.pageC.currentPage + 1), 0) animated:YES] ;
    
}
//点随页动
/**
 *  scrollView 协议方法拖动结束: 图片改变 点也随着动
 *
 *  @param scrollView
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //图片在第几页
    NSInteger currentPage = self.scrollV.contentOffset.x / self.bounds.size.width;
    
    //第一张图片 就是最后一张
    if (0 == currentPage) {
        self.scrollV.contentOffset = CGPointMake(self.bounds.size.width * self.imageArr.count, 0);
    }else if(self.imageArr.count + 1 == currentPage) {
        
        self.scrollV.contentOffset = CGPointMake(self.bounds.size.width, 0);
    }
    self.pageC.currentPage = (self.scrollV.contentOffset.x / self.bounds.size.width) - 1;
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.timer invalidate];
    self.timer = nil;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [self setUpTimer];
    
}



@end
