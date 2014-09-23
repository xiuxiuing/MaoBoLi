//
//  ViewController.m
//  MaoBoLi
//
//  Created by Mac_PC on 14-8-29.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import "ViewController.h"
#import "NotiView.h"
#define DEFAULT_BLUR_RADIUS 14
//  改变背景颜色和透明度
#define DEFAULT_BLUR_TINT_COLOR [UIColor colorWithWhite:1.0 alpha:.5]
#define DEFAULT_BLUR_DELTA_FACTOR 1.4

@interface ViewController ()
@property (nonatomic,strong) NotiView *blurView;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *imageview = [UIImageView new];
    [imageview setFrame:[self.view bounds]];
    [imageview setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [imageview setImage:[UIImage imageNamed:@"fish.jpg"]];
    [imageview setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:imageview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-10, 100, 40);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Clickme:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NotiView" owner:nil options:nil];
    self.blurView = [nib objectAtIndex:0];
    self.blurView.frame = CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    self.blurView.imageView.image = [[self imageFromView:self.view]applyBlurWithRadius:DEFAULT_BLUR_RADIUS tintColor:DEFAULT_BLUR_TINT_COLOR saturationDeltaFactor:DEFAULT_BLUR_DELTA_FACTOR maskImage:nil];
  //  self.blurView.dynamic = NO;
  //  self.blurView.blurRadius = 1;

    [self.blurView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.blurView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)Clickme:(id)sender{
    [UIView animateWithDuration:0.3 delay:0.0 options:0
                     animations:^{
                         [self.blurView setFrame:[self.view bounds]];
                         
                         
                     } completion:^(BOOL finished){
                         
                     }];
}


- (UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext: context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
