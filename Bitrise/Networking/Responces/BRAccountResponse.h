//
//  BRAccountResponse.h
//  Bitrise
//
//  Created by Deszip on 07/07/2018.
//  Copyright © 2018 Bitrise. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BRAccountResponse : NSObject

@property (copy, nonatomic, readonly) NSString *token;
@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *slug;
@property (strong, nonatomic, readonly) NSURL *avatarURL;

- (instancetype)initWithResponse:(NSDictionary *)response token:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
