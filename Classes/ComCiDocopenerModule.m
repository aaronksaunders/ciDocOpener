/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComCiDocOpenerModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiApp.h"
#import "TiViewProxy.h"

@implementation ComCiDocOpenerModule
@synthesize controller;

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"648c826b-db4b-4865-8a75-1d085e99434c";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.ci.DocOpener";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(void)useDocumentOpener:(id)args
{
	ENSURE_UI_THREAD_1_ARG(args);
	ENSURE_SINGLE_ARG_OR_NIL(args,NSDictionary);
	NSString *filePath = [TiUtils stringValue:@"path" properties:args ];
    BOOL isValid = NO;
	
	TiViewProxy* view_proxy_view = [args objectForKey:@"view"];
	TiViewProxy* view_proxy_btn = [args objectForKey:@"button"];
	NSLog(@"filePath %@", filePath);
	NSLog(@"view_proxy_view %@", view_proxy_view);
	NSLog(@"view_proxy_btn %@", view_proxy_btn);
    
    filePath = [[NSBundle mainBundle] pathForResource:@"dcps012" ofType:@"pdf"];
		
	if (controller == nil) {
		controller =  [[UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]] retain];
        controller.delegate = self;
	}
    
    
    [controller presentPreviewAnimated:YES];
    return;
    
	if (NULL_IF_NIL(view_proxy_view) == NULL)
	{
		NSLog(@"I have a button", nil);
		UIBarButtonItem *item = [view_proxy_btn barButtonItem];
		isValid = [controller presentOptionsMenuFromBarButtonItem:item animated:YES];
	} else {
		NSLog(@"I have a window", nil);
		CGRect rect = [TiUtils rectValue:args];
		//NSLog(@"rect %@", [rect describe]);	
        isValid = [controller presentOpenInMenuFromRect:CGRectMake(200.0f, 200.0f, 200.0f, 200.0f) inView:[[[TiApp app] controller] view]
									   animated:YES];
	}
    NSLog(@"Is valid %d", isValid);
    return;
}

#pragma mark Delegates

//===================================================================
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
	return [[TiApp app] controller];
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
	return [[TiApp app] controller].view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
	return [[TiApp app] controller].view.frame;
}


/*
 - (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
 {
     UIViewController *ac = [[TiApp app] controller];
     return ac.view;
 }

- (void)documentInteractionControllerWillBeginPreview:(UIDocumentInteractionController *)controller
{
	if ([self _hasListeners:@"load"])
	{
		[self fireEvent:@"load" withObject:nil];
	}
}

- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)controller
{
	if ([self _hasListeners:@"unload"])
	{
		[self fireEvent:@"unload" withObject:nil];
	}
}


- (void)documentInteractionControllerWillPresentOpenInMenu:(UIDocumentInteractionController *)controller
{
	if ([self _hasListeners:@"menu"])
	{
		NSDictionary *event = [NSDictionary dictionaryWithObject:@"open" forKey:@"type"];
		[self fireEvent:@"menu" withObject:event];
	}
}

- (void)documentInteractionControllerWillPresentOptionsMenu:(UIDocumentInteractionController *)controller
{
	if ([self _hasListeners:@"menu"])
	{
		NSDictionary *event = [NSDictionary dictionaryWithObject:@"options" forKey:@"type"];
		[self fireEvent:@"menu" withObject:event];
	}
}
*/
- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller canPerformAction:(SEL)action {
    return YES;
}
- (BOOL)documentInteractionController:(UIDocumentInteractionController *)controller performAction:(SEL)action {
    return YES;
}



@end
