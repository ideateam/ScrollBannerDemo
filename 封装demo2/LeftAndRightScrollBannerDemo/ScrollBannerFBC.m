//
//  ScrollBannerFBC.m
//  LeftAndRightScrollBannerDemo
//
//  Created by Karl on 2018/6/25.
//  Copyright © 2018 Derek. All rights reserved.
//

#import "ScrollBannerFBC.h"

@implementation ScrollBannerFBC

/*
 * Backframe  最底部的View布局位置
 * bannerArray 滚动banner图片数组
 * BannerBackGroundArray 背景联动图片数组
 * hideLeftRight 是否隐藏左右的小图
 */
-(instancetype)initWithFrame:(CGRect)Backframe andBannerArray:(NSArray *)bannerArray andBannerBackGroundArray:(NSArray *)BannerBackGroundArray andHideLeftRight:(BOOL)hideLeftRight{
    self = [super initWithFrame:Backframe];
    if (self) {
        
        self.bgChangeVFrame = Backframe;
        self.dataArray = bannerArray;
        self.bgChangeArray = BannerBackGroundArray;
        self.hideLeftRight = hideLeftRight;
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    
    [self addSubview:self.bgChangeV];

    
    if (self.hideLeftRight == YES) {
        
    }else{
        
        [self.bgChangeV addSubview:self.leftV];
        [self.bgChangeV addSubview:self.rightV];
    }
    
    [self.bgChangeV addSubview:self.mainSV];
    
    [self.bgChangeV addSubview:self.page];
    [self.bgChangeV bringSubviewToFront:self.page];
    
    
    for (int i = 0; i < _dataArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.bgChangeVFrame.size.width  +  65, 40, self.bgChangeVFrame.size.width - 130 ,  self.bgChangeVFrame.size.height - 80)];
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES ;
        imageView.layer.cornerRadius = 10;
        imageView.image = [UIImage imageNamed:_dataArray[i]];
        imageView.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        
        [_mainSV addSubview:imageView];
        
        if (i == 0) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
                
            }];
        }
        //NSLog(@"%d,%f",i,j);
    }
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(timerSencond) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    self.timer = timer;
    self.count = 0;
    
}
//NSTimer每2.5秒执行一次，也即滚动一次
-(void)timerSencond{
    
    if (_count == 0) {
        [_mainSV setContentOffset: CGPointMake((self.bgChangeVFrame.size.width) * self.count, 0)];
    }else{
        
        [UIView animateWithDuration:0.4 animations:^{
            __weak __typeof__(self) weakSelf = self;
            [weakSelf.mainSV setContentOffset: CGPointMake((self.bgChangeVFrame.size.width) * weakSelf.count, 0)];
        }];
    }
    
    //左右小图的轻微动画，这两张小图并非实际真实图片
    [UIView animateWithDuration:0.2 animations:^{
        
        __weak __typeof__(self) weakSelf = self;
        weakSelf.leftV.transform = CGAffineTransformMakeScale(0.4, 0.4);
        weakSelf.rightV.transform = CGAffineTransformMakeScale(0.4, 0.4);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.leftV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            weakSelf.rightV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        }];
        
    }];
    
    self.page.currentPage = self.count;
    
    //获取当前展示的banner图片和前、后图片
    UIImageView *v = [self.bgChangeV viewWithTag:100 + self.count];
    UIImageView *v1 = [self.bgChangeV viewWithTag:100 + self.count - 1];
    UIImageView *v2 = [self.bgChangeV viewWithTag:100 + self.count + 1];
    
    //NSLog(@"%@%@%@",v1,v2,v);
    
    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[self.count]]];
    
    //实际滚动图片的前一张和后一张后图片
    [UIView animateWithDuration:0.3 animations:^{
        
        v.transform = CGAffineTransformMakeScale(1.2, 1.2);
        [UIView animateWithDuration:0.3 animations:^{
            
            v1.transform = CGAffineTransformMakeScale(0.8, 0.8);
            v2.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
        }];
    }];
    
    self.count++;
    
    if (self.count >= _dataArray.count) {
        self.count = 0;
    }
}
-(void)tapImageView:(UITapGestureRecognizer *)tap {
    
   // UIImageView * V = (UIImageView *)tap.view;
   //NSLog(@"tapImageView = %ld",tap.view.tag);
    
    //点击了哪一个banner的图片,传出对应的UIImageView和tag值
    if ([_delegate respondsToSelector:@selector(imageViewIsTaped:)]) {
        [_delegate imageViewIsTaped:tap];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [UIView animateWithDuration:0.2 animations:^{
        __weak __typeof__(self) weakSelf = self;
        weakSelf.leftV.hidden = YES;
        weakSelf.rightV.hidden = YES;
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int x = scrollView.contentOffset.x / (self.bgChangeVFrame.size.width) ;
    
    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[x]]];
    
    self.page.currentPage = x;
     //获取当前展示的banner图片和前、后图片
    UIImageView *v = [self.bgChangeV viewWithTag:100 + x];
    UIImageView *v1 = [self.bgChangeV viewWithTag:100 + x - 1];
    UIImageView *v2 = [self.bgChangeV viewWithTag:100 + x + 1];
    
    //判断当前图片的前一张和后一张图片是否存在，不存在就取就近的周围2张
    if (x == 0) {
        
        self.leftV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[_dataArray.count - 1]]];
        
    }else{
        
        self.leftV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[x-1]]];
    }
    
    if ( x == _dataArray.count - 1) {
        
        self.rightV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[0]]];
        
    }else{
        
        self.rightV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[x+1]]];
    }
    //左右小图的轻微动画，这两张小图并非实际真实图片
    [UIView animateWithDuration:0.2 animations:^{
        
        __weak __typeof__(self) weakSelf = self;
        weakSelf.leftV.transform = CGAffineTransformMakeScale(0.6, 0.6);
        weakSelf.rightV.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.leftV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            weakSelf.rightV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        }];
    }];
    
    //实际滚动图片的前一张和后一张后图片
    [UIView animateWithDuration:0.3 animations:^{
        
        v.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            v1.transform = CGAffineTransformMakeScale(0.8, 0.8);
            v2.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
        }];
    }];
    self.count = x;
    
    //滚动到哪个banner，传出对应的imageview
    if ([_delegate respondsToSelector:@selector(autoScrollToWhichBanner:)]) {
        [_delegate autoScrollToWhichBanner:v];
    }
}
//人为滚动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [UIView animateWithDuration:0.2 animations:^{
        __weak __typeof__(self) weakSelf = self;
        weakSelf.leftV.hidden = NO;
        weakSelf.rightV.hidden = NO;
    }];
    
    int x = scrollView.contentOffset.x / (self.bgChangeVFrame.size.width) ;
    
    [_mainSV setContentOffset: CGPointMake((self.bgChangeVFrame.size.width) * x, 0)];
    
    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[x]]];
    
    self.page.currentPage = x;
    
    UIImageView *v = [self.bgChangeV viewWithTag:100 + x];
    UIImageView *v1 = [self.bgChangeV viewWithTag:100 + x - 1];
    UIImageView *v2 = [self.bgChangeV viewWithTag:100 + x + 1];
    
    //判断当前图片的前一张和后一张图片是否存在，不存在就取就近的周围2张
    if (x == 0) {
        
        self.leftV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[_dataArray.count - 1]]];
        
    }else{
        
        self.leftV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[x-1]]];
    }
    
    if ( x == _dataArray.count - 1) {
        
        self.rightV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[0]]];
        
    }else{
        
        self.rightV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[x+1]]];
    }
    
    //左右小图的轻微动画，这两张小图并非实际真实图片
    [UIView animateWithDuration:0.2 animations:^{
        
        __weak __typeof__(self) weakSelf = self;
        weakSelf.leftV.transform = CGAffineTransformMakeScale(0.8, 0.8);
        weakSelf.rightV.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.leftV.transform = CGAffineTransformMakeScale(1, 1);
            weakSelf.rightV.transform = CGAffineTransformMakeScale(1, 1);
            
        }];
    }];
    //实际滚动图片的前一张和后一张后图片
    [UIView animateWithDuration:0.3 animations:^{
        
        v.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            v1.transform = CGAffineTransformMakeScale(0.8, 0.8);
            v2.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
        }];
    }];
    self.count = x;
    
}

-(UIImageView *)bgChangeV{
    if (!_bgChangeV) {
        
        _bgChangeV = [[UIImageView alloc] initWithFrame:self.bgChangeVFrame];
        _bgChangeV.userInteractionEnabled = YES;
    }
    return _bgChangeV;
}
-(UIScrollView *)mainSV{
    
    if (!_mainSV) {
        
        _mainSV = [[UIScrollView alloc] initWithFrame:self.bgChangeVFrame];
        _mainSV.contentSize = CGSizeMake(_dataArray.count * self.bgChangeVFrame.size.width, self.bgChangeVFrame.size.height);
        _mainSV.contentOffset = CGPointMake(0, 0);
        _mainSV.pagingEnabled = YES;
        _mainSV.delegate = self;
        //_mainSV.scrollEnabled = NO;
    }
    return _mainSV;
}
-(UIPageControl *)page{
    if (!_page) {
        
        _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        //page.backgroundColor = [UIColor orangeColor];
        _page.pageIndicatorTintColor = [UIColor whiteColor];
        _page.currentPageIndicatorTintColor = [UIColor blackColor];
        _page.numberOfPages = _dataArray.count;
        _page.center = CGPointMake(self.bgChangeVFrame.size.width/2, self.bgChangeVFrame.size.height * 0.5 * (1 + 0.85));
    }
    return _page;
}
-(UIImageView *)leftV{
    if (!_leftV) {
        
        _leftV = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bgChangeVFrame.size.height * 0.33, self.bgChangeVFrame.size.width * 0.4, self.bgChangeVFrame.size.height * 0.5)];
        _leftV.image = [UIImage imageNamed:_dataArray[_dataArray.count - 1]];
        //_leftV.backgroundColor = [UIColor redColor];
        _leftV.clipsToBounds = YES ;
        _leftV.layer.cornerRadius = 10;
    }
    return _leftV;
}
-(UIImageView *)rightV{
    if (!_rightV) {
        
        _rightV = [[UIImageView alloc] initWithFrame:CGRectMake(self.bgChangeVFrame.size.width - self.bgChangeVFrame.size.width * 0.4 , self.bgChangeVFrame.size.height * 0.33, self.bgChangeVFrame.size.width * 0.4, self.bgChangeVFrame.size.height * 0.5)];
        _rightV.image = [UIImage imageNamed:_dataArray[2]];;
        //_rightV.backgroundColor = [UIColor blueColor];
        _rightV.clipsToBounds = YES ;
        _rightV.layer.cornerRadius = 10;
        
    }
    return _rightV;
}
-(NSArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
    }
    return _dataArray;
}
-(NSArray *)bgChangeArray{
    
    if (!_bgChangeArray) {
        _bgChangeArray = [[NSArray alloc] init];
    }
    return _bgChangeArray;
}

@end
