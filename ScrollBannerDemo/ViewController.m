//
//  ViewController.m
//  ScrollBannerDemo
//
//  Created by Derek on 2018/6/20.
//  Copyright © 2018 Derek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainSV;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIImageView * bgChangeV;
@property (nonatomic,strong) NSArray *bgChangeArray;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) int count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.bgChangeV];
    //滚动图片
    _dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"1",@"2",@"3",@"4",@"5",@"6"];
    //随滚动图片滚动的背景图片
    _bgChangeArray = @[@"p1",@"p2",@"p3",@"p4",@"p5",@"p6",@"p1",@"p2",@"p3",@"p4",@"p5",@"p6"];
    
    
    [self.bgChangeV addSubview:self.pageControl];
    [self.bgChangeV addSubview:self.mainSV];
    [self.view bringSubviewToFront:self.pageControl];
    
    for (int i = 0; i < _dataArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width  +  60, [UIScreen mainScreen].bounds.size.width * 0.10, [UIScreen mainScreen].bounds.size.width - 120 ,  [UIScreen mainScreen].bounds.size.width * 0.30)];
        imageView.userInteractionEnabled = YES;
        imageView.clipsToBounds = YES ;
        imageView.layer.cornerRadius = 10;
        imageView.image = [UIImage imageNamed:_dataArray[i]];
        imageView.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        
        [self.mainSV addSubview:imageView];
        
        if (i == 0) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                
            }];
        }
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(timerSencond) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    self.timer = timer;
    self.count = 0;
    
}
-(void)timerSencond{
   
    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[_count]]];
    
    if (_count == 0) {
        [_mainSV setContentOffset: CGPointMake(([UIScreen mainScreen].bounds.size.width) * _count, 0)];
    }else{
        __weak __typeof__(self) weakSelf = self;
        [UIView animateWithDuration:0.4 animations:^{
            [weakSelf.mainSV setContentOffset: CGPointMake(([UIScreen mainScreen].bounds.size.width) * weakSelf.count, 0)];
        }];
    }
    
    self.pageControl.currentPage = _count;
    
    UIImageView *v = [self.view viewWithTag:100 + _count];
    UIImageView *v1 = [self.view viewWithTag:100 + _count - 1];
    UIImageView *v2 = [self.view viewWithTag:100 + _count + 1];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        v.transform = CGAffineTransformMakeScale(1.3, 1.3);
        [UIView animateWithDuration:0.3 animations:^{
            
            v1.transform = CGAffineTransformMakeScale(1, 1);
            v2.transform = CGAffineTransformMakeScale(1, 1);
            
        }];
    }];
    
    _count++;
    
    if (_count >= _dataArray.count) {
        _count = 0;
    }
    
    
}
-(void)tapImageView:(UITapGestureRecognizer *)tap {
    
    NSLog(@"%ld",tap.view.tag);
    
}
//已经滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int x = scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;

    NSLog(@"%d",x);
    
    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[x]]];

    self.pageControl.currentPage = x;

    UIImageView *v = [self.view viewWithTag:100 + x];
    UIImageView *v1 = [self.view viewWithTag:100 + x - 1];
    UIImageView *v2 = [self.view viewWithTag:100 + x + 1];

    [UIView animateWithDuration:0.3 animations:^{

        v.transform = CGAffineTransformMakeScale(1.3, 1.3);

        [UIView animateWithDuration:0.3 animations:^{

            v1.transform = CGAffineTransformMakeScale(1, 1);
            v2.transform = CGAffineTransformMakeScale(1, 1);

        }];
    }];
    _count = x;
}
//人为开始拽动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    int x = scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;

    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[x]]];
    
    self.pageControl.currentPage = x;

    UIImageView *v = [self.view viewWithTag:100 + x];
    UIImageView *v1 = [self.view viewWithTag:100 + x - 1];
    UIImageView *v2 = [self.view viewWithTag:100 + x + 1];
    
    [UIView animateWithDuration:0.3 animations:^{

        v.transform = CGAffineTransformMakeScale(1, 1);

        [UIView animateWithDuration:0.3 animations:^{

            v1.transform = CGAffineTransformMakeScale(1.3, 1.3);
            v2.transform = CGAffineTransformMakeScale(1.3, 1.3);

        }];
    }];
    _count = x;
}
//人为手滑动停止后
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    int x = scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;

    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[x]]];

    self.pageControl.currentPage = x;

    UIImageView *v = [self.view viewWithTag:100 + x];
    UIImageView *v1 = [self.view viewWithTag:100 + x - 1];
    UIImageView *v2 = [self.view viewWithTag:100 + x + 1];

    [UIView animateWithDuration:0.3 animations:^{

        v.transform = CGAffineTransformMakeScale(1, 1);

        [UIView animateWithDuration:0.3 animations:^{
            
            v1.transform = CGAffineTransformMakeScale(1, 1);
            v2.transform = CGAffineTransformMakeScale(1, 1);

        }];
    }];
    _count = x;
    
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
}
-(UIImageView *)bgChangeV{
    if (!_bgChangeV) {
        
        _bgChangeV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.65)];
        _bgChangeV.userInteractionEnabled = YES;
    }
    return _bgChangeV;
}
-(UIScrollView *)mainSV{
    if (!_mainSV) {
        
        _mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.65 )];
        _mainSV.contentSize = CGSizeMake(_dataArray.count * [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.65);
        _mainSV.contentOffset = CGPointMake(0, 0);
        _mainSV.pagingEnabled = YES;
        _mainSV.delegate = self;
    }
    return _mainSV;
}
-(UIPageControl *)pageControl{
    
    if (!_pageControl) {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    //page.backgroundColor = [UIColor orangeColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    _pageControl.numberOfPages = _dataArray.count;
    _pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width * 0.65 * 0.5 * (1 + 0.85));
    }
    return _pageControl;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
