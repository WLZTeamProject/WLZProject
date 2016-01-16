//
//  WLZ_Play_CollectionViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLZ_PCH.pch"
@protocol WLZ_Play_CollectionViewCellDelegate <NSObject>

- (void)exchangeVol:(float)vol;


@end
@interface WLZ_Play_CollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *headImageV;

@property (nonatomic, retain) WLZBaseLabel *titleL;

@property (nonatomic, retain) UISlider *slider;

@property (nonatomic, strong) CADisplayLink *link;

@property (nonatomic, assign) id<WLZ_Play_CollectionViewCellDelegate> delegate;

@end
