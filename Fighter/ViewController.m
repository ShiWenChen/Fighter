//
//  ViewController.m
//  Fighter
//
//  Created by ShiWen on 2017/10/23.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"
#import "StarScene.h"
#import "GameScene.h"



@interface ViewController ()
/**
 *  开始按钮
 */
@property (nonatomic , strong)UIButton * btnStar;



/**
 logo
 */
@property (nonatomic , strong)UIImageView *logoImage;
@property (nonatomic , strong)SKView *skView;
/**
 暂停
 */
@property (nonatomic , strong)UIButton *btnPause;
/**
 停止
 */
@property (nonatomic , strong)UIButton *btnStop;
@property (nonatomic , assign)BOOL isStart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.skView = (SKView *)self.view;
    if (!self.skView.scene) {
        StarScene *starScene = [[StarScene alloc] initWithSize:self.view.frame.size];
        
        [self.skView presentScene:starScene];
    }
    [self.view addSubview:self.btnStar];
    [self.view addSubview:self.logoImage];
    [self.view addSubview:self.btnPause];
    [self.view addSubview:self.btnStop];
    

}

-(UIButton *)btnStar{
    if (!_btnStar) {
        _btnStar = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnStar setTitle:@"Start" forState:UIControlStateNormal];
        [_btnStar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnStar.showsTouchWhenHighlighted = YES;
        [_btnStar addTarget:self action:@selector(startTouch) forControlEvents:UIControlEventTouchUpInside];
        _btnStar.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _btnStar.frame = CGRectMake(0, 0, 100, 100);
        _btnStar.center = CGPointMake(WIDTH/2, HIGHT/2 + 200);
        _btnStar.layer.masksToBounds = YES;
        _btnStar.layer.cornerRadius = 50;
        _btnStar.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:80.0/255.0 blue:115.0/255.0 alpha:1];
    }
    return _btnStar;
}

-(UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        _logoImage.center = CGPointMake(WIDTH/2, HIGHT/2-200);
        _logoImage.image = [UIImage imageNamed:@"logo.png"];
    }
    return _logoImage;
}
-(void)startTouch{
    GameScene *geameScene = [[GameScene alloc] initWithSize:self.view.frame.size];
    [self.skView presentScene:geameScene transition:[SKTransition doorsOpenHorizontalWithDuration:1]];
    [UIView animateWithDuration:1 animations:^{
        self.btnStar.alpha = 0;
        self.logoImage.alpha = 0;
        self.btnPause.alpha = 1;
        self.btnStop.alpha = 1.0;
    }];
}
-(UIButton *)btnPause{
    if (!_btnPause) {
        _btnPause = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPause.alpha = 0.0;
        [_btnPause setTitleColor:[UIColor colorWithRed:220.0/255.0 green:80.0/255.0 blue:115.0/255.0 alpha:1] forState:UIControlStateNormal];
        _btnPause.showsTouchWhenHighlighted = YES;
        [_btnPause setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        [_btnPause addTarget:self action:@selector(pauseTouch) forControlEvents:UIControlEventTouchUpInside];
        _btnPause.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _btnPause.frame = CGRectMake(WIDTH - 40, 20, 30, 30);
    }
    return _btnPause;
}
-(UIButton *)btnStop{
    if (!_btnStop) {
        _btnStop = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnStop.alpha = 0.0;
        [_btnStop setBackgroundImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
        _btnStop.showsTouchWhenHighlighted = YES;
        [_btnStop addTarget:self action:@selector(stopTouch) forControlEvents:UIControlEventTouchUpInside];
        _btnStop.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _btnStop.frame = CGRectMake(10, 20, 30, 30);
    }
    return _btnStop;
}
-(void)pauseTouch{
    if (self.isStart) {
        self.isStart = NO;
        NSLog(@"开始");
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
    }else{
        self.isStart = YES;
        NSLog(@"暂停");
        [self.btnPause setBackgroundImage:[UIImage imageNamed:@"start.png"] forState:UIControlStateNormal];
    }
    
    
}
-(void)stopTouch{
    StarScene *starScene = [[StarScene alloc] initWithSize:self.view.frame.size];
    [self.skView presentScene:starScene transition:[SKTransition doorsCloseHorizontalWithDuration:1]];
    [UIView animateWithDuration:1 animations:^{
        
        self.btnPause.alpha = 0.0;
        self.btnStop.alpha = 0.0;
        self.btnStar.alpha = 1.0;
        self.logoImage.alpha = 1.0;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
