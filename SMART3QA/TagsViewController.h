#import <UIKit/UIKit.h>
#import "SMART3QAAppDelegate.h"

@interface TagsViewController : UITableViewController
<UITableViewDelegate, UITableViewDataSource>
{
    SMART3QAAppDelegate* app;
}

@end
