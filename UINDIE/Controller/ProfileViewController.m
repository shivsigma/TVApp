//
//  ProfileViewController.m
//  UINDIE
//
//  Created by apple on 7/26/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (IBAction)LogoutClick:(id)sender
{
    UIAlertView * alert  = [[UIAlertView alloc]initWithTitle:alertTitle message:@"Would you like to logout?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    alert.tag = 2000;
    [alert show];
}

+(ProfileViewController *)initViewController{
    ProfileViewController * controller;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        controller  = [[ProfileViewController alloc]initWithNibName:@"ProfileViewControllerIPad" bundle:nil];
    }else{
        controller  = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    }
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

//    [ServiceList clearInstance];
    self.navigationController.navigationBarHidden = NO;
    
    UIImageView * imagev = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo120.png"]];
    [imagev setContentMode:UIViewContentModeScaleAspectFit];
    imagev.frame = CGRectMake(0, 0, 80, 80);
    self.navigationItem.titleView = imagev;
    

    
   UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
   [backButton setImage:[UIImage imageNamed:@"back-arrow.png"] forState:UIControlStateNormal];
   backButton.frame = CGRectMake(0, 0, 13, 23);
   [backButton addTarget:self action:@selector(closeClicked:) forControlEvents:UIControlEventTouchUpInside];
   UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = back;
    
    Account *account=[AccountManager Instance].activeAccount;
    _lblUsername.text = [NSString stringWithFormat:@"%@",account.username];
    _imgView.url = [NSURL URLWithString:account.profile_pic];
    [[ServiceList Instance]ALLFavouriteVideo:self];
    
    _imgView.layer.borderWidth = 4.0;
    _imgView.layer.borderColor = [UIColor whiteColor].CGColor;
   
    [account authenticatedWithUserName:account.email andPassword:account.password withDelegate:self];
    // Do any additional setup after loading the view from its nib.
}

-(void)closeClicked:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _FavVideo.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    FevoriteTableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        // NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:self options:nil];
        NSArray *topLevelObjects;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FevoriteTableViewCellIPad" owner:self options:nil];
        }
        else{
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FevoriteTableViewCell" owner:self options:nil];
        }
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell =  (FevoriteTableViewCell *) currentObject;
                break;
            }
        }
    }
    
    FavouriteInfo * fi = [_FavVideo objectAtIndex:indexPath.row];
    [cell setFevoriteItem:fi Delegate:self];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FavouriteInfo * info = [_FavVideo objectAtIndex:indexPath.row];
    FavoriteDetailView * view = [FavoriteDetailView initViewFavouriteInfo:info];
    [[KGModal sharedInstance]showWithContentView:view andAnimated:YES];
   // return;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





/* =============== My CODE ======================= */

- (IBAction)btnSelectPhoto:(id)sender {
    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Select Photo" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take a Photo",@"Existing Image", nil];
    [alrt show];
}

- (IBAction)btnUpdatePhoto:(id)sender {
  /*  Account * account =[AccountManager Instance].activeAccount;
    account.profileImage=_imgView.image;
    [[ActivityIndicator currentIndicator]displayActivity:@"Photo Updateding..."];
    [account ProfilePicWithdelegate:self];    */
    Account * account =[AccountManager Instance].activeAccount;
    account.profileImage=_profileImage;
    [[ActivityIndicator currentIndicator]displayActivity:@"Photo Updating..."];
    [account ProfilePicWithdelegate:self];
   // CGRect newFrame = CGRectMake(_imgView.frame.origin.x, _imgView.frame.origin.y, 80.0, 80.0);
  //  _imgView.frame=newFrame;
  //  _imgView.layer.borderWidth=1.0;
    //_imgView.layer.masksToBounds = false;
    //_imgView.layer.borderColor =[UIColor whiteColor].CGColor;
   /// _imgView.layer.cornerRadius =13;
   // _imgView.layer.cornerRadius = _imgView.frame.size.width/2;
   // _imgView.clipsToBounds = true;
    _imgView.image=_profileImage;
}


#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    picker.allowsEditing=YES;
    picker.delegate=self;
    UIImage * _chosenImage = info[UIImagePickerControllerEditedImage];
    
    _profileImage=[self imageResize:_chosenImage andResizeTo:CGSizeMake(111, 111)];
    _profileImage=_chosenImage;
    _imgView.image = [self imageResize:_chosenImage andResizeTo:CGSizeMake(102, 111)];
    [self btnUpdatePhoto:nil];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)OpenGalleryToUserPhotoLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}


-(void)OpenCameraToCapture
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"UND TV"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
    
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    if(alertView.tag==100)
    {
        if (buttonIndex==0)
        {
           [[ServiceList Instance]AccountDeactiveWithUserID:self];
            //NSLog(@"YES");
        }
        if (buttonIndex==1) {
            
        }
    }else if (alertView.tag == 2000){
        if (buttonIndex==0)
        {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
            [AccountManager Instance].activeAccount = nil;
            //NSLog(@"YES");
        }
    }else{
        if (buttonIndex==1)
        {
            [self OpenCameraToCapture];
        }
        if (buttonIndex==2)
        {
            [self OpenGalleryToUserPhotoLibrary];
        }
    }
    
}

-(void)accountAuthenticatedWithAccount:(Account*) account{
        [[ActivityIndicator currentIndicator]displayCompleted];
        [AccountManager Instance].activeAccount = account;
       _imgView.url = [NSURL URLWithString:account.profile_pic];
}

-(void)accountDidFailAuthentication:(NSError*) error{
    [[ActivityIndicator currentIndicator]displayCompleted];
}

- (IBAction)ChangePasswordClicked:(id)sender {
    ChangePasswordViewController * controller =[ChangePasswordViewController initViewController];
    UINavigationController * navigationController = [[UINavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

- (IBAction)AccountDeactivateClick:(id)sender {
    
    // Email Subject
    NSString *emailTitle = @"Support mail";
    // Email Content
    NSString *messageBody = @""; // Change the message body to HTML
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"info@undnow.net"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:YES];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Are you sure delete account?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES",@"NO", nil];
//    alert.tag=100;
//    [alert show];
}

//  today
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            //NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            //NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    [[ActivityIndicator currentIndicator]displayCompleted];
    if ([tag isEqual:GET_FAV]) {
        _FavVideo=[[NSMutableArray alloc]init];
        _FavVideo=[[ServiceList Instance]getAllFavouriteVideos];
        [self.tblView reloadData];
    }
    else if ([tag isEqual:ACCOUNTDEACTIVE])
    {
        [AccountManager Instance].activeAccount=nil;
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:@"User Delete Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    else if ([tag isEqual:FEV_DELETE])
    {
       /* UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UINDIE" message:@"Fevourite deleted." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];*/
    }else if ([tag isEqual:EDIT_CREDITCARD]){
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:@"Card Save Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
}

- (IBAction)EditCreditCardClicked:(id)sender {
    SaveCardAddressViewController * controller = [SaveCardAddressViewController initViewController];
    [self.navigationController pushViewController:controller animated:YES];
  
}

-(void)FevoriteDeleteFevoriteItem:(FavouriteInfo *)FavouriteItem
{
    [[ServiceList Instance]DeleteFavVideoInfo:FavouriteItem Delegate:self];
    [[ServiceList Instance]removeItembyTableEditRowFromFavorite:FavouriteItem];
    _FavVideo = [[NSMutableArray alloc]init];
    _FavVideo = [ServiceList Instance].favArr;
    [_tblView reloadData];
}

#pragma CreditCard List

- (IBAction)CreditCardListClicked:(id)sender {
    CardListViewController * controller =[CardListViewController initViewController];
    UINavigationController * navigationController =[[UINavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}


#pragma Portrait mode

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.fullScreenVideoIsPlaying = NO;
    
    [self supportedInterfaceOrientations];
    
    [self shouldAutorotate:UIInterfaceOrientationPortrait];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate:(UIInterfaceOrientation)interfaceOrientation{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}


@end
