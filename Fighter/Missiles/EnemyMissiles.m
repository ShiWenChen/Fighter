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
    if (self = [super init]) {
        self.physicsBody.categoryBitMask = enemyMissleCategory;
        self.physicsBody.collisionBitMask = heroFighterCategory | heroBoundingBoxCategory;
        self.physicsBody.contactTestBitMask = heroMissileCategory |heroBoundingBoxCategory;
    }
    return self;
}

@end
