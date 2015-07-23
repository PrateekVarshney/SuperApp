//
//  StylesViewController.m
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import "StylesViewController.h"

@interface StylesViewController ()

@property (nonatomic, strong) NSArray *currentDress;

@end

@implementation StylesViewController

// =======================================================================================================================================
// View controller life cycle methods
// =======================================================================================================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [Support getLocalizedString:@"Today's Style"];
    
    // set rounded corners for buttons
    self.bookmarkBtn.layer.cornerRadius = 5.0;
    self.bookmarkBtn.backgroundColor = [UIColor yellowColor];
    
    self.dislikeBtn.layer.cornerRadius = 5.0;
    self.dislikeBtn.backgroundColor = [UIColor redColor];
    
    // call function to display random dress
    [self displayRandomDress];
}

// =======================================================================================================================================
// method to random dress
// =======================================================================================================================================

-(void)displayRandomDress
{
    // get random dress image names from database
    NSArray *randomDress = [CoreDataManager getRandomStyleImageNames];
    
    // if array is not empty then show the respective dresses in respective image views
    if(randomDress.count > 0)
    {
        // set global array value as current dress array
        self.currentDress = randomDress;
        
        self.shirtImageView.image = [Support getImageWithName:randomDress[0]];
        self.trouserImageView.image = [Support getImageWithName:randomDress[1]];
        
        // hide no data label and unhide action buttons
        self.noDataLbl.hidden = true;
        self.bookmarkBtn.hidden = false;
        self.dislikeBtn.hidden = false;
    }
    else
    {
        // since array is empty hide action buttons and unhide no data label
        self.noDataLbl.hidden = false;
        self.bookmarkBtn.hidden = true;
        self.dislikeBtn.hidden = true;
    }
}

// =======================================================================================================================================

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

// =======================================================================================================================================
// method to bookmark current dress
// =======================================================================================================================================

-(IBAction)bookMarkCurrentStyle:(id)sender
{
    // insert bookmark in database and if success show animation
    if([CoreDataManager insertBookMarksIntoDbWithShirtName:self.currentDress[0] trouserName:self.currentDress[1]])
    {
        //[Support showAlert:[Support getLocalizedString:@"Bookmarked Successfully!"] message:nil];
        
        // create a copy of image views for animation
        UIImageView *shirtImageCopy = [[UIImageView alloc] initWithFrame:self.shirtImageView.frame];
        UIImageView *trouserImageCopy = [[UIImageView alloc] initWithFrame:self.trouserImageView.frame];
        shirtImageCopy.image = self.shirtImageView.image;
        trouserImageCopy.image = self.trouserImageView.image;
        
        // add copies to the view
        [self.view addSubview:shirtImageCopy];
        [self.view addSubview:trouserImageCopy];
        
        // create frame where images will go/move
        CGRect destFrame = CGRectMake(self.buttonContainerView.frame.origin.x, self.buttonContainerView.frame.origin.y, self.bookmarkBtn.frame.size.width, self.bookmarkBtn.frame.size.height);
        
        // show animations
        [shirtImageCopy genieInTransitionWithDuration:0.7
                                      destinationRect:destFrame
                                      destinationEdge:BCRectEdgeTop
                                           completion:^{
                                               [shirtImageCopy removeFromSuperview];
                                           }];
        [trouserImageCopy genieInTransitionWithDuration:0.7
                                        destinationRect:destFrame
                                        destinationEdge:BCRectEdgeTop
                                             completion:^{
                                                 [trouserImageCopy removeFromSuperview];
                                             }];
    }
    else
    {
        // show error while bookmarking
        [Support showAlert:[Support getLocalizedString:@"Failed creating bookmarked. Please try again"] message:nil];
    }
}

// =======================================================================================================================================
// method to change dress and show another random dress
// =======================================================================================================================================

-(IBAction)changeStyle:(id)sender
{
    // create frame to animate images and show new images
    CGRect destFrame = CGRectMake((self.buttonContainerView.frame.size.width-self.dislikeBtn.frame.size.width), self.buttonContainerView.frame.origin.y, self.dislikeBtn.frame.size.width, self.dislikeBtn.frame.size.height);
    
    [self.shirtImageView genieInTransitionWithDuration:0.7
                                    destinationRect:destFrame
                                    destinationEdge:BCRectEdgeTop
                                    completion:^{
                                                
            self.shirtImageView.hidden = true;
                                                
            [self.trouserImageView genieInTransitionWithDuration:0.7
                                            destinationRect:destFrame
                                            destinationEdge:BCRectEdgeTop
                                            completion:^{
                                                            
                                self.trouserImageView.hidden = true;
                                                                                              
                                [self displayRandomDress];
                                                                                              
                                self.shirtImageView.hidden = false;
                                self.trouserImageView.hidden = false;
                                                                                              
                                [self.shirtImageView genieOutTransitionWithDuration:0.7
                                                        startRect:destFrame
                                                        startEdge:BCRectEdgeTop
                                                        completion:^{
                                                            
                                            self.shirtImageView.hidden = false;
                                                            
                                            [self.trouserImageView genieOutTransitionWithDuration:0.7
                                                                                startRect:destFrame
                                                                                startEdge:BCRectEdgeTop                                                                                                    completion:^{
                                                                                                                                                                                          self.trouserImageView.hidden = false;
                                                                                                                                                                                      }];
                                                        }];
                                            }];
                                    }];
    
}

// =======================================================================================================================================

@end
