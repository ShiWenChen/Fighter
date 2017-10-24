//
//  GameScene.m
//  Fighter
//
//  Created by ShiWen on 2017/10/23.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        //        背景色
        SKSpriteNode *ground = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:63.0/255.0 green:130.0/255.0 blue:210.0/255.0 alpha:1.0] size:size];
        ground.position = CGPointMake((self.frame.size.width / 2), (self.frame.size.height / 2));
        [self addChild:ground];
        //        粒子效果
        SKEmitterNode *backGroud = [SKEmitterNode emitterNamed:@"CloudParticleEmitter"];
        backGroud.position = CGPointMake(size.width/2, size.height/2);
        [ground addChild:backGroud];
        
    }
    return self;
}

@end
