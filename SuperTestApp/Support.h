//
//  Support.h
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Support : NSObject

+(void)showAlert:(NSString *)title message:(NSString *)_message;

+(NSString *)getLocalizedString:(NSString *)key;

+(NSString *)writeImageToFile:(UIImage *)image;

+(NSString *)getImagesDirectoryPath;

+(NSArray *)getAllImages;

+(UIImage *)getImageWithName:(NSString *)name;

@end
