#import "UserDetailsController.h"
#import "User.h"
#import "SMART3QAAppDelegate.h"
#import "QuestionsViewController.h"
#import "ImageViewController.h"
#import "WebViewController.h"

@implementation UserDetailsController

- (void)loadUser:(User *)user
{
    app = (SMART3QAAppDelegate*) [[UIApplication sharedApplication] delegate];
    [app downloadDataForUser:[user getUserId]];
    thisuser = user;
    [self setTitle:[thisuser getName]];
    NSArray *general = [[NSArray alloc] initWithObjects:[thisuser getName], [thisuser getAbout], [thisuser getAvatar], nil];
    NSArray *location = [[NSArray alloc] initWithObjects:[thisuser getLocation], nil];
    NSArray *website = [[NSArray alloc] initWithObjects:[thisuser getUrl], nil];
    NSMutableArray *socialnetworks = [NSMutableArray arrayWithCapacity:3];
    if([[NSString stringWithFormat:@"%@", [user getTwitterUrl]] rangeOfString:@"twitter"].location != NSNotFound)
    {
        [socialnetworks addObject:[user getTwitterUrl]];
    }
    if([[NSString stringWithFormat:@"%@", [user getFacebookUrl]] rangeOfString:@"facebook"].location != NSNotFound)
    {
        [socialnetworks addObject:[user getFacebookUrl]];
    }
    if([[NSString stringWithFormat:@"%@", [user getGoogleUrl]] rangeOfString:@"google"].location != NSNotFound)
    {
        [socialnetworks addObject:[user getGoogleUrl]];
    }
    
    userData = [[NSDictionary alloc] initWithObjectsAndKeys:general, @"", location, @"Location", website, @"Website", socialnetworks, @"Social Networks", nil];
    sortedKeys = [userData allKeys];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sortedKeys count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([[userData objectForKey:[sortedKeys objectAtIndex:section]] count] == 0)
        return @"";
    return [sortedKeys objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    if(section == 0)
        return 1;
    NSArray *listData =[userData objectForKey:[sortedKeys objectAtIndex:section]];
    return [listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    NSArray *listData = [userData objectForKey:[sortedKeys objectAtIndex:[indexPath section]]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    NSUInteger row = [indexPath row];
    
    if (cell == nil)
    {
        if([indexPath section] == 0)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
            
            [cell.textLabel setText:[NSString stringWithFormat:@"%@", [thisuser getName]]];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@", [thisuser getAbout]]];
            [cell.imageView setImage:[app resizeImage:[thisuser getAvatar] scaleToSize:CGSizeMake(30, 30)]];
        }
        else if([indexPath section] == 3)
        {
            NSString *content = [NSString stringWithFormat:@"%@", [listData objectAtIndex:row]];
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
            if([content rangeOfString:@"twitter"].location != NSNotFound)
            {
                [cell.imageView setImage:[UIImage imageNamed:@"twitter.png"]];
                [cell.textLabel setText:@"Twitter"];
            }
            else if([content rangeOfString:@"facebook"].location != NSNotFound)
            {
                [cell.imageView setImage:[UIImage imageNamed:@"facebook.png"]];
                [cell.textLabel setText:@"Facebook"];
            }
            else if([content rangeOfString:@"google"].location != NSNotFound)
            {
                [cell.imageView setImage:[UIImage imageNamed:@"google.png"]];
                [cell.textLabel setText:@"Google"];
            }
        }
        else
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
            [cell.textLabel setText:[NSString stringWithFormat:@"%@", [listData objectAtIndex:row]]];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    if(section == 0)
    {
        ImageViewController *imageViewer = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageView"];
        [self.navigationController pushViewController:imageViewer animated:YES];
        [imageViewer setTitle:[thisuser getName]];
        [imageViewer loadImage:[thisuser getAvatar]];
    }
    else if(section == 1)
    {
        WebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];
        [self.navigationController pushViewController:webView animated:YES];
        [webView loadWebpageFromString:[NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", [thisuser getLocation]]];
    }
    else if(section == 2)
    {
        WebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];
        [self.navigationController pushViewController:webView animated:YES];
        [webView loadWebpageFromString:[NSString stringWithFormat:@"%@", [thisuser getUrl]]];
    }
    else if(section == 3)
    {
        NSArray *listData = [userData objectForKey:[sortedKeys objectAtIndex:3]];
        NSString *url = [listData objectAtIndex:row];
        WebViewController *webView = [self.storyboard instantiateViewControllerWithIdentifier:@"WebView"];
        [self.navigationController pushViewController:webView animated:YES];
        [webView loadWebpageFromString:url];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

@end