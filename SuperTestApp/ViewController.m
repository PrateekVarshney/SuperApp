//
//  ViewController.m
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// =======================================================================================================================================
// View controller life cycle methods
// =======================================================================================================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = [Support getLocalizedString:@"Super Test App"];
    
    // set button styles
    self.uploadImageBtn.backgroundColor = [UIColor blueColor];
    self.viewStyleBtn.backgroundColor = [UIColor greenColor];
    self.viewBookmarksBtn.backgroundColor = [UIColor orangeColor];
    
    self.uploadImageBtn.layer.cornerRadius = 5.0;
    self.viewStyleBtn.layer.cornerRadius = 5.0;
    self.viewBookmarksBtn.layer.cornerRadius = 5.0;
    
    // rotate them
    self.uploadImageBtn.transform = CGAffineTransformMakeRotation (-0.25/3.14);
    self.viewStyleBtn.transform = CGAffineTransformMakeRotation (0.25/3.14);
    self.viewBookmarksBtn.transform = CGAffineTransformMakeRotation (-0.25/3.14);
}

// =======================================================================================================================================

-(void)viewWillAppear:(BOOL)animated
{
    // unhide the navigation bar
    self.navigationController.navigationBarHidden = NO;
    // hide back button as user should not be allowed to go to previous screen
    [self.navigationItem setHidesBackButton:YES animated:NO];
}

// =======================================================================================================================================

-(void)viewDidAppear:(BOOL)animated
{
    // check if trousers and shirts have been uploaded
    NSUserDefaults *defaultObj = [NSUserDefaults standardUserDefaults];
    
    [defaultObj setValue:[NSNumber numberWithBool:true] forKey:UserLoggedIn];
    [defaultObj synchronize];
    
    int shirtUploaded = [[defaultObj valueForKey:ShirtUploaded] intValue];
    int trouserUploaded = [[defaultObj valueForKey:ShirtUploaded] intValue];
    
    // if not redirect to upload screen
    if(!(shirtUploaded * trouserUploaded))
    {
        [self performSegueWithIdentifier:UploadImagesSegue sender:self];
    }
}

// =======================================================================================================================================
// method to share screenshot of the dress

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// =======================================================================================================================================

@end
