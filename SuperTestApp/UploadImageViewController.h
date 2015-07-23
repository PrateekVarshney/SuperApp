//
//  UploadImageViewController.h
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const int SHIRT_ACTION;
extern const int TROUSER_ACTION;

@interface UploadImageViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *uploadShirtBtn;
@property (nonatomic, strong) IBOutlet UIButton *uploadTrouserBtn;

@end
