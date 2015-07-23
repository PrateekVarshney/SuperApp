//
//  Support.m
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import "Support.h"

@implementation Support

// =======================================================================================================================================
// method to show alert box
// =======================================================================================================================================

+(void)showAlert:(NSString *)title message:(NSString *)_message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:_message delegate:nil cancelButtonTitle:[Support getLocalizedString:@"OK"] otherButtonTitles:nil, nil];
    [alert show];
}

// =======================================================================================================================================
// method to get localized text for a key
// =======================================================================================================================================

+(NSString *)getLocalizedString:(NSString *)key
{
    return NSLocalizedString(key, "This is localized string");
}

// =======================================================================================================================================
// method to save image in folder and get image name
// =======================================================================================================================================

+(NSString *)writeImageToFile:(UIImage *)image
{
    NSData *pngData = UIImagePNGRepresentation(image);
    
    NSString *documentsPath = [Support getImagesDirectoryPath];
    
    NSString *imageName = [Support getCurrentTimeStamp];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:imageName]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
    
    return imageName;
}

// =======================================================================================================================================
// method to get all images in directory
// =======================================================================================================================================

+(NSArray *)getAllImages
{
    NSString *documentsPath = [Support getImagesDirectoryPath];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsPath
                                                      error:nil];
    return  files;
}

// =======================================================================================================================================
// method to get a particular image from directory
// =======================================================================================================================================

+(UIImage *)getImageWithName:(NSString *)name
{
    NSString *documentsPath = [Support getImagesDirectoryPath];
    NSString  *imageFilePath = [documentsPath stringByAppendingPathComponent:name];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:imageFilePath]) {
        NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath];
        UIImage *img = [UIImage imageWithData:imageData];
        return img;
    }
    else
    {
        NSLog(@"Image does not exist @ %@",imageFilePath);
        return nil;
    }
}

// =======================================================================================================================================
// method to get current timestamp string
// =======================================================================================================================================

+ (NSString *)getCurrentTimeStamp
{
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
}

// =======================================================================================================================================
// method to get documents directory path
// =======================================================================================================================================

+(NSString *)getImagesDirectoryPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    documentsPath = [documentsPath stringByAppendingPathComponent:@"SuperImages"];
    
    NSError * error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:documentsPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    return documentsPath;
}

// =======================================================================================================================================

@end
