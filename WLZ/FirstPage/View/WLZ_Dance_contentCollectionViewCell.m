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
    self.backgroundColor = [UIColor clearColor];
    
    self.scrollV = [[UIScrollView alloc] init];
//    self.scrollV.backgroundColor = [UIColor magentaColor];
//    self.scrollV.frame = self.contentView.frame;
//    self.scrollV.contentSize = CGSizeMake(0, 1000);
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 20, 0)];
    self.titleL.numberOfLines = 0;

    [self.scrollV addSubview:self.titleL];
    
    self.catalogthemrL = [[UILabel alloc] init];
    self.catalogthemrL.text = @"主要舞种";
    [self.scrollV addSubview:self.catalogthemrL];
//    self.catalogthemrL.backgroundColor = [UIColor greenColor];
    self.catalogL = [[UILabel alloc] init];
//    self.catalogL.backgroundColor = [UIColor redColor];
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
    self.suitablethemeL.text = @"适合人群";
    [self.scrollV addSubview:self.suitablethemeL];
    
    
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
    self.summaryL.numberOfLines = 0;
//    self.summaryL.backgroundColor = [UIColor greenColor];
    [self.scrollV addSubview:self.summaryL];
    self.summarythemeL = [[UILabel alloc] init];
    self.summarythemeL.text = @"简介";
    [self.scrollV addSubview:self.summarythemeL];
   
    [self.contentView addSubview:self.scrollV];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

    self.scrollV.frame = self.contentView.frame;

    self.titleL.numberOfLines = 0;
    
    CGFloat height = [[self class] heightWithStr:self.titleL.text];
    CGRect framel = self.titleL.frame;
    framel.size.height = height;
    self.titleL.frame = framel;
    
    self.catalogthemrL.frame = CGRectMake(self.titleL.frame.origin.x, self.titleL.frame.size.height + self.titleL.frame.origin.y, self.contentView.frame.size.width / 4, [[UIScreen mainScreen] bounds].size.height / 27);
    self.catalogL.frame = CGRectMake(self.catalogthemrL.frame.size.width + self.catalogthemrL.frame.origin.x, self.catalogthemrL.frame.origin.y, self.contentView.frame.size.width / 4 * 3 - 20, self.catalogthemrL.frame.size.height);
    
    
    self.productthemeL.frame = CGRectMake(self.titleL.frame.origin.x, self.catalogthemrL.frame.size.height + self.catalogthemrL.frame.origin.y, self.contentView.frame.size.width / 4, self.catalogthemrL.frame.size.height);
    self.productL.frame = CGRectMake(self.catalogthemrL.frame.size.width + self.catalogthemrL.frame.origin.x, self.productthemeL.frame.origin.y, self.contentView.frame.size.width / 4 * 3 - 20, self.catalogthemrL.frame.size.height);
    
//    self.productthemeL.frame = CGRectMake(self.titleL.frame.origin.x, self.catalogthemrL.frame.size.height + self.catalogthemrL.frame.origin.y, self.contentView.frame.size.width / 4, [[UIScreen mainScreen] bounds].size.height / 30);
//    self.productL.frame = CGRectMake(self.catalogthemrL.frame.size.width + self.catalogthemrL.frame.origin.x, self.productthemeL.frame.origin.y, self.contentView.frame.size.width / 4 * 3, self.catalogthemrL.frame.size.height);
    
    self.purposethemeL.frame = CGRectMake(self.titleL.frame.origin.x, self.productthemeL.frame.size.height + self.productthemeL.frame.origin.y, self.contentView.frame.size.width / 4, self.catalogthemrL.frame.size.height);
    self.purposeL.frame = CGRectMake(self.catalogthemrL.frame.size.width + self.catalogthemrL.frame.origin.x, self.purposethemeL.frame.origin.y, self.contentView.frame.size.width / 4 * 3 - 20, self.catalogthemrL.frame.size.height);
    
    
    self.suitablethemeL.frame = CGRectMake(self.titleL.frame.origin.x, self.purposethemeL.frame.size.height + self.purposethemeL.frame.origin.y, self.contentView.frame.size.width / 4, self.catalogthemrL.frame.size.height);
    self.suitableL.frame = CGRectMake(self.catalogthemrL.frame.size.width + self.catalogthemrL.frame.origin.x, self.suitablethemeL.frame.origin.y, self.contentView.frame.size.width / 4 * 3 - 20, self.catalogthemrL.frame.size.height);
    
    self.groupthemeL.frame = CGRectMake(self.titleL.frame.origin.x, self.suitablethemeL.frame.size.height + self.suitablethemeL.frame.origin.y, self.contentView.frame.size.width / 4, self.catalogthemrL.frame.size.height);
    self.groupL.frame = CGRectMake(self.catalogthemrL.frame.size.width + self.catalogthemrL.frame.origin.x, self.groupthemeL.frame.origin.y, self.contentView.frame.size.width / 4 * 3 - 20, self.catalogthemrL.frame.size.height);
    
    self.genderthemeL.frame = CGRectMake(self.titleL.frame.origin.x, self.groupthemeL.frame.size.height + self.groupthemeL.frame.origin.y, self.contentView.frame.size.width / 4, self.catalogthemrL.frame.size.height);
    self.genderL.frame = CGRectMake(self.catalogthemrL.frame.size.width + self.catalogthemrL.frame.origin.x, self.genderthemeL.frame.origin.y, self.contentView.frame.size.width / 4 * 3 - 20, self.catalogthemrL.frame.size.height);
    
    self.summarythemeL.frame = CGRectMake(self.titleL.frame.origin.x, self.genderthemeL.frame.size.height + self.genderthemeL.frame.origin.y, self.contentView.frame.size.width / 4, self.catalogthemrL.frame.size.height);
    self.summaryL.frame = CGRectMake(self.catalogthemrL.frame.size.width + self.catalogthemrL.frame.origin.x, self.summarythemeL.frame.origin.y, self.contentView.frame.size.width / 4 * 3 - 20, self.catalogthemrL.frame.size.height);
    
    
    CGFloat sunHeight = [[self class] heightWithStr:self.summaryL.text];
    CGRect frameL = self.summaryL.frame;
    frameL.size.height = sunHeight;
    self.summaryL.frame = frameL;
    
    
    CGFloat allHeight = self.titleL.frame.size.height + self.catalogL.frame.size.height + self.productL.frame.size.height + self.purposeL.frame.size.height + self.suitableL.frame.size.height + self.groupL.frame.size.height + self.genderL.frame.size.height + self.summaryL.frame.size.height;
    
    
    
    
    
    
    
    
    self.scrollV.contentSize = CGSizeMake(0, allHeight);
    
    
    
    
    
}

@end
