//
//  EnemesFighter.m
//  Fighter
//
//  Created by ShiWen on 2017/10/27.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "EnemesFighter.h"
#import "SKEmitterNode+MyUtilities.h"

@implementation EnemesFighter

-(instancetype)init{
    if (self = [super initWithImageNamed:@"enemy"]) {
        self.name = @"Enemy Fighter";
//        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fighterSprite.size];
        self.physicsBody.usesPreciseCollisionDetection = YES;
//        [self addChild:fighterSprite];
        self.physicsBody.categoryBitMask = enemyFighterCategory;
        self.physicsBody.collisionBitMask = heroFighterCategory | heroMissileCategory;
        self.physicsBody.contactTestBitMask = heroFighterCategory | heroMissileCategory;
        self.physicsBody.mass = 0.02;
        self.physicsBody.friction = 0;
        
        
        SKEmitterNode *emitterNode = [SKEmitterNode emitterNamed:@"Explosion"];
        emitterNode.position = CGPointMake(0, 0 );
//        particleAlpha
        [emitterNode setParticleAlpha:0];
//        emitterNode .
        [self addChild:emitterNode];
    }
    return self;
}

@end
