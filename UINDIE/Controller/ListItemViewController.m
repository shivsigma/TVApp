//
//  ListItemViewController.m
//  UINDIE.xcodeproj1
//
//  Created by Nimit Bagadiya on 27/10/17.
//
//

#import "ListItemViewController.h"

#import "CollectionViewCell.h"

#import "ActionSheetStringPicker.h"

#import "Request.h"

#import "ActivityIndicator.h"

#import "Cart.h"

@interface ListItemViewController ()<RequestDelegate>{
    NSMutableArray *arrCity,*arrGen,*arrProducts;
}

@end

@implementation ListItemViewController

+(ListItemViewController *)initViewController:(id<ListViewCallBackDelegate>)del{
    ListItemViewController * controller = [[ListItemViewController alloc]initWithNibName:@"ListItemViewController" bundle:nil];
    controller.dd = del;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    arrCity = [NSMutableArray new];
    arrGen = [NSMutableArray new];
    
    arrCity = [ServiceList Instance].contryArray;
    arrGen = [ServiceList Instance].genericArray;
    
    
    arrProducts = [NSMutableArray new];
    arrProducts = [ServiceList Instance].products;
    [self.navigationController setNavigationBarHidden:YES];
    
    _lblCart.titleLabel.text = [NSString stringWithFormat:@"%d",(int)[[Cart Instance].productsInCart count]];
    
    self.tblView.userInteractionEnabled = YES;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    //    [self getcity];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(void)backActionClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    ListItemTableViewCell *cell = (ListItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListItemTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NewProductInfo * info = [arrProducts objectAtIndex:indexPath.row];
    [cell setInfo:info];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     NewProductInfo * info = [arrProducts objectAtIndex:indexPath.row];
    if (_dd && [_dd respondsToSelector:@selector(ListViewDelegate:)]) {
        [_dd ListViewDelegate:info];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark -- UICollectionView Delegate and DataSource
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CollectionViewCell *cellProduct = [cv dequeueReusableCellWithReuseIdentifier:@"CellidentifierProduct" forIndexPath:indexPath];
//    
//    NewProductInfo * info = [arrProducts objectAtIndex:indexPath.row];
//    
//    [cellProduct setDataProductInfo:info];
//    
//    return cellProduct;
//    
//}
//
//
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return arrProducts.count;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((collectionView.frame.size.width/4) - 7.5,(collectionView.frame.size.width/4));
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
////}


#pragma mark -- UISearchbar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product_title CONTAINS[cd] %@", searchText];
        arrProducts= [[NSMutableArray alloc]init];
        arrProducts = [NSMutableArray arrayWithArray:[[[ServiceList Instance]products] filteredArrayUsingPredicate:predicate]];
        
    }else{
        arrProducts = [[NSMutableArray alloc]init];
        arrProducts = [[ServiceList Instance]products];
    }
    [_tblView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.view endEditing:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    arrProducts = [[NSMutableArray alloc]init];
    arrProducts = [[ServiceList Instance]products];
    
    [self.view endEditing:YES];
}


- (IBAction)actionOpenPickerCity:(id)sender{
    NSMutableArray *arrCityData = [NSMutableArray new];
    [arrCityData addObject:@"All"];
    for (ContryInfo * info in arrCity) {
        [arrCityData addObject:info.countryname];
    }
    
    if (arrCityData.count > 0) {
        [ActionSheetStringPicker showPickerWithTitle:@"Select City" rows:arrCityData initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
            [_btnCountry setTitle:selectedValue forState:UIControlStateNormal];
            arrProducts = [[[ServiceList Instance]getAllProductsByCity:(NSString*)selectedValue Array:arrProducts]mutableCopy];
            [_tblView reloadData];
            
        } cancelBlock:^(ActionSheetStringPicker *picker) {
            
        } origin:self.view];
    }
    
}


- (IBAction)actionOpenPickerOther:(id)sender{
    
    NSMutableArray *arrGenericData = [NSMutableArray new];
    [arrGenericData addObject:@"All"];
    for (GenericInfo * info in arrGen) {
        [arrGenericData addObject:info.generename];
    }
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select Genric" rows:arrGenericData initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        [_btnOther setTitle:selectedValue forState:UIControlStateNormal];
        arrProducts = [[[ServiceList Instance]getAllProductsByGeneric:(NSString*)selectedValue Array:arrProducts]mutableCopy];
        //[[[ServiceList Instance]getAllProductsByGeneric:(NSString*)selectedValue]mutableCopy];
        [_tblView reloadData];
        
    } cancelBlock:^(ActionSheetStringPicker *picker) {
        
    } origin:self.view];
}

- (void)filterData{
    //    [arrProductFilter removeAllObjects];
    //    if ([[_btnCountry currentTitle] isEqualToString:@"All"] && [[_btnOther currentTitle] isEqualToString:@"All"]) {
    //        arrProductFilter = [arrProduction mutableCopy];
    //    }else{
    //        if ([[_btnCountry currentTitle] isEqualToString:@"All"]) {
    //            [arrProductFilter removeAllObjects];
    //            for (NSDictionary *dict in arrProduction) {
    //                if ([[dict objectForKey:@"generename"] isEqualToString:_btnOther.titleLabel.text]) {
    //                    [arrProductFilter addObject:dict];
    //                }
    //            }
    //        }else if ([[_btnOther currentTitle] isEqualToString:@"All"]) {
    //            for (NSDictionary *dict in arrProduction) {
    //                if ([[dict objectForKey:@"countryname"] isEqualToString:[_btnCountry currentTitle]]) {
    //                    [arrProductFilter addObject:dict];
    //                }
    //            }
    //        }else{
    //            for (NSDictionary *dict in arrProduction) {
    //                if ([[dict objectForKey:@"countryname"] isEqualToString:[_btnCountry currentTitle]] && [[dict objectForKey:@"generename"] isEqualToString:[_btnOther currentTitle]]) {
    //                    [arrProductFilter addObject:dict];
    //
    //                }
    //
    //        }
    //    }
    //
    //    if (_searchBar.text.length != 0) {
    //        NSArray *arr = [arrProductFilter mutableCopy];
    //        for (NSDictionary *dict in arr) {
    //            if ([[[dict objectForKey:@"product_title"] uppercaseString] containsString:[_searchBar.text uppercaseString]]) {
    //
    //            }else{
    //                [arrProductFilter removeObject:dict];
    //            }
    //        }
    //    }
    //    
    //    
    //    [_collectionview reloadData];
    //}
}


-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}



@end
