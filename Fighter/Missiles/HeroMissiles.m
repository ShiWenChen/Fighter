//
//  HeroMissiles.m
//  Fighter
//
//  Created by ShiWen on 2017/10/24.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "HeroMissiles.h"

@implementation HeroMissiles
-(id)init{
    if (self = [super initWithImageNamed:@"bullet.png"]) {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.friction = 0;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        
        self.physicsBody.categoryBitMask = heroMissileCategory;
        self.physicsBody.collisionBitMask = enemyFighterCategory | heroBoundingBoxCategory;
        self.physicsBody.contactTestBitMask = enemyFighterCategory | heroBoundingBoxCategory;
        self.physicsBody.mass = 100;
    }
    return self;
}

@end
