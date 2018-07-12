//
//  ContentController.m
//  MyScreenShortDemo
//
//  Created by 蔡成汉 on 2018/7/12.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "ContentController.h"

@interface ContentController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"结果展示";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    CGRect imageRect = self.view.bounds;
    if (self.image) {
        imageRect = CGRectMake(0, 0, MAX(self.scrollView.frame.size.width, self.image.size.width), MAX(self.scrollView.frame.size.height, self.image.size.height));
    }
    self.imageView.frame = imageRect;
    self.scrollView.contentSize = imageRect.size;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
}

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
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
