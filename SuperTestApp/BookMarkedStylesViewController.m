//
//  BookMarkedStylesViewController.m
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import "BookMarkedStylesViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface BookMarkedStylesViewController ()

@property (nonatomic, strong) NSArray *bookmarkedDresses;
@property (nonatomic, assign) int currentPointer;

@end

@implementation BookMarkedStylesViewController

// =======================================================================================================================================
// view controller lif cycle methods
// =======================================================================================================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [Support getLocalizedString:@"BookMarks"];
    
    // create swipe objects and add it to view
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    // Setting the swipe direction.
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [self.view addGestureRecognizer:swipeLeft];
    [self.view addGestureRecognizer:swipeRight];
    
    // get all bookmarked dresses from database
    self.bookmarkedDresses = [CoreDataManager getAllBookMarksFromDB];
    
    // pointer to point to first address of the array
    self.currentPointer = 0;
    
    // check if there exists any bookmarked dress
    if(self.bookmarkedDresses.count > 0)
    {
        // get bookmarked dress details and show respective images in the imageviews
        BookMarks *dressObj = self.bookmarkedDresses[self.currentPointer];
        self.shirtImageView.image = [Support getImageWithName:dressObj.shirtName];
        self.trouserImageView.image = [Support getImageWithName:dressObj.trouserName];
        
        // hide no data/dress label
        self.noDataLbl.hidden = true;
        
        // create share button and add it on the navigation bar
        UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
        self.navigationItem.rightBarButtonItem = shareButton;
    }
    else
    {
        // unhide no data label as there is no data available to display
        self.noDataLbl.hidden = false;
    }
}

// =======================================================================================================================================

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// =======================================================================================================================================
// method to handle swipe gestures
// =======================================================================================================================================

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        NSLog(@"Left Swipe");
        
        // increase pointer
        self.currentPointer++;
        
        // if pointer points to location outside array reset it to first address
        if(self.currentPointer > (self.bookmarkedDresses.count - 1))
        {
            self.currentPointer = 0;
        }
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        
        // decrease pointer
        self.currentPointer--;
        
        // if pointer points to location outside array reset it to last address
        if(self.currentPointer < 0)
        {
            self.currentPointer = (int)self.bookmarkedDresses.count - 1;
        }
    }
    
    // if bookmarked dresses are available display them based on the pointer
    if(self.bookmarkedDresses.count > 0)
    {
        BookMarks *dressObj = self.bookmarkedDresses[self.currentPointer];
        self.shirtImageView.image = [Support getImageWithName:dressObj.shirtName];
        self.trouserImageView.image = [Support getImageWithName:dressObj.trouserName];
    }
}

// =======================================================================================================================================
// method to share screenshot of the dress
// =======================================================================================================================================

-(IBAction)shareAction:(id)sender
{
    UIImage *imgToShare = [self captureView:self.view];
    NSMutableArray *shareArray = [[NSMutableArray alloc] init];
    [shareArray addObject:@"Super Test App helped me deciding what to wear today!"];
    [shareArray addObject:imgToShare];
    UIActivityViewController *actCont = [[UIActivityViewController alloc] initWithActivityItems:shareArray applicationActivities:nil];
    actCont.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll, UIActivityTypeAirDrop];
    [self presentViewController:actCont animated:YES completion:nil];
}

// =======================================================================================================================================
// method to capture screenshot of the screen
// =======================================================================================================================================

- (UIImage*)captureView:(UIView *)view
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    rect.size.height = self.swipeInfoLbl.frame.origin.y;
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
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
