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

@end

@implementation ViewController
{
    int i ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"1",@"2",@"3",@"4",@"5",@"6"];
    
    UIScrollView *mainSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.65 )];
    mainSV.contentSize = CGSizeMake(_dataArray.count * [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.65);
    mainSV.contentOffset = CGPointMake(0, 0);
    mainSV.pagingEnabled = YES;
    mainSV.delegate = self;
    [self.view addSubview:mainSV];
    _mainSV = mainSV;
    
  
    for (int i = 0; i < _dataArray.count; i++) {
        
    
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * [UIScreen mainScreen].bounds.size.width  +  60, [UIScreen mainScreen].bounds.size.width * 0.25 / 2, [UIScreen mainScreen].bounds.size.width - 120 ,  [UIScreen mainScreen].bounds.size.width * 0.35)];
        imageView.userInteractionEnabled = YES;
            imageView.image = [UIImage imageNamed:_dataArray[i]];
            imageView.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        
        [_mainSV addSubview:imageView];
        
        if (i == 0) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                
            }];
        }
        
        
        //NSLog(@"%d,%f",i,j);
    }
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerSencond) userInfo:nil repeats:YES];
    self.timer = timer;
    i = 0;
}
-(void)timerSencond{
   
    
    [_mainSV setContentOffset: CGPointMake(([UIScreen mainScreen].bounds.size.width) * i, 0)];
    
    UIImageView *v = [self.view viewWithTag:100 + i];
    UIImageView *v1 = [self.view viewWithTag:100 + i - 1];
    UIImageView *v2 = [self.view viewWithTag:100 + i + 1];
    
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
    
   
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    int x = scrollView.contentOffset.x / ([UIScreen mainScreen].bounds.size.width) ;

    NSLog(@"%d",x);

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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
