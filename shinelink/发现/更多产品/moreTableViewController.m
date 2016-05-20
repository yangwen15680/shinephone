//
//  moreTableViewController.m
//  shinelink
//
//  Created by sky on 16/4/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "moreTableViewController.h"
#import "moreCell.h"
#import "productViewController.h"

@interface moreTableViewController ()
@property (nonatomic, strong) NSMutableArray *name;
@property (nonatomic, strong) NSMutableArray *feature;
@property (nonatomic, strong) NSMutableArray *outline;
@property (nonatomic, strong) NSMutableArray *paramsName;
@property (nonatomic, strong) NSMutableArray *imageName;
@property (nonatomic, strong) NSMutableArray *imageHead;
@end

@implementation moreTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _name=[NSMutableArray array];
    _feature=[NSMutableArray array];
    _outline=[NSMutableArray array];
    _paramsName=[NSMutableArray array];
    _imageName=[NSMutableArray array];
    _imageHead=[NSMutableArray array];
          self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self initData];
}


-(void)initData{
  
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"admin":@"admin"} paramarsSite:@"/newProductAPI.do?op=getProductList" sucessBlock:^(id content) {
        
        NSLog(@"getMoreProductList: %@", content);
        [self showProgressView];
        if (content) {
               [self hideProgressView];
            NSArray *allArray=[NSArray arrayWithArray:content];
            for (int i=0; i<allArray.count; i++) {
                [_name addObject:allArray[i][@"productName"]];
                 [_feature addObject:allArray[i][@"feature"]];
                 [_outline addObject:allArray[i][@"outline"]];
                 [_paramsName addObject:allArray[i][@"technologyParams"]];
                 [_imageName addObject:allArray[i][@"productName"]];
                [self hideProgressView];
                NSString *productImage=[NSString stringWithString:allArray[i][@"productName"]];
               
                if (productImage.length>0) {
                     [self showProgressView];
                    [BaseRequest requestImageWithMethodByGet:HEAD_URL paramars:@{@"imageName":productImage} paramarsSite:@"/newProductAPI.do?op=getProductImage" sucessBlock:^(id content2) {
                        
                        [self hideProgressView];
                          NSLog(@"i===: %d", i);
                        NSLog(@"getProductImage=: %@", content2);
                        if (content2) {
                            
                            [_imageHead addObject:content2];
                            if (_imageHead.count==allArray.count) {
                                     [self.tableView reloadData];
                            }
                                  }
                        
                    } failure:^(NSError *error) {
                        [self hideProgressView];
                    }];
                }
            }
                   }
        
    } failure:^(NSError *error) {
          [self hideProgressView];
    }];

    
}


- (void)showProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideProgressView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _name.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    moreCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[moreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.typeImageView setImage:_imageHead[indexPath.row]];
       cell.name.text=_name[indexPath.row];
  NSString *connentText=[NSString stringWithFormat:@"%@",_outline[indexPath.row]];
  // NSString *connentText=@"专为小型商业系统设计\n内置变压器\n隔离电网\n并提供通用的400V输出\n可直接低压并网";
     cell.connent.text=connentText;
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 108*HEIGHT_SIZE;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    productViewController *page4 = [[productViewController alloc] init];
    page4.name2=_name[indexPath.row];
       page4.feature2=_feature[indexPath.row];
       page4.outline2=_outline[indexPath.row];
       page4.imageHead2=_imageHead[indexPath.row];
    page4.paramImage=_paramsName[indexPath.row];
    page4.imageArray=[NSMutableArray arrayWithObject:_imageHead[indexPath.row]];
    [self.navigationController pushViewController:page4 animated:NO];
}

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
