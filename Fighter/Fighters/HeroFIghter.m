//
//  HeroFIghter.m
//  Fighter
//
//  Created by ShiWen on 2017/10/24.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "HeroFIghter.h"
#import "HeroMissiles.h"

@implementation HeroFIghter{
//    烟雾粒子系统
    SKEmitterNode *_somkeEmitter;
//    火焰粒子系统
    SKEmitterNode *_fireEmitter;
}

-(instancetype)init{
    if (self = [super initWithImageNamed:@"spitfire.png"]) {
        self.name = @"Hero Fighter";
        self.physicsBody.categoryBitMask = heroFighterCategory;
        self.physicsBody.collisionBitMask = enemyFighterCategory | enemyMissleCategory | heroBoundingBoxCategory;
        self.physicsBody.contactTestBitMask = enemyFighterCategory | enemyMissleCategory |heroBoundingBoxCategory;
        self.physicsBody.mass = 50;
        self.physicsBody.allowsRotation = NO;
//        self.size = CGSizeMake(60, 60);
//        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.usesPreciseCollisionDetection = YES;
//        [self addChild:fighterSprite];
        
        
        _somkeEmitter = [SKEmitterNode emitterNamed:@"DamageSmoke"];
        _somkeEmitter.position = CGPointMake(0, 30);
        [_somkeEmitter setParticleAlpha:0.0];
        _somkeEmitter.particleColor = [SKColor whiteColor];
        [self addChild:_somkeEmitter];
        
        _fireEmitter = [SKEmitterNode emitterNamed:@"Fire"];
        _fireEmitter.position = CGPointMake(0, 15);
        _fireEmitter.particleAlpha = 0.00;
        [self addChild:_fireEmitter];
//        self.health = 1.0;
        
        
        
    }
    return self;
}
-(double)missleFireRotate{
    return 0.3;
}

-(void)fileMissle{
    
}

-(void)updateEffectFromHealth{
//    _somkeEmitter.particleAlpha = 1- self.health;
//    _somkeEmitter.particleColor = [SKColor colorWithWhite:1-self.health alpha:1];
//    if (self.health < 0.3) {
//        _fireEmitter.particleAlpha = 1;
//    }
}



















@end
