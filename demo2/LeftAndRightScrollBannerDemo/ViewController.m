//
//  ViewController.m
//  LeftAndRightScrollBannerDemo
//
//  Created by Karl on 2018/6/21.
//  Copyright © 2018 Derek. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainSV;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIImageView * bgChangeV;
@property (nonatomic,strong) NSArray *bgChangeArray;
@property (nonatomic,strong) UIPageControl *page;
@property (nonatomic,strong) UIImageView * leftV;
@property (nonatomic,strong) UIImageView * rightV;


@end

@implementation ViewController
{
    int i ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.bgChangeV];
    
    _dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    _bgChangeArray = @[@"p1",@"p2",@"p3",@"p4",@"p5",@"p6"];
    
    UIImageView * leftV = [[UIImageView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width * 0.20, [UIScreen mainScreen].bounds.size.width * 0.4, [UIScreen mainScreen].bounds.size.width * 0.25)];
    leftV.backgroundColor = [UIColor redColor];
    leftV.clipsToBounds = YES ;
    leftV.layer.cornerRadius = 10;
    
    UIImageView * rightV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - [UIScreen mainScreen].bounds.size.width * 0.4 , [UIScreen mainScreen].bounds.size.width * 0.20, [UIScreen mainScreen].bounds.size.width * 0.4, [UIScreen mainScreen].bounds.size.width * 0.25)];
    rightV.backgroundColor = [UIColor blueColor];
    leftV.clipsToBounds = YES ;
    leftV.layer.cornerRadius = 10;
    
    [self.bgChangeV addSubview:leftV];
    [self.bgChangeV addSubview:rightV];
    self.leftV = leftV;
    self.rightV = rightV;
    
    UIScrollView *mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.65 )];
    mainSV.contentSize = CGSizeMake(_dataArray.count * [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.65);
    mainSV.contentOffset = CGPointMake([UIScreen mainScreen].bounds.size.width, 0);
    mainSV.pagingEnabled = YES;
    mainSV.delegate = self;
    //mainSV.scrollEnabled = NO;
    [self.bgChangeV addSubview:mainSV];
    _mainSV = mainSV;
    
    
    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    //page.backgroundColor = [UIColor orangeColor];
    page.pageIndicatorTintColor = [UIColor whiteColor];
    page.currentPageIndicatorTintColor = [UIColor blackColor];
    page.numberOfPages = _dataArray.count;
    page.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.width * 0.65 * 0.5 * (1 + 0.85));
    [_bgChangeV addSubview:page];
    [self.view bringSubviewToFront:page];
    self.page = page;
    
    for (int i = 0; i < _dataArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width  +  65, [UIScreen mainScreen].bounds.size.width * 0.10, [UIScreen mainScreen].bounds.size.width - 130 ,  [UIScreen mainScreen].bounds.size.width * 0.30)];
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
    i = 0;
    
}
-(void)timerSencond{
    
    
    if (i == 0) {
        [_mainSV setContentOffset: CGPointMake(([UIScreen mainScreen].bounds.size.width) * i, 0)];
    }else{
        __weak __typeof__(self) weakSelf = self;
        [UIView animateWithDuration:0.4 animations:^{
            [weakSelf.mainSV setContentOffset: CGPointMake(([UIScreen mainScreen].bounds.size.width) * self->i, 0)];
        }];
    }
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        __weak __typeof__(self) weakSelf = self;
        weakSelf.leftV.transform = CGAffineTransformMakeScale(0.6, 0.6);
        weakSelf.rightV.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.leftV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            weakSelf.rightV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        }];
        
    }];
    
    
    self.page.currentPage = i;
    
    UIImageView *v = [self.view viewWithTag:100 + i];
    UIImageView *v1 = [self.view viewWithTag:100 + i - 1];
    UIImageView *v2 = [self.view viewWithTag:100 + i + 1];
    
    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[i]]];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        v.transform = CGAffineTransformMakeScale(1.3, 1.3);
        [UIView animateWithDuration:0.3 animations:^{
            
            v1.transform = CGAffineTransformMakeScale(1, 1);
            v2.transform = CGAffineTransformMakeScale(1, 1);
            
        }];
    }];
    
    i++;
    
    if (i >= _dataArray.count) {
        i = 0;
    }
    
    
}
-(void)tapImageView:(UITapGestureRecognizer *)tap {
    
    NSLog(@"%ld",tap.view.tag);
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int x = scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;
    

    NSLog(@"%d",x);
    
    self.page.currentPage = x;
    
    UIImageView *v = [self.view viewWithTag:100 + x];
    UIImageView *v1 = [self.view viewWithTag:100 + x - 1];
    UIImageView *v2 = [self.view viewWithTag:100 + x + 1];
    
    
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
    

    [UIView animateWithDuration:0.2 animations:^{
        
        __weak __typeof__(self) weakSelf = self;
        weakSelf.leftV.transform = CGAffineTransformMakeScale(0.8, 0.8);
        weakSelf.rightV.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.leftV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            weakSelf.rightV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        }];
        
    }];
    
    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[x]]];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        v.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            v1.transform = CGAffineTransformMakeScale(1, 1);
            v2.transform = CGAffineTransformMakeScale(1, 1);
            
        }];
    }];
    i = x;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int x = scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;
    
    [_mainSV setContentOffset: CGPointMake(([UIScreen mainScreen].bounds.size.width) * x, 0)];
    
    NSLog(@"%d",x);
    
    self.page.currentPage = x;
    
    UIImageView *v = [self.view viewWithTag:100 + x];
    UIImageView *v1 = [self.view viewWithTag:100 + x - 1];
    UIImageView *v2 = [self.view viewWithTag:100 + x + 1];
    
    
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
    
    
    [UIView animateWithDuration:0.2 animations:^{
        
        __weak __typeof__(self) weakSelf = self;
        weakSelf.leftV.transform = CGAffineTransformMakeScale(0.6, 0.6);
        weakSelf.rightV.transform = CGAffineTransformMakeScale(0.6, 0.6);
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.leftV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            weakSelf.rightV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        }];
        
    }];
    
    
    self.bgChangeV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_bgChangeArray[x]]];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        v.transform = CGAffineTransformMakeScale(1.3, 1.3);
        
        [UIView animateWithDuration:0.3 animations:^{
            
            v1.transform = CGAffineTransformMakeScale(1, 1);
            v2.transform = CGAffineTransformMakeScale(1, 1);
            
        }];
    }];
    i = x;
}
-(UIImageView *)bgChangeV{
    if (!_bgChangeV) {
        
        _bgChangeV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.65)];
        _bgChangeV.userInteractionEnabled = YES;
    }
    return _bgChangeV;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
