//
//  SKEmitterNode+MyUtilities.m
//  Fighter
//
//  Created by ShiWen on 2017/10/23.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "SKEmitterNode+MyUtilities.h"

@implementation SKEmitterNode (MyUtilities)

+(SKEmitterNode *)emitterNamed:(NSString *)name{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle]pathForResource:name ofType:@"sks"]];
}

@end
