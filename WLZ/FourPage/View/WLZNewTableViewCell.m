//
//  WLZNewTableViewCell.m
//  WLZ
//
//  Created by lqq on 16/1/12.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZNewTableViewCell.h"
#import "WLZNewsHomeCollectionCell.h"

#import "WLZNewFirstModel.h"
#import <UIImageView+WebCache.h>
@interface WLZNewTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) UICollectionView *collectView;

@end

@implementation WLZNewTableViewCell
- (void)dealloc
{
    [_collectView release];
    [_newsArr release];
    [super dealloc];
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews
{
    [self createCollectView];
}
- (void)createCollectView
{
    
    UICollectionViewFlowLayout *fwl = [[UICollectionViewFlowLayout alloc] init];
    fwl.itemSize = CGSizeMake((UIWIDTH - 60) / 2, (UIWIDTH - 60) / 2 / 4 * 3);
    fwl.scrollDirection = UICollectionViewScrollDirectionVertical;
    fwl.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    fwl.minimumLineSpacing = 0;
    fwl.minimumInteritemSpacing = 0;
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fwl];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.scrollEnabled = NO;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectView];
    [_collectView release];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
    [self.collectView registerClass:[WLZNewsHomeCollectionCell class] forCellWithReuseIdentifier:@"cell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"collect:%ld", self.newsArr.count);
    return self.newsArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLZNewsHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (self.newsArr.count != 0) {
        WLZNewFirstModel *model = [self.newsArr objectAtIndex:indexPath.row];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"kafei"]];
        if (model.brief.length == 0) {
            cell.briefLabel.backgroundColor = [UIColor clearColor];
        }
        cell.briefLabel.text = model.brief;
        cell.titleLabel.text = model.title;
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     WLZNewFirstModel *model = [self.newsArr objectAtIndex:indexPath.row];
    [self.delegate tableViewCellHandle:model];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
