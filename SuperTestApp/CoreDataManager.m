//
//  CoreDataManager.m
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import "CoreDataManager.h"
#include <stdlib.h>

const BOOL SAVED = TRUE;
const BOOL FAILED = FALSE;

@implementation CoreDataManager

// =======================================================================================================================================
// Method to get all BookMarks from DB
// =======================================================================================================================================

+(NSArray *)getAllBookMarksFromDB
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"BookMarks" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSMutableArray *bookMarksArray = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    return [bookMarksArray copy];
}

// =======================================================================================================================================
// method to get all shirts from database
// =======================================================================================================================================

+(NSArray *)getAllShirtsFromDB
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shirts" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSMutableArray *shirtsArray = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    return [shirtsArray copy];
}

// =======================================================================================================================================
// method to get all trousers from database
// =======================================================================================================================================

+(NSArray *)getAllTrousersFromDB
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Trousers" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSMutableArray *trousersArray = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    return [trousersArray copy];
}

// =======================================================================================================================================
// method to insert bookmarks into database
// =======================================================================================================================================

+(BOOL)insertBookMarksIntoDbWithShirtName:(NSString *)shirtName
                              trouserName:(NSString *)trouserName
{
    AppDelegate *appDelegateObj = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = [appDelegateObj managedObjectContext];
    NSManagedObjectContext *context = managedObjectContext;
    BookMarks *feed = [NSEntityDescription
                    insertNewObjectForEntityForName:@"BookMarks"
                    inManagedObjectContext:context];
    
    feed.shirtName = shirtName;
    feed.trouserName = trouserName;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
        return FAILED;
    }
    
    return SAVED;
}

// =======================================================================================================================================
// method to insert shirts into database
// =======================================================================================================================================

+(BOOL)insertShirtDetailIntoDB:(NSString *)imageName
{
    NSInteger shirtsCount = [[CoreDataManager getAllShirtsFromDB] count];
    
    AppDelegate *appDelegateObj = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = [appDelegateObj managedObjectContext];
    NSManagedObjectContext *context = managedObjectContext;
    Shirts *feed = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Shirts"
                            inManagedObjectContext:context];
    
    feed.uid = [NSNumber numberWithInteger:(shirtsCount+1)];
    feed.imageName = imageName;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
        return FAILED;
    }
    
    return SAVED;
}

// =======================================================================================================================================
// method to insert trousers into database
// =======================================================================================================================================

+(BOOL)insertTrouserDetailIntoDB:(NSString *)imageName
{
    NSInteger trouserCount = [[CoreDataManager getAllTrousersFromDB] count];
    
    AppDelegate *appDelegateObj = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *managedObjectContext = [appDelegateObj managedObjectContext];
    NSManagedObjectContext *context = managedObjectContext;
    Trousers *feed = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Trousers"
                            inManagedObjectContext:context];
    
    feed.uid = [NSNumber numberWithInteger:(trouserCount+1)];
    feed.imageName = imageName;
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        
        return FAILED;
    }
    
    return SAVED;
}

// =======================================================================================================================================
// method to get shirt image name from database for uid
// =======================================================================================================================================

+(NSArray *)getShirtImageNameForUid:(int)uid
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(uid == '%d')", uid]];
    [fetchRequest setPredicate:requestPredicate];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Shirts" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSMutableArray *idArray = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    return [idArray copy];
}

// =======================================================================================================================================
// method to get trousers image name from database for uid
// =======================================================================================================================================

+(NSArray *)getTrouserImageNameForUid:(int)uid
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *requestPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(uid == '%d')", uid]];
    [fetchRequest setPredicate:requestPredicate];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Trousers" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSMutableArray *idArray = [NSMutableArray arrayWithArray:[managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    return [idArray copy];
}

// =======================================================================================================================================
// method to get random dress from database
// =======================================================================================================================================

+(NSArray *)getRandomStyleImageNames
{
    NSInteger shirtsCount = [[CoreDataManager getAllShirtsFromDB] count];
    NSInteger trouserCount = [[CoreDataManager getAllTrousersFromDB] count];
    
    if(shirtsCount > 0 && trouserCount > 0)
    {
        int randomShirtUid = rand() % shirtsCount + 1;
        int randomTrouserUid = rand() % trouserCount + 1;
    
        NSArray *shirt = [CoreDataManager getShirtImageNameForUid:randomShirtUid];
        NSArray *trouser = [CoreDataManager getTrouserImageNameForUid:randomTrouserUid];
    
        Shirts *shirtObj = [shirt objectAtIndex:0];
        Trousers *trouserObj = [trouser objectAtIndex:0];
    
        NSArray *pairArray = [NSArray arrayWithObjects:shirtObj.imageName,trouserObj.imageName, nil];
        return pairArray;
    }
    else
    {
        return nil;
    }
}

// =======================================================================================================================================

@end
