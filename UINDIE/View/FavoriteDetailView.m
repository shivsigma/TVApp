//
//  FavoriteDetailView.m
//  UINDIE
//
//  Created by HARDIK TALAVIYA on 11/22/15.
//  Copyright © 2015 HARDIK TALAVIYA. All rights reserved.
//

#import "FavoriteDetailView.h"
#import "FavDetailCellTableViewCell.h"
@implementation FavoriteDetailView

+(id)initViewFavouriteInfo:(FavouriteInfo *)fv{
    FavoriteDetailView * categoryView;
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        categoryView = [[[NSBundle mainBundle] loadNibNamed:@"FavoriteDetailView_iPad" owner:nil options:nil] objectAtIndex:0];
    }
    else{
        categoryView = [[[NSBundle mainBundle] loadNibNamed:@"FavoriteDetailView" owner:nil options:nil] objectAtIndex:0];
    }
    
    categoryView.info = fv;
    [categoryView viewData];
    return categoryView;
}

- (void) viewData{
    
    _arr = [[NSMutableArray alloc]init];
    
    [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
    [[ServiceList Instance]loadMayLikeListByID:_info.video_id Delegate:self];
   
    
    _lblTitle.text = _info.video_title;
    _lblProfilename.text = [NSString stringWithFormat:@"by:%@",_info.provider];
    _lblDescription.text = _info.description;
    _imgView.url = [NSURL URLWithString:_info.video_img];

}

-(void)ModelListLoadedSuccessfullyTag:(NSString *)tag{
    [[ActivityIndicator currentIndicator]displayCompleted];
    _arr = [ServiceList Instance].linkArr;
    [_tblView reloadData];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    FavDetailCellTableViewCell *cell = [_tblView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        // NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartTableViewCell" owner:self options:nil];
        NSArray *topLevelObjects;
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FavDetailCellTableViewCell" owner:self options:nil];
        }
        else{
            topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"FavDetailCellTableViewCell" owner:self options:nil];
        }
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell =  (FavDetailCellTableViewCell *) currentObject;
                break;
            }
        }
    }
    LinkInfo * info = [_arr objectAtIndex:indexPath.row];
    cell.lblTitle.text = info.image_title;
    cell.img.url = [NSURL URLWithString:info.image_url];
    
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LinkInfo * info = [_arr objectAtIndex:indexPath.row];
    if (info.image_link && info.image_link.length> 0) {
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:info.image_link]];
    }
    
}
@end
