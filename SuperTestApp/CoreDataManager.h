//
//  CoreDataManager.h
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shirts.h"
#import "Trousers.h"
#import "BookMarks.h"

extern const BOOL SAVED;
extern const BOOL FAILED;

@interface CoreDataManager : NSObject

+(BOOL)insertBookMarksIntoDbWithShirtName:(NSString *)shirtName
                              trouserName:(NSString *)trouserName;

+(BOOL)insertShirtDetailIntoDB:(NSString *)imageName;

+(BOOL)insertTrouserDetailIntoDB:(NSString *)imageName;

+(NSArray *)getAllBookMarksFromDB;

+(NSArray *)getRandomStyleImageNames;

@end
