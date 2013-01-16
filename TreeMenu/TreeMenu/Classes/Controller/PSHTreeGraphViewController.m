//
//  PSHTreeGraphViewController.m
//  PSHTreeGraph - Example 1
//
//  Created by Ed Preston on 7/25/10.
//  Copyright Preston Software 2010. All rights reserved.
//


#import "PSHTreeGraphViewController.h"

#import "PSBaseTreeGraphView.h"
#import "MyLeafView.h"

#import "ObjCClassWrapper.h"


#pragma mark - Internal Interface

@interface PSHTreeGraphViewController () 
{

@private
	PSBaseTreeGraphView *treeGraphView_;
	MenuItem *rootClassName_;
}

@end


@implementation PSHTreeGraphViewController


#pragma mark - Property Accessors

@synthesize treeGraphView = treeGraphView_;
@synthesize rootClassName = rootClassName_;
@synthesize rootItem;

- (void) setRootClassName:(MenuItem *) menuItem
{
    {
        treeGraphView_.treeGraphOrientation  = PSTreeGraphOrientationStyleVertical;
        treeGraphView_.connectingLineStyle = PSTreeGraphConnectingLineStyleDirect;
        treeGraphView_.connectingLineColor = [UIColor blackColor];
        treeGraphView_.connectingLineWidth = 0.5f;
        treeGraphView_.backgroundColor = [UIColor whiteColor];
        treeGraphView_.siblingSpacing = 15.0f;
        treeGraphView_.resizesToFillEnclosingScrollView = YES;
        // Get an ObjCClassWrapper for the named Objective-C Class, and set it as the TreeGraph's root.
        //[treeGraphView_ setModelRoot:[ObjCClassWrapper wrapperForClassNamed:rootClassName_]];
        [treeGraphView_ setModelRoot: menuItem];
    }
}


#pragma mark - View Creation and Initializer

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad
{
    [super viewDidLoad];

    self.rootItem = [[DataProvider sharedInstance] getRootMenuItem];
    
	// Set the delegate to self.
	[self.treeGraphView setDelegate:self];

	// Specify a .nib file for the TreeGraph to load each time it needs to create a new node view.
    [self.treeGraphView setNodeViewNibName:@"ObjCClassTreeNodeView"];

    // Specify a starting root class to inspect on launch.
    
    //[self setRootClassName:@"UIControl"];
    [self setRootClassName: self.rootItem];
    
    // The system includes some other abstract base classes that are interesting:

}

// Override to allow orientations other than the default portrait orientation.
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
                                         duration:(NSTimeInterval)duration
{
	// Keep the view in sync
	[self.treeGraphView parentClipViewDidResize:nil];
}



#pragma mark - TreeGraph Delegate

-(void) configureNodeView:(UIView *)nodeView
            withModelNode:(id <PSTreeGraphModelNode> )modelNode
{
    NSParameterAssert(nodeView != nil);
    NSParameterAssert(modelNode != nil);

	// NOT FLEXIBLE: treat it like a model node instead of the interface.
	MenuItem *objectWrapper = (MenuItem *)modelNode;
	MyLeafView *leafView = (MyLeafView *)nodeView;

	// button
	if ( [[objectWrapper childModelNodes] count] == 0 ) {
		[leafView.expandButton setHidden:YES];
	}

	// labels
	leafView.titleLabel.text	= [objectWrapper getTitle];
	leafView.detailLabel.text	= [objectWrapper getTitle];

}


#pragma mark - Resouce Management

- (void) didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void) dealloc
{
	[rootClassName_ release];
    [super dealloc];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
