//
//  PvLogTableViewController.m
//  shinelink
//
//  Created by sky on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "PvLogTableViewController.h"
#import "pvLogTableViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@interface PvLogTableViewController ()
@property(nonatomic,strong)NSMutableArray *SNTextArray;
@property(nonatomic,strong)NSMutableArray *typtTextArray;
@property(nonatomic,strong)NSMutableArray *eventTextArray;
@property(nonatomic,strong)NSMutableArray *LogTextArray;
@property(nonatomic,strong)NSMutableArray *contentTextArray;
@property(nonatomic,strong)NSMutableArray *timeTextArray;

@end

@implementation PvLogTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
}

-(void)initData{
    self.SNTextArray =[NSMutableArray arrayWithObjects:@"第一",@"第二",@"第三",nil];
    self.typtTextArray =[NSMutableArray arrayWithObjects:@"已处理",@"已处理",@"已处理",nil];
     self.eventTextArray =[NSMutableArray arrayWithObjects:@"已处理",@"已处理",@"已处理",nil];
     self.LogTextArray =[NSMutableArray arrayWithObjects:@"已处理",@"已处理",@"已处理",nil];
    self.contentTextArray =[NSMutableArray arrayWithObjects:@"这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图文混排这个是是比较简单的图这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图",
                        @"自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自高",
                        @"这个是比较简单的图文混排", nil];
    self.timeTextArray=[NSMutableArray arrayWithObjects:@"2016.3.3",@"2016.3.3",@"2016.3.3",nil];
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

    
    return _SNTextArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGRect fcRect = [self.contentTextArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 *Width]} context:nil];
    return 85*Height+fcRect.size.height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    pvLogTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[pvLogTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.SNText.text=_SNTextArray[indexPath.row];
      cell.typtText.text=_typtTextArray[indexPath.row];
      cell.eventText.text=_eventTextArray[indexPath.row];
      cell.LogText.text=_LogTextArray[indexPath.row];
    cell.timeLabel.text=self.timeTextArray[indexPath.row];
    cell.contentLabel.text=self.contentTextArray[indexPath.row];
    cell.content=self.contentTextArray[indexPath.row];
   
    
    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 *Width]} context:nil];
    cell.contentLabel.frame =CGRectMake(10*Width, 65*Width, 300*Width, fcRect.size.height);
    cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-100*NOW_SIZE, 65*NOW_SIZE+fcRect.size.height,100*NOW_SIZE, 20*NOW_SIZE );

    
    return cell;
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
