//
//  extensionListTableViewController.m
//  shinelink
//
//  Created by sky on 16/5/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "extensionListTableViewController.h"
#import "ExtensionTwoViewController.h"

@interface extensionListTableViewController ()
@property(nonatomic,strong)NSMutableArray *idArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSString *languageValue;
@end

@implementation extensionListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self netCommon];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //  self.dataArray =[NSMutableArray arrayWithObjects:@"第一111",@"第二222",@"第三333",nil];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
   
}

-(void)netCommon{
    
    _idArray=[NSMutableArray array];
    _titleArray=[NSMutableArray array];
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
   
    if ([currentLanguage isEqualToString:@"zh-Hans-CN"]) {
        _languageValue=@"0";
    }if ([currentLanguage isEqualToString:@"en-CN"]) {
        _languageValue=@"1";
    }else{
    _languageValue=@"3";
    }
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"language":_languageValue} paramarsSite:@"/newExtensionAPI.do?op=getExtensionList" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getExtensionList=: %@", content);
        
        if(content){
            NSMutableArray *allDic=[NSMutableArray arrayWithArray:content];
            for (int i=0; i<allDic.count; i++) {
                [_idArray addObject:allDic[i][@"id"]];
                [_titleArray addObject:allDic[i][@"title"]];
            }
            
            [self.tableView reloadData];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _idArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // static NSString *cellDentifier=@"cellDentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=_titleArray[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize: 14*HEIGHT_SIZE];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50*HEIGHT_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExtensionTwoViewController *go=[[ExtensionTwoViewController alloc]init];
    go.name2=_titleArray[indexPath.row];
    go.idString=_idArray[indexPath.row];
    
    [self.navigationController pushViewController:go animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
