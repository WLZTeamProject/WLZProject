//
//  WLZ_Dance_contentCollectionViewCell.h
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLZ_Dance_ListModel;
@interface WLZ_Dance_contentCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) UILabel *titleL;
@property (nonatomic, retain) UILabel *catalogL;
@property (nonatomic, retain) UILabel *catalogthemrL;
@property (nonatomic, retain) UILabel *productL;
@property (nonatomic, retain) UILabel *productthemeL;
@property (nonatomic, retain) UILabel *purposeL;
@property (nonatomic, retain) UILabel *purposethemeL;
@property (nonatomic, retain) UILabel *suitableL;
@property (nonatomic, retain) UILabel *suitablethemeL;
@property (nonatomic, retain) UILabel *groupL;
@property (nonatomic, retain) UILabel *groupthemeL;

@property (nonatomic, retain) UILabel *genderL;
@property (nonatomic, retain) UILabel *genderthemeL;

@property (nonatomic, retain) UILabel *summaryL;
@property (nonatomic, retain) UILabel *summarythemeL;

@property (nonatomic, retain) UIScrollView *scrollV;

@property (nonatomic, retain) WLZ_Dance_ListModel *wlzDance;

+ (CGFloat)heightWithStr:(NSString *)str;


@end
