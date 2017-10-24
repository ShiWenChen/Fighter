//
//  Fighter.m
//  Fighter
//
//  Created by ShiWen on 2017/10/23.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "Fighter.h"

@implementation Fighter

-(id)initWithImageNamed:(NSString *)name{
    if (self = [super init]) {
        SKSpriteNode *fighterSprite = [SKSpriteNode spriteNodeWithImageNamed:name];
        fighterSprite.size = CGSizeMake(60, 60);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:fighterSprite.size];
        self.physicsBody.usesPreciseCollisionDetection = YES;
    }
    return self;
}

@end
