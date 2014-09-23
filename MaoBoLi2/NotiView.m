//
//  NotiView.m
//  MaoBoLi
//
//  Created by Mac_PC on 14-8-29.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import "NotiView.h"
#import "NotificationCell.h"

#define DEFAULT_BLUR_RADIUS 14
//  改变背景颜色和透明度
#define DEFAULT_BLUR_TINT_COLOR [UIColor colorWithWhite:1.0 alpha:.5]
#define DEFAULT_BLUR_DELTA_FACTOR 1.4


@implementation NotiView{
    NSMutableArray *_data;
    NSMutableArray *_detail;
    
    NSString *replies ;
    NSString *endorse;
    NSString *friends;
    NSString *message;
    float end_Y;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    replies = @"replies";
    endorse = @"endorse";
    friends = @"friends request";
    message = @"message";
    end_Y = [UIScreen mainScreen].bounds.size.height - 40;
    
    
 //   UIImage *blurBackgroundImage = [[UIImage imageNamed:@"heeh.jpg"] applyBlurWithRadius:DEFAULT_BLUR_RADIUS tintColor:DEFAULT_BLUR_TINT_COLOR saturationDeltaFactor:DEFAULT_BLUR_DELTA_FACTOR maskImage:nil];
  //  imageView = [[UIImageView alloc]initWithImage:blurBackgroundImage];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.frame = CGRectMake(0, 0,self.frame.size.width , self.frame.size.height);
    [self.imageView setClipsToBounds:YES];
    [self.imageView setContentMode:UIViewContentModeTopLeft];
    [self addSubview:self.imageView];
    [self addSubview:self.tableView];
    [self addSubview:self.FootView];
    [self addSubview:self.headView];
    NSString *s1 = [NSString stringWithFormat:@"%d more replies & %d more endorse",5,5];
    NSString *s2 = [NSString stringWithFormat:@"%d new friends request to resolve",5];
    NSString *s3 = [NSString stringWithFormat:@"%d new message",5];
    _data = [[NSMutableArray alloc]initWithObjects:s1,s2,s3, nil];
    _detail = [[NSMutableArray alloc]initWithObjects:@"    We just launch the linkr,a professional SNS...",@"",@"", nil];
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    [self addGestureRecognizer:pan];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


#pragma -mark tableview delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
   // return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationCell *cell = (NotificationCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (NotificationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier;
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        NSArray *nibArray = [[NSBundle mainBundle]loadNibNamed:@"NotificationCell" owner:nil options:nil];
        cell = [nibArray objectAtIndex:0];
    }
    cell.label.text = [_data objectAtIndex:indexPath.row];
    cell.labelDetail.text = [_detail objectAtIndex:indexPath.row];
    
    UIImage *image = [UIImage imageNamed:@"friends_add.png"];
    [cell.button setImage:image forState:UIControlStateNormal];
    [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    NSMutableAttributedString *attribute = [cell.label.attributedText mutableCopy];
    [attribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, ((NSString *)[_data objectAtIndex:indexPath.row]).length)];
      NSRange range = [((NSString *)[_data objectAtIndex:indexPath.row]) rangeOfString:replies];
     [attribute addAttribute:NSForegroundColorAttributeName value:FONTCOLOR_BLUE range:NSMakeRange(range.location, range.length)];
    range = [((NSString *)[_data objectAtIndex:indexPath.row]) rangeOfString:endorse];
     [attribute addAttribute:NSForegroundColorAttributeName value:FONTCOLOR_BLUE range:NSMakeRange(range.location, range.length)];
    range = [((NSString *)[_data objectAtIndex:indexPath.row]) rangeOfString:friends];
     [attribute addAttribute:NSForegroundColorAttributeName value:FONTCOLOR_BLUE range:NSMakeRange(range.location, range.length)];
    range = [((NSString *)[_data objectAtIndex:indexPath.row]) rangeOfString:message];
     [attribute addAttribute:NSForegroundColorAttributeName value:FONTCOLOR_BLUE range:NSMakeRange(range.location, range.length)];
    cell.label.attributedText = attribute;
    [cell setNeedsUpdateConstraints];
    [cell.contentView setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
    
}
- (void)buttonClick:(id)sender{
    UIButton *button = (UIButton *)sender;
    NSInteger row = button.tag;
    [_data removeObjectAtIndex:row];
    [_detail removeObjectAtIndex:row];
    [self.tableView reloadData];
}

- (IBAction)ClickButtton:(id)sender {
    [UIView animateWithDuration:0.3 delay:0.0 options:0
                     animations:^{
                         [self setFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
                         
                         
                     } completion:^(BOOL finished){
                         
                     }];
    
}

- (void)panHandle:(UIPanGestureRecognizer *)gesture
{
    static float startPoint_Y; //记录开始滑动时的 触控位置Y坐标
    float endPoint_Y;   //记录结束滑动时的 触控位置Y坐标
    static float viewPoint_Y;  //记录开始滑动时的 视图位置Y坐标
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            // end_Y = 0;
            startPoint_Y = [gesture locationInView:self].y;
            viewPoint_Y  = self.frame.origin.y;
            
            NSLog(@"\n\n========开始滑动");
            NSLog(@"起始点的Y坐标为：%f",startPoint_Y);
            NSLog(@"视图的起始坐标为：%f",viewPoint_Y);
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
          //  endPoint_Y = end_Y;
            
          //  end_Y   = [gesture locationInView:self].y;
            endPoint_Y = [gesture locationInView:self].y;
          //  if (end_Y < endPoint_Y) {
                float gPoint = viewPoint_Y + (endPoint_Y - startPoint_Y);
           
                
                float ver =[[[UIDevice currentDevice] systemVersion] floatValue];
                if(ver>=7.0){
                    if (gPoint >0) {
                         _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                         self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height );
                    }
                    else{
                        _imageView.frame = CGRectMake(0, -gPoint, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + gPoint);
                    self.frame = CGRectMake(0, gPoint, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height );
                        
                    }
                }
                else {
                    if (gPoint > 0) {
                         _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -20);
                        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-20 );
                    }
                    else{
                         _imageView.frame = CGRectMake(0, -gPoint, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + gPoint-20);
                    self.frame = CGRectMake(0, gPoint, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-20 );
                    }
                }
                [gesture setTranslation:CGPointZero inView:self];
                
                NSLog(@"\n\n=========持续滑动");
                NSLog(@"视图的坐标调整后为：%f",gPoint);
                NSLog(@"滑动的的距离为： %f",endPoint_Y - startPoint_Y);
                
                NSLog(@"end %f  start %f view %f", endPoint_Y, startPoint_Y,viewPoint_Y );
                viewPoint_Y = gPoint;
            }
           
      //  }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"\n\n=========结束滑动");
            
            CGRect rect = self.frame;
            
            NSLog(@"view Y === %f",self.frame.origin.y);
            if (rect.origin.y+SCREEN_SIZE.height <= SCREEN_SIZE.height/10*9) {
                rect.origin.y = -SCREEN_SIZE.height;
                [UIView animateWithDuration:0.3 delay:0.0 options:0
                                 animations:^{
                                      _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                                     [self setFrame:CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height)];
                                     
                                     
                                 } completion:^(BOOL finished){
                                     
                                 }];
             /*
                [UIView animateWithDuration:.0f animations:^{
                    [self.view setFrame:rect];
                } completion:^(BOOL finished) {
                    CATransition  *transition = [ CATransition   animation ];
                    transition. duration  =  .5f ;
                    transition. timingFunction  = [ CAMediaTimingFunction   functionWithName : kCAMediaTimingFunctionLinear ];
                    transition.type  =  kCATransitionPush ;
                    transition.subtype  =  kCATransitionFromTop;
                    transition.delegate  =  self ;
                    [ self.layer   addAnimation :transition  forKey : nil ];
              
                    //   [self dismissViewControllerAnimated:YES completion:nil];
                    //视图位置自动校正后，如果其位于 上边沿 屏幕外 置其于下
                    if (finished && rect.origin.y == - SCREEN_SIZE.height)
                    {
                        self.view.frame = CGRectMake(0, SCREEN_SIZE.height, SCREEN_SIZE.width, SCREEN_SIZE.height);
                    }
                }];
                 */
                
            }
            else{
                float ver =[[[UIDevice currentDevice] systemVersion] floatValue];
                if(ver>=7.0){
                     _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height );
                self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height );
                }
                else {
                     _imageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -20);
                      self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-20 );
                }
                // gPoint;
                
            }
            /*   if (rect.origin.y >= 0) //处理 视图 在屏幕上边沿滑动时的情况
             {
             if (rect.origin.y >= SCREEN_SIZE.height/2)
             {
             rect.origin.y = SCREEN_SIZE.height;
             }
             else
             {
             rect.origin.y = 0;
             }
             }
             else                    //处理 视图 在屏幕下边沿滑动时的情况
             {
             if(rect.origin.y >= -SCREEN_SIZE.height/2 && rect.origin.y < 0)
             {
             rect.origin.y = 0;
             }
             else if (rect.origin.y < -SCREEN_SIZE.height/2 && rect.origin.y < 0)
             {
             rect.origin.y = - SCREEN_SIZE.height;
             }
             }
             */
            //简单的过度动画
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"====oh NO===滑动被取消了");
            
            /*********************************************
             * 不排除有，pan事件被中断的可能，处理同stateEnded *
             *********************************************/
            
        }
            break;
        default:
            break;
    }
    
}


@end
