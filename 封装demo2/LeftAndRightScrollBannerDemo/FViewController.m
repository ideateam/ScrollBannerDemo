//
//  FViewController.m
//  LeftAndRightScrollBannerDemo
//
//  Created by Karl on 2018/6/25.
//  Copyright © 2018 Derek. All rights reserved.
//

#import "FViewController.h"
#import "ScrollBannerFBC.h"

@interface FViewController ()<ScrollBannerFBCdelegate>

@end

@implementation FViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
