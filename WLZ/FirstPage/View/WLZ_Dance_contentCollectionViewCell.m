//
//  WLZ_Dance_contentCollectionViewCell.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_contentCollectionViewCell.h"
#import "WLZ_Dance_ListModel.h"
@implementation WLZ_Dance_contentCollectionViewCell

- (void)dealloc
{
    
    [_titleL release];
    [_catalogL release];
    [_catalogthemrL release];
    [_productL release];
    [_productthemeL release];
    [_purposeL release];
    [_purposethemeL release];
    [_suitableL release];
    [_suitablethemeL release];
    [_groupL release];
    [_groupthemeL release];
    [_genderL release];
    [_genderthemeL release];
    [_summaryL release];
    [_summarythemeL release];
    [_scrollV release];
    [super dealloc];
    
}

+ (CGFloat)heightWithStr:(NSString *)str
{
    CGRect frame = [str boundingRectWithSize:CGSizeMake(300, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName] context:nil];
    return frame.size.height;
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
    self.backgroundColor = [UIColor grayColor];
    
    self.scrollV = [[UIScrollView alloc] init];
    self.scrollV.backgroundColor = [UIColor magentaColor];
    [self.contentView addSubview:self.scrollV];
    
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 20, 100)];
    self.titleL.backgroundColor = [UIColor blueColor];
//    NSLog(@"得得得得%@", self.wlzDance);
//    self.titleL.text = self.wlzDance.item_title;
    [self.scrollV addSubview:self.titleL];
    
    self.catalogthemrL = [[UILabel alloc] init];
    self.catalogthemrL.text = @"主要舞种";
    [self.scrollV addSubview:self.catalogthemrL];
    self.catalogL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.catalogL];
    self.productthemeL = [[UILabel alloc] init];
    self.productthemeL.text = @"舞蹈产品";
    [self.scrollV addSubview:self.productthemeL];
    self.productL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.productL];
    self.purposethemeL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.purposethemeL];
    self.purposethemeL.text = @"用途目标";
    self.purposeL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.purposeL];
    
    self.suitableL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.suitableL];
    
    self.suitablethemeL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.suitablethemeL];
    self.summarythemeL.text = @"适合人群";
    
    self.groupL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.groupL];
    self.groupthemeL = [[UILabel alloc] init];
    self.groupthemeL.text = @"形式";
    [self.scrollV addSubview:self.groupthemeL];
    self.genderthemeL = [[UILabel alloc] init];
    self.genderthemeL.text = @"性别";
    [self.scrollV addSubview:self.genderthemeL];
    self.genderL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.genderL];
    
    self.summaryL = [[UILabel alloc] init];
    [self.scrollV addSubview:self.summaryL];
    self.summarythemeL = [[UILabel alloc] init];
    self.summarythemeL.text = @"简介";
    [self.scrollV addSubview:self.summarythemeL];
   
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollV.frame = self.contentView.frame;
    
    self.titleL.frame = CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 20, 50);
    
//    CGFloat height = [[self class] heightWithStr:self.titleL.text];
//    CGRect framel = self.titleL.frame;
//    framel.size.height = height;
//    self.titleL.frame = framel;
    
//    self.scrollV.contentSize = CGSizeMake(0, self.titleL.frame.size.height);
    
    
}

@end
