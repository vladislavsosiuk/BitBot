//
//  BRLogsTextViewController.m
//  Bitrise
//
//  Created by Deszip on 18/02/2019.
//  Copyright © 2019 Bitrise. All rights reserved.
//

#import "BRLogsTextViewController.h"

#import "BRLogsWindowController.h"
#import "BRProgressObserver.h"

static void *BRLogsTextViewControllerContext = &BRLogsTextViewControllerContext;

@interface BRLogsTextViewController ()

@property (strong, nonatomic) BRLogsDataSource *logDataSource;
@property (strong, nonatomic) BRLogObserver *logObserver;
@property (strong, nonatomic) NSProgress *loadingProgress;

@property (strong, nonatomic) BRProgressObserver *progressObserver;

@property (weak) IBOutlet NSTabView *logsTabView;
@property (weak) IBOutlet NSTextView *logTextView;

@end

@implementation BRLogsTextViewController

- (void)dealloc {
    [self.progressObserver stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAppearance];
}

#pragma mark - Setup -

- (void)setBuildInfo:(BRBuildInfo *)buildInfo {
    _buildInfo = buildInfo;
    self.view.window.title = [NSString stringWithFormat:@"%@: %@", self.buildInfo.appName, self.buildInfo.branchName];
    [[[self statusView] statusField] setStringValue:[NSString stringWithFormat:@"%@: %@", self.buildInfo.appName, self.buildInfo.branchName]];
    
    // Observer
    self.logObserver = [self.dependencyContainer logObserver];
    __weak typeof(self) weakSelf = self;
    [self.logObserver loadLogsForBuild:self.buildInfo.slug callback:^(BRLogLoadingState state, NSProgress *progress) {
        [weakSelf handleState:state withProgress:progress];
    }];
    
    // Data source
    self.logDataSource = [self.dependencyContainer logDataSource];
    [self.logDataSource bindTextView:self.logTextView];
    [self.logDataSource fetch:self.buildInfo.slug];
}

- (void)handleState:(BRLogLoadingState)state withProgress:(NSProgress *)progress {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (state) {
            case BRLogLoadingStateStarted: [self showProgress]; break;
            case BRLogLoadingStateFinished: [self hideProgress]; break;
            case BRLogLoadingStateInProgress: [[self statusView] addProgress:progress]; break;
                
            case BRLogLoadingStateUndefined: break;
        }
    });
}

#pragma mark - Appearance -

- (void)setupAppearance {
    [self.logTextView setFont:[NSFont fontWithName:@"Menlo" size:12.0]];
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    [style setLineSpacing:200.0];
    [style setLineHeightMultiple:2];
    [self.logTextView setDefaultParagraphStyle:style];
}

- (void)showProgress {
    [[self statusView].progressIndicator setHidden:NO];
}

- (void)hideProgress {
    [[self statusView].progressIndicator setHidden:YES];
}

- (BRLogStatusView *)statusView {
    return [(BRLogsWindowController *)self.view.window.windowController statusView];
}

@end
