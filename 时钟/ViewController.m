//
//  ViewController.m
//  时钟
//
//  Created by Macbook on 2017/5/21.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) CALayer *secL;
@property (nonatomic, weak) CALayer *minL;
@property (nonatomic, weak) CALayer *hourL;





@end

@implementation ViewController

static const int perSecA = 6;
static const int perMinA = 6;
static const int perHourA = 30;
static const float perMinHour = 0.5;
#define angle2Rad(angle) ((angle) / 180.0 * M_PI)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setHour];
    [self setMin];
    [self setSec];
    
    // Do any additional setup after loading the view, typically from a nib.
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [self timeChange];
    //NSLog(@"This is a clock!");
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 400, 280, 30)];
    label.text = @"Hellol, World!";
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:23];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.shadowColor = [UIColor greenColor];
    label.shadowOffset = CGSizeMake(10, 10);
    [self.view addSubview:label];
}

- (void)setSec {
    CALayer *secL = [CALayer layer];
    secL.bounds = CGRectMake(0, 0, 1, 80);
    secL.backgroundColor = [UIColor redColor].CGColor;
    secL.anchorPoint = CGPointMake(0.5, 1);
    secL.position = CGPointMake(self.imageView.bounds.size.width*0.5, self.imageView.bounds.size.height*0.5);
    [self.imageView.layer addSublayer:secL];
    _secL = secL;
    
}

- (void)setMin {
    CALayer *minL = [CALayer layer];
    minL.bounds = CGRectMake(0, 0, 3, 70);
    minL.backgroundColor = [UIColor blueColor].CGColor;
    minL.anchorPoint = CGPointMake(0.5, 1);
    minL.cornerRadius = 1.5;
    minL.position = CGPointMake(self.imageView.bounds.size.width*0.5, self.imageView.bounds.size.height*0.5);
    [self.imageView.layer addSublayer:minL];
    _minL = minL;
}

- (void)setHour {
    CALayer *hourL = [CALayer layer];
    hourL.bounds = CGRectMake(0, 0, 3, 50);
    hourL.backgroundColor = [UIColor blackColor].CGColor;
    hourL.anchorPoint = CGPointMake(0.5, 1);
    hourL.cornerRadius = 1.5;
    hourL.position = CGPointMake(self.imageView.bounds.size.width*0.5, self.imageView.bounds.size.height*0.5);
    [self.imageView.layer addSublayer:hourL];
    _hourL = hourL;
}

- (void)timeChange{
    
    //获取当前多少秒
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    //comgpoents:日历的组件,年，月，日，时，分，秒
    NSDateComponents *cmp = [cal components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    //获取当前多少秒
    NSInteger curSec = cmp.second + 1;
    
    //秒针开始旋转
    //计算秒针当前选择的角度。
    //angle = 当前多少秒 * 每一秒旋转多少度
    CGFloat secA = curSec * perSecA;
    
    self.secL.transform = CATransform3DMakeRotation(angle2Rad(secA), 0, 0, 1);
    
    NSInteger curMin = cmp.minute;
    CGFloat minA = curMin * perMinA;
    self.minL.transform = CATransform3DMakeRotation(angle2Rad(minA), 0, 0, 1);
    
    NSInteger curHour = cmp.hour;
    CGFloat hourA = curHour * perHourA + curMin * perMinHour;
    self.hourL.transform = CATransform3DMakeRotation(angle2Rad(hourA), 0, 0, 1);
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    self.secL.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
}

- (UIImageView *)imageView {
    if(_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(100, 100, 200, 200);
        imageView.image = [UIImage imageNamed:@"钟表"];
        [self.view addSubview:imageView];
        _imageView = imageView;
        
    }
    return _imageView;
}

@end
