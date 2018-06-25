//
//  ViewController.m
//  LeftAndRightScrollBannerDemo
//
//  Created by Karl on 2018/6/21.
//  Copyright © 2018 Derek. All rights reserved.
//

#import "ViewController.h"
#import "ScrollBannerFBC.h"

@interface ViewController ()<ScrollBannerFBCdelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //初始化滚动视图
    ScrollBannerFBC *s = [[ScrollBannerFBC alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.width * 0.56 ) andBannerArray:@[@"1",@"2",@"3",@"4",@"5",@"6"] andBannerBackGroundArray:@[@"p1",@"p2",@"p3",@"p4",@"p5",@"p6"] andHideLeftRight:NO];
    s.delegate = self;
    s.backgroundColor = [UIColor redColor];
    [self.view addSubview:s];
    
}
/*
 ScrollBannerFBCdelegate
 */
-(void)imageViewIsTaped:(UITapGestureRecognizer *)tap{
    
    NSLog(@"FViewController %ld",tap.view.tag);
}
-(void)autoScrollToWhichBanner:(UIImageView *)imageView{
    
    NSLog(@"FViewController %ld",imageView.tag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
