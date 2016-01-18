//
//  WLZ_Other_CollectionViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLZ_PCH.pch"
@interface WLZ_Other_CollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *mainImageV;

@property (nonatomic, retain) UIImageView *originalImageV;

@property (nonatomic, retain) WLZBaseLabel *mainL;

@property (nonatomic, retain) WLZBaseLabel *originalL;

@property (nonatomic, retain) WLZBaseLabel *comfromL;

@property (nonatomic, retain) NSMutableArray *imageArr;



@end
