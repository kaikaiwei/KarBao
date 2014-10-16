//
//  CardsViewController.m
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "CardsViewController.h"
#import "CardCell.h"

@implementation CardsViewController



- (void) viewDidLoad
{
    [super viewDidLoad];
    
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - UITableViewDelegate







#pragma mark - UITableView DataSourceDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CARDCELL"];
    
    cell.nameLabel.text = [NSString stringWithFormat:@"Card:至尊（%ld）", (long)indexPath.row];
    cell.cardLabel.text = [NSString stringWithFormat:@"Num:8888 5288 5788 588%ld", (long)indexPath.row];
    
    return cell;
}

@end
