//
//  StylesViewController.h
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StylesViewController : UIViewController

// objects/ IBOutlets
@property (nonatomic, strong) IBOutlet UIImageView *shirtImageView;
@property (nonatomic, strong) IBOutlet UIImageView *trouserImageView;
@property (nonatomic, strong) IBOutlet UILabel *noDataLbl;

@property (nonatomic, strong) IBOutlet UIView *buttonContainerView;
@property (nonatomic, strong) IBOutlet UIButton *bookmarkBtn;
@property (nonatomic, strong) IBOutlet UIButton *dislikeBtn;

@end
