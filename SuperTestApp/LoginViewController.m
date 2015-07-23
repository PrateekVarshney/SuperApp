//
//  LoginViewController.m
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LoginViewController ()

@property (nonatomic, strong) AppDelegate *appDelegateObj;

@end

@implementation LoginViewController

// =======================================================================================================================================
// view controller life cycle methods
// =======================================================================================================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // create app delegate object
    self.appDelegateObj = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // check if facebook session is open then call method to get user details
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended)
    {
        // call facebook user details method
        [self getFacebookUserDetails];
    }
}

// =======================================================================================================================================

-(void)viewWillAppear:(BOOL)animated
{
    // hide navigation bar
    self.navigationController.navigationBarHidden = YES;
}

// =======================================================================================================================================

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// =======================================================================================================================================
#pragma mark IBActions
// =======================================================================================================================================

-(IBAction)loginViaFacebook:(id)sender
{
    [self tryFacebookLogin];
}

// =======================================================================================================================================
// method to try facebook login
// =======================================================================================================================================

-(void)tryFacebookLogin
{
    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // if fb session is open and user clicks on login button again then do a logout
        [FBSession.activeSession closeAndClearTokenInformation];
        
    } else {
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile",@"email"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // call to get user details
             [self getFacebookUserDetails];
         }];
    }
}

// =======================================================================================================================================
// method to get facebook user details
// =======================================================================================================================================

-(void)getFacebookUserDetails
{
    // check for open fb session
    if (FBSession.activeSession.isOpen)
    {
        // get user details
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 
                 // store user information in User model object
                 NSString *facebookId = [user objectForKey:@"id"];
                 
                 NSLog(@"User Name : %@ %@",user.first_name,user.last_name);
                 NSLog(@"User Pic : %@",[[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId]);
                 
                 // redirect to home view controller after getting user details
                 [self performSegueWithIdentifier:HomeSegue sender:self];
                 
             }
         }];
    }
}

// =======================================================================================================================================

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
