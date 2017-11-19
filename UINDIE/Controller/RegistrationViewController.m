//
//  RegistrationViewController.m
//  UINDIE
//
//  Created by apple on 5/11/15.
//  Copyright (c) 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController


+(RegistrationViewController *)initViewController{
    RegistrationViewController * controller;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        controller = [[RegistrationViewController alloc]initWithNibName:@"RegistrationViewController_iPad" bundle:nil];
    }else{
        controller = [[RegistrationViewController alloc]initWithNibName:@"RegistrationViewController" bundle:nil];
    }

    
    return controller;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    CGRect newFrame = CGRectMake(_profilePicture.frame.origin.x, _profilePicture.frame.origin.y, 100.0, 100.0);
    _profilePicture.frame=newFrame;
    _profilePicture.layer.borderWidth=1.0;
    _profilePicture.layer.masksToBounds = false;
    _profilePicture.layer.borderColor =[UIColor whiteColor].CGColor;
    _profilePicture.layer.cornerRadius = 13;
    _profilePicture.layer.cornerRadius = _profilePicture.frame.size.width/2;
    _profilePicture.clipsToBounds = true;
    
    self.navigationController.navigationBarHidden = YES;
    
    genderArray = [[NSMutableArray alloc]init];
    [genderArray addObject:@"Male"];
    [genderArray addObject:@"Female"];
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    [login setImage:[UIImage imageNamed:@"back-arrow.png"] forState:UIControlStateNormal];
    [login setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    login.frame = CGRectMake(0,0,17,17);
    [login addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *loginItem = [[UIBarButtonItem alloc] initWithCustomView:login];
    self.navigationItem.leftBarButtonItem =loginItem;
    
    UIImageView * imagev = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo120.png"]];
    [imagev setContentMode:UIViewContentModeScaleAspectFit];
    imagev.frame = CGRectMake(0, 0, 80, 49);
    self.navigationItem.titleView = imagev;
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width,732.0);
    // Do any additional setup after loading the view from its nib.
}

- (void)popViewController{
    
}
-(void)backClicked:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    /*You can remove the below comment if you dont want to scale the image in retina   device .Dont forget to comment UIGraphicsBeginImageContextWithOptions*/
    UIGraphicsBeginImageContext(newSize);
   // UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)genderClicked:(id)sender{
    UIPickerView * picker = [[UIPickerView alloc]init];
    picker.showsSelectionIndicator=YES;
    picker.dataSource = self;
    picker.delegate = self;
    [self openPickerViewWithTag:GENDER andTitle:@"Gender" forPickerView:picker];
}

-(void)profilePicClicked:(id)sender{
    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Select Photo" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take a Photo",@"Existing Image", nil];
    [alrt show];
}

-(void)DateOfBirthClicked:(id)sender{
    UIDatePicker *_timerPicker = [[UIDatePicker alloc] init];
    [_timerPicker setDatePickerMode:UIDatePickerModeDate];
    _timerPicker.date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSDate *dt = [NSDate date];
    _timerPicker.date = dt;
    [self openDatePickerViewWithTag:DOB andTitle:@"DateOfBirth" forDatePickerView:_timerPicker];
    
}
#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    picker.allowsEditing=YES;
    picker.delegate=self;
    UIImage * _chosenImage = info[UIImagePickerControllerEditedImage];
    
    // = _chosenImage;
    _profilePicture.image = [self imageResize:_chosenImage andResizeTo:CGSizeMake(80, 80)];
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"UINDIE"
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
    if (buttonIndex==1)
    {
        [self OpenCameraToCapture];
    }
    if (buttonIndex==2)
    {
        [self OpenGalleryToUserPhotoLibrary];
    }
}

-(void)submitClicked:(id)sender{
    NSString * message = @"";
    if (txtFirstname.text.length <= 0) {
        message =@"Please enter the First Name.";
    }else if (txtLastname.text.length <= 0) {
        message =@"Please enter the Last Name.";
    }else if (txtUsername.text.length <= 0) {
        message =@"Please enter the User Name.";
    }
    else if (txtEmail.text.length <= 0) {
        message =@"Please enter the Email.";
    }
    else if (txtPassword.text.length <= 0) {
        message =@"Please enter the Password.";
//        if (txtPassword.text != txtConfirmPassword.text) {
//            message =@"Password & Confirm Password does not match.";
//        }
    }
    else if (txtConfirmPassword.text.length<=0)
    {
        message=@"Please enter the Confirm Password.";
    }
    else if (![txtPassword.text isEqual:txtConfirmPassword.text]) {
                    message =@"Password & Confirm Password does not match.";
    }
    else if (txtGender.text.length <= 0) {
        txtGender.text = @"";
    }else if (txtDateOfBirth.text.length <= 0) {
        txtDateOfBirth.text = @"";
    }
    else if (txtState.text.length <= 0) {
        txtState.text = @"";
    }else if (txtCity.text.length <= 0) {
        txtCity.text = @"";
    }
    
    
    if (message.length > 0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
       
    
    Account * account =[[Account alloc]init];
    account.first_name = txtFirstname.text;
    account.last_name = txtLastname.text;
    account.username = txtUsername.text;
    account.gender = txtGender.text;
    account.dateofbirth = txtDateOfBirth.text;
    account.email= txtEmail.text;
    account.password = txtPassword.text;
    account.profileImage = _profilePicture.image;
    account.city = txtCity.text;
    account.state = txtState.text;

    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [account registrationWithDelegate:self];
    
}

-(void)accountAuthenticatedWithAccount:(Account *)account{
    [AccountManager Instance].activeAccount = account;
    [[ActivityIndicator currentIndicator]displayCompleted];
   
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"kLoginRedirect" object:nil];
}

-(void)accountDidFailAuthentication:(NSError *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:[error.userInfo objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark- UIActionSheet & PickerView Delegate


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return genderArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [genderArray objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void) openPickerViewWithTag:(int) tag andTitle:(NSString*) title forPickerView:(UIPickerView*) picker
{
    
    [self.view endEditing:YES];
    picker.showsSelectionIndicator=YES;
    picker.dataSource = self;
    picker.delegate = self;
    picker.tag = tag;
    CommonActionSheet_iPad * action = [CommonActionSheet_iPad initIPadUIPickerWithTitle:title delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" pickerView:picker inView:self.view];
    
    action.tag = tag;
    action.isViewOpen= YES;
    [action show];
    
}


- (void) openDatePickerViewWithTag:(int) tag andTitle:(NSString*) title forDatePickerView:(UIDatePicker*) picker
{
    [self.view endEditing:YES];
    CommonActionSheet_iPad * action = [CommonActionSheet_iPad initIPadUIDatePickerWithTitle:title delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" DatepickerView:picker inView:self.view withCustomDate:nil];
    
    action.tag = tag;
    action.isViewOpen= YES;
    [action showDatePicker];
}

-(void)actionSheetCancelClickedWithActionSheet:(CommonActionSheet_iPad *)actionSheet{
    
}

-(void)actionSheetDoneClickedWithActionSheet:(CommonActionSheet_iPad *)actionSheet{
    if (actionSheet.tag == DOB) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd-yyyy"];
        NSString *dateformat = [formatter stringFromDate:actionSheet.datePicker.date];
        txtDateOfBirth.text = dateformat;
    }else{
        NSUInteger ixd = [actionSheet.pickerView selectedRowInComponent:0];
        NSString * temp = [genderArray objectAtIndex:ixd];
        txtGender.text = temp;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma Portrait mode

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.fullScreenVideoIsPlaying = NO;
    
    [self supportedInterfaceOrientations];
    
    [self shouldAutorotate:UIInterfaceOrientationPortrait];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    
     //------ ravinder ----//
    if (appDelegate.isLoginFromFB){
        txtFirstname.text = self.fbUserInfo[@"first_name"];
        txtLastname.text = self.fbUserInfo[@"last_name"];
        txtUsername.text = self.fbUserInfo[@"name"];
        txtEmail.text = self.fbUserInfo[@"email"];
        txtGender.text = self.fbUserInfo[@"gender"];
        txtDateOfBirth.text = [self.fbUserInfo[@"birthday"] stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
        
        
        NSString *ImageURL = self.fbUserInfo[@"picture"][@"data"][@"url"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        self.profilePicture.image = [UIImage imageWithData:imageData];
        
        txtState.text = self.fbUserInfo[@"hometown"][@"name"];
        txtCity.text = self.fbUserInfo[@"location"][@"name"];
        
    }
    //-----------------//
    
}

-(void)viewWillDisappear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.isLoginFromFB = NO;
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
