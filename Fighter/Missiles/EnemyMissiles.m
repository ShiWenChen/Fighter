//
//  EnemyMissiles.m
//  Fighter
//
//  Created by ShiWen on 2017/10/24.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "EnemyMissiles.h"

@implementation EnemyMissiles

-(instancetype)init{
    if (self = [super initWithImageNamed:@"enemiesBullet.png"]) {
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsBody.friction = 0;
        self.physicsBody.usesPreciseCollisionDetection = YES;

        self.physicsBody.categoryBitMask = enemyMissleCategory;
        self.physicsBody.collisionBitMask = heroFighterCategory | heroBoundingBoxCategory;
        self.physicsBody.contactTestBitMask = heroMissileCategory |heroBoundingBoxCategory;
    }
    return self;
}

@end
