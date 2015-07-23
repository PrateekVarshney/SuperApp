//
//  Shirts.h
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Shirts : NSManagedObject

@property (nonatomic, retain) NSNumber *uid;
@property (nonatomic, retain) NSString *imageName;

@end
