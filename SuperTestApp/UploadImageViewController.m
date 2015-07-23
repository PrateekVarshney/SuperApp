//
//  UploadImageViewController.m
//  SuperTestApp
//
//  Created by Prateek Varshney on 22/07/15.
//  Copyright (c) 2015 PrateekVarshney. All rights reserved.
//

#import "UploadImageViewController.h"

// create constants
const int SHIRT_ACTION = 1;
const int TROUSER_ACTION = 2;

@interface UploadImageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, assign) int totalButtons;

@property (nonatomic, assign) NSInteger saveClothType;

@end

@implementation UploadImageViewController

// =======================================================================================================================================
// view controller life cycle methods
// =======================================================================================================================================

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [Support getLocalizedString:@"Upload Pictures"];
    
    // set style for buttons on the view
    self.uploadShirtBtn.layer.cornerRadius = 5.0;
    self.uploadShirtBtn.backgroundColor = [UIColor magentaColor];
    
    self.uploadTrouserBtn.layer.cornerRadius = 5.0;
    self.uploadTrouserBtn.backgroundColor = [UIColor purpleColor];
}

// =======================================================================================================================================

-(void)viewWillAppear:(BOOL)animated
{
    // check if both shirts and trousers have been uploaded else hide back button to disable going back untill both are uploaded
    NSUserDefaults *defaultObj = [NSUserDefaults standardUserDefaults];
    
    int shirtUploaded = [[defaultObj valueForKey:ShirtUploaded] intValue];
    int trouserUploaded = [[defaultObj valueForKey:ShirtUploaded] intValue];
    
    if(!(shirtUploaded * trouserUploaded))
    {
        // hide back button as user should not be allowed to go to previous screen
        [self.navigationItem setHidesBackButton:YES animated:NO];
    }
    else
    {
        // unhide back button
        [self.navigationItem setHidesBackButton:NO animated:NO];
    }
}

// =======================================================================================================================================

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// method to show white status bar for image picker
//================================================================================================

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /* Cancel button color  */
    self.imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    /* Status bar color */
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

// =======================================================================================================================================
# pragma mark IBActions
// =======================================================================================================================================

- (IBAction)selectShirtPicture:(id)sender
{
    UIActionSheet *selectImageAcionSheet;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        //camera not available
        selectImageAcionSheet = [[UIActionSheet alloc]
                                 initWithTitle:@"Select Photo For Shirt"
                                 delegate:self
                                 cancelButtonTitle:[Support getLocalizedString:@"Cancel"]
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:[Support getLocalizedString:@"Photo from library"], nil];
        
        self.totalButtons = 1;
    }
    else
    {
        
        selectImageAcionSheet = [[UIActionSheet alloc]
                                 initWithTitle:@"Select Photo For Shirt"
                                 delegate:self
                                 cancelButtonTitle:[Support getLocalizedString:@"Cancel"]
                                 destructiveButtonTitle:[Support getLocalizedString:@"Take Photo"]
                                 otherButtonTitles:[Support getLocalizedString:@"Photo from library"], nil];
        
        self.totalButtons = 2;
    }
    
    selectImageAcionSheet.tag = SHIRT_ACTION;
    
    [selectImageAcionSheet showInView:self.view];
}

// =======================================================================================================================================

- (IBAction)selectTrouserPicture:(id)sender
{
    UIActionSheet *selectImageAcionSheet;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        //camera not available
        selectImageAcionSheet = [[UIActionSheet alloc]
                                 initWithTitle:@"Select Photo For Trouser"
                                 delegate:self
                                 cancelButtonTitle:[Support getLocalizedString:@"Cancel"]
                                 destructiveButtonTitle:nil
                                 otherButtonTitles:[Support getLocalizedString:@"Photo from library"], nil];
        
        self.totalButtons = 1;
    }
    else
    {
        
        selectImageAcionSheet = [[UIActionSheet alloc]
                                 initWithTitle:@"Select Photo For Trouser"
                                 delegate:self
                                 cancelButtonTitle:[Support getLocalizedString:@"Cancel"]
                                 destructiveButtonTitle:[Support getLocalizedString:@"Take Photo"]
                                 otherButtonTitles:[Support getLocalizedString:@"Photo from library"], nil];
        
        self.totalButtons = 2;
    }
    
    selectImageAcionSheet.tag = TROUSER_ACTION;
    
    [selectImageAcionSheet showInView:self.view];
}

// =======================================================================================================================================

#pragma mark ACTIONSHEET DELEGATE

// =======================================================================================================================================

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            //============
            [self openGalleryOrCamera:UIImagePickerControllerSourceTypePhotoLibrary forClothing:actionSheet.tag];
            break;
        }
        case 1:
        {
            //============
            (self.totalButtons==buttonIndex)?nil:[self openGalleryOrCamera:UIImagePickerControllerSourceTypeCamera forClothing:actionSheet.tag];
            break;
        }
            
        default:
            break;
    }
    
}

//=============================================================================================

-(void)openGalleryOrCamera:(int)type forClothing:(NSInteger)clothingType
{
    self.imagePickerController=[[UIImagePickerController alloc]init];
    
    self.imagePickerController.sourceType=type;
    
    self.imagePickerController.delegate = self;
    
    self.saveClothType = clothingType;
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

//=============================================================================================

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error)
    {
        [Support showAlert:[Support getLocalizedString:@"Error"] message:[Support getLocalizedString:@"Unable To Access Image"]];
    }
}

//=============================================================================================

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//=============================================================================================

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //NSData *imageData1 = [[NSData alloc] initWithData:UIImageJPEGRepresentation(image, 0.2)];
    //UIImage *img = [UIImage imageWithData:imageData1];
    
    int switchValue = (int)self.saveClothType;
    switch (switchValue) {
        case SHIRT_ACTION:
        {
            // save image in the directory
            NSString *shirtName = [Support writeImageToFile:image];
            // insert shirt details into the database
            if([CoreDataManager insertShirtDetailIntoDB:shirtName])
            {
                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:true] forKey:ShirtUploaded];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [Support showAlert:[Support getLocalizedString:@"Shirt Saved!"] message:nil];
            }
            else
            {
                [Support showAlert:[Support getLocalizedString:@"Failed saving image. Please try again."] message:nil];
            }
        }
            break;
        case TROUSER_ACTION:
        {
            // save image in the directory
            NSString *trouserName = [Support writeImageToFile:image];
            // insert trouser details into the database
            if([CoreDataManager insertTrouserDetailIntoDB:trouserName])
            {
                [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:true] forKey:TrouserUploaded];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [Support showAlert:[Support getLocalizedString:@"Trouser Saved!"] message:nil];
            }
            else
            {
                [Support showAlert:[Support getLocalizedString:@"Failed saving image. Please try again."] message:nil];
            }
        }
            break;
            
        default:
            break;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//=============================================================================================

@end
