//
//  EnemesFighter.m
//  Fighter
//
//  Created by ShiWen on 2017/10/27.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "EnemesFighter.h"

@implementation EnemesFighter

-(instancetype)init{
    if (self = [super initWithImageNamed:@"enemy"]) {
        self.physicsBody.categoryBitMask = enemyFighterCategory;
        self.physicsBody.collisionBitMask = heroFighterCategory | heroMissileCategory | heroBoundingBoxCategory;
        self.physicsBody.mass = 50;
        self.physicsBody.allowsRotation = NO;
    }
    return self;
}

@end
