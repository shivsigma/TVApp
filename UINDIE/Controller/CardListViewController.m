//
//  CardListViewController.m
//  UINDIE
//
//  Created by Savan Shah on 10/16/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "CardListViewController.h"

@interface CardListViewController ()
@end

@implementation CardListViewController

+(CardListViewController *)initViewController{
    CardListViewController * controller;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
      controller= [[CardListViewController alloc]initWithNibName:@"CardListViewController_iPad" bundle:nil];
    }
    else
    {
        controller= [[CardListViewController alloc]initWithNibName:@"CardListViewController" bundle:nil];
    }
    controller.title = @"CREDIT CARD LIST";
    return controller;
}

-(void)viewWillAppear:(BOOL)animated
{
    

    
  //  [[BrainTreeInstance Instance]GETAllCardsDetails:self];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.fullScreenVideoIsPlaying = NO;
    
    [self supportedInterfaceOrientations];
    
    [self shouldAutorotate:UIInterfaceOrientationPortrait];
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back-arrow.png"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 13, 23);
    [backButton addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = back;

   
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [[BrainTreeInstance Instance]GETAllCardsDetails:self];
    // Do any additional setup after loading the view from its nib.
}

-(void)AddNewCreditCardClicked:(id)sender{
  
    
    
   AddNewCreditCardViewController  * controller =[AddNewCreditCardViewController initViewController];
    UINavigationController * navigationController =[[UINavigationController alloc]initWithRootViewController:controller];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

-(void)backClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cardListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     static NSString *simpleTableIdentifier = @"SimpleTableItem";
     
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
     }
     
     GetCardsInfo * feed_data=[_cardListArr objectAtIndex:indexPath.row];
   //  NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:feed_data.video_img]];
     //cell.imageView.image=[UIImage imageNamed:@"mastercard.png"];
    
    //==============
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 15.0f, 15.0f);
    UIImage *accImage = [UIImage imageNamed:@"Search_back.png"];
    [button setImage:accImage forState: UIControlStateNormal];
//    [button setTitle:@"Expand"
//            forState:UIControlStateNormal];
    
    [button addTarget:self
               action:@selector(performExpand:)
     forControlEvents:UIControlEventTouchUpInside];
    
    cell.accessoryView = button;
    
    //================================
    
    
        cell.detailTextLabel.text = feed_data.exp_date;
    NSString *lastFourChar = [feed_data.card substringFromIndex:[feed_data.card length] - 4];
    cell.textLabel.text= [NSString stringWithFormat:@"**** **** **** %@",lastFourChar];
    
     //  cell.textLabel.text = [NSString stringWithFormat:@"VIDEO %ld",indexPath.row +1];
     return cell;
   
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tblCreditCard deselectRowAtIndexPath:indexPath animated:YES];
    
    
//    for (int i=0; i<[self.cardListArr count]; i++) {
//        // whenever we reach the cell we have selected, let's change its accessoryType and its colour
//        if (i == indexPath.row)
//        {
//            // that's the row we have selected, let's update its
//            UITableViewCell *cell = [self.tblCreditCard cellForRowAtIndexPath:indexPath];
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            cell.textLabel.textColor = [UIColor colorWithRed:51.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
//        }
//        // if it isn't the cell we have selected, let's change it back to boring dark colour and no accessoryType
//        else {
//            UITableViewCell *cell = [self.tblCreditCard cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.textLabel.textColor = [UIColor darkTextColor];
//        }
//    }
    
    // don't forget to deselect the row
    
}

-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    [[ActivityIndicator currentIndicator]displayCompleted];
    if ([tag isEqual:GET_CARDS]) {
        _cardListArr=[[NSMutableArray alloc]init];
        _cardListArr=[[BrainTreeInstance Instance]getCardArr];
        [self.tblCreditCard reloadData];
    }
    else if ([tag isEqual:DELETE_CREDITCARD])
    {
         UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"UND TV" message:@"Card deleted Successfully." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];
    }
}

- (void)ModelListLoadFailWithError:(NSString *)error{
    [[ActivityIndicator currentIndicator]displayCompleted];
}

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


#pragma Portrait mode

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




////// ************** delete credit card ***************/
 - (void) performExpand:(UIButton *)paramSender{
     UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Would you like to delete this credit card.?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"YES",@"NO", nil];
     //alert.tag=100;
     
     
     UITableViewCell *ownerCell = (UITableViewCell*)paramSender.superview;
     NSIndexPath *ownerCellIndexPath =
     [self.tblCreditCard indexPathForCell:ownerCell];
     //NSLog(@"hardik row %ld", (long)ownerCellIndexPath.row);
     alert.tag = ownerCellIndexPath.row;
     [alert show];
 }


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    NSInteger rowOfTable = alertView.tag;
    if(alertView.tag==rowOfTable)
    {
        if (buttonIndex==0)
        {
            
            GetCardsInfo *cardinfo = [_cardListArr objectAtIndex:rowOfTable];
            
            //NSLog(@"token for credit card %@",cardinfo.token);
            
            [[BrainTreeInstance Instance]DeleteCreditCard:cardinfo Delegate:self];
            [[BrainTreeInstance Instance]removeItembyTableEditRowFromCreditcard:cardinfo];
            _cardListArr=[[NSMutableArray alloc]init];
            _cardListArr=[[BrainTreeInstance Instance]getCardArr];
            [self.tblCreditCard reloadData];
            
            
            //NSLog(@"YES");
        }
        if (buttonIndex==1)
        {
            //NSLog(@"NO");
        }
    }
}


// - (void) performExpand:(UIButton *)paramSender{
// 
// UITableViewCell *ownerCell = (UITableViewCell*)paramSender.superview;
// 
// if (ownerCell != nil){
// 
// /* Now we will retrieve the index path of the cell
// which contains the section and the row of the cell */
//
//NSIndexPath *ownerCellIndexPath =
//[self.myTableView indexPathForCell:ownerCell];
//
////NSLog(@"Accessory in index path is tapped. Index path = %@",
//      ownerCellIndexPath);
//
///* Now we can use these two values to truly determine that
// the accessory button of which cell was the sender of this event:
// 
// OwnerCellIndexPath.section
// OwnerCellIndexPath.row
// 
// */
//
//if (ownerCellIndexPath.section == 0 &&
//    ownerCellIndexPath.row == 1){
//    /* This is the second row in the first section */
//}
//
///* And so forth with the other checks ... */
//
//}
//
//}

@end
