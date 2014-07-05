//
//  PFHistoryViewController.m
//  DemoCoffee
//
//  Created by Pariwat on 6/17/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import "PFHistoryViewController.h"

@interface PFHistoryViewController ()

@end

@implementation PFHistoryViewController

BOOL refreshDataHistory;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"History";
    
    self.conditionnomember.text = self.detailhistory;
    
    CGRect frame = self.conditionnomember.frame;
    frame.size = [self.conditionnomember sizeOfMultiLineLabel];
    [self.conditionnomember sizeOfMultiLineLabel];
    [self.conditionnomember setFrame:frame];
    int lines = self.conditionnomember.frame.size.height/15;
    self.conditionnomember.numberOfLines = lines;
    UILabel *descText = [[UILabel alloc] initWithFrame:frame];
    descText.text = self.conditionnomember.text;
    descText.numberOfLines = lines;
    [descText setFont:[UIFont systemFontOfSize:15]];
    descText.textColor = [UIColor colorWithRed:104.0/255.0 green:71.0/255.0 blue:56.0/255.0 alpha:1.0];
    self.conditionnomember.alpha = 0;
    [self.headerView addSubview:descText];
    
    self.historyView.frame = CGRectMake(self.historyView.frame.origin.x, self.headerView.frame.size.height+descText.frame.size.height-60, self.historyView.frame.size.width, self.historyView.frame.size.height);
    
    self.headerView.frame = CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height+descText.frame.size.height-15);
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.Demoapi = [[DCManager alloc] init];
    self.Demoapi.delegate = self;
    [self.Demoapi history];
    
    self.arrObj = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)DCManager:(id)sender getHistoryResponse:(NSDictionary *)response {
    NSLog(@"Member History %@",response);
    
    if (!refreshDataHistory) {
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    } else {
        [self.arrObj removeAllObjects];
        for (int i=0; i<[[response objectForKey:@"data"] count]; ++i) {
            [self.arrObj addObject:[[response objectForKey:@"data"] objectAtIndex:i]];
        }
    }
    
    [self reloadData:YES];
}

- (void)DCManager:(id)sender getHistoryErrorResponse:(NSString *)errorResponse {
    NSLog(@"%@",errorResponse);
}

- (void)reloadData:(BOOL)animated
{
    [self.tableView reloadData];
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width,self.tableView.contentSize.height);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrObj count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFHistoryCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PFHistoryCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    int check;
    check = indexPath.row % 2;
    
    if (check == 0) {
        cell.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    } else {
        cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
    
    NSString *history = [[NSString alloc] initWithFormat:@"%@%@%@%@%@",[[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"created_at"] objectForKey:@"date"],@" : ",[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"title"],@" : ",[[self.arrObj objectAtIndex:indexPath.row] objectForKey:@"description"]];
    cell.detail.text = history;
    
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // 'Back' button was pressed.  We know this is true because self is no longer
        // in the navigation stack.
        if([self.delegate respondsToSelector:@selector(PFHistoryViewControllerBack)]){
            [self.delegate PFHistoryViewControllerBack];
        }
    }
    
}

@end
