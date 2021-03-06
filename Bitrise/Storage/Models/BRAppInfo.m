//
//  BRAppInfo.m
//  BitBot
//
//  Created by Deszip on 08/07/2018.
//  Copyright © 2018 BitBot. All rights reserved.
//

#import "BRAppInfo.h"

@implementation BRAppInfo

- (instancetype)initWithResponse:(NSDictionary *)response {
    if (self = [super init]) {
        _rawResponse = response;
        _slug = _rawResponse[@"slug"];
        _title = _rawResponse[@"title"];
    }
    
    return self;
}

- (instancetype)initWithApp:(BRApp *)app {
    if (self = [super init]) {
        _rawResponse = nil;
        _slug = app.slug;
        _title = app.title;
    }
    
    return self;
}

@end
