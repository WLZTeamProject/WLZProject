//
//  WLZ_LunBo_View.h
//  WLZ
//
//  Created by 왕닝 on 16/1/18.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LunBoTapDelegate <NSObject>

- (void)sendTapImfo:(NSInteger)index;

@end
@interface WLZ_LunBo_View : UIView<UIScrollViewDelegate>
@property (nonatomic, assign) id<LunBoTapDelegate> delegate;
@property (nonatomic, retain) NSArray *imageArr;
@property (nonatomic, retain) NSArray *newsTitleArr;
@end
