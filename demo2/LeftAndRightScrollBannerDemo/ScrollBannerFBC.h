//
//  ScrollBannerFBC.h
//  LeftAndRightScrollBannerDemo
//
//  Created by Karl on 2018/6/25.
//  Copyright © 2018 Derek. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREENHIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@protocol ScrollBannerFBCdelegate<NSObject>
//代理事件
-(void)imageViewIsTaped:(UITapGestureRecognizer *)tap;//图片被点击事件
-(void)autoScrollToWhichBanner:(UIImageView *)imageView;//自动滚动到哪一张图，非人为拖动

@end

@interface ScrollBannerFBC : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainSV;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIImageView * bgChangeV;
@property (nonatomic,assign) CGRect bgChangeVFrame;
@property (nonatomic,strong) NSArray *bgChangeArray;
@property (nonatomic,strong) UIPageControl *page;
@property (nonatomic,strong) UIImageView * leftV;
@property (nonatomic,strong) UIImageView * rightV;
@property (nonatomic,assign) int count;
@property (nonatomic,assign) BOOL hideLeftRight;

@property (nonatomic,assign) id<ScrollBannerFBCdelegate> delegate;

//初始化布局、图片数组、联动背景数组、是否隐藏左右小图
-(instancetype)initWithFrame:(CGRect)Backframe andBannerArray:(NSArray *)bannerArray andBannerBackGroundArray:(NSArray *)BannerBackGroundArray andHideLeftRight:(BOOL)HideLeftRight;

@end
