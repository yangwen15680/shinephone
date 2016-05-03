//
//  controlCNJTable.m
//  shinelink
//
//  Created by sky on 16/4/19.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "controlCNJTable.h"
#import "ControlCNJ.h"

@interface controlCNJTable ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation controlCNJTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UIImage *bgImage = IMAGE(@"bg4.png");
    //  self.view.layer.contents = (id)bgImage.CGImage;
    
    self.dataArray =[NSMutableArray arrayWithObjects:root_CNJ_kaiguan,root_CNJ_SOC,root_CNJ_shijian,root_CNJ_fangdian_kaiguan,root_CNJ_fangdian_shijian,root_CNJ_SP,nil];
    
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
    
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // static NSString *cellDentifier=@"cellDentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50*NOW_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   ControlCNJ  *go=[[ControlCNJ alloc]init];
    if (indexPath.row==0) {
        go.type=@"0";
    }else if (indexPath.row==1){
        go.type=@"1";
    }else if (indexPath.row==2){
        go.type=@"2";
    }else if (indexPath.row==3){
        go.type=@"3";
    }else if (indexPath.row==4){
        go.type=@"4";
    }else if (indexPath.row==5){
        go.type=@"5";
    }
    go.CnjSN=_CnjSn;
    [self.navigationController pushViewController:go animated:YES];
    
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
