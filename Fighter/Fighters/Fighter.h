//
//  Fighter.h
//  Fighter
//
//  Created by ShiWen on 2017/10/23.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Fighter : SKSpriteNode

-(id)initWithImageNamed:(NSString *)name;

/**
 生命值
 */
@property (nonatomic,assign) double health;

/**
 火力
 */
-(void)fileMissle;

/**
 导弹发射频率
 */
-(double)missleFireRotate;


@end
