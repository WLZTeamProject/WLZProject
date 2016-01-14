//
//  WLZ_Dance_detailCollectionViewCell.h
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/13.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLZ_Dance_detailCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSMutableArray *arr;
- (void)setArr:(NSMutableArray *)arr;
- (void)setTitle:(NSString *)title;
@end
