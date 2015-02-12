//
//  ImageCaptionViewController.m
//  PhotoSample
//
//  Created by Brandon Trebitowski on 2/12/15.
//  Copyright (c) 2015 Pixegon. All rights reserved.
//

#import "ImageCaptionViewController.h"
#import "NSMOCManager.h"
#import "Entry.h"

@interface ImageCaptionViewController ()<UITextFieldDelegate>
@property(nonatomic, weak) IBOutlet UIImageView *imageView;
@property(nonatomic, weak) IBOutlet UITextField *textField;
@end

@implementation ImageCaptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                      style:UIBarButtonItemStyleDone
                                                                     target:self
                                                                     action:@selector(savePhotoButtonTapped:)];
    self.navigationItem.rightBarButtonItem = anotherButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.imageView.image = self.image;
}

#pragma mark - Actions

- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return (paths.count)? paths[0] : nil;
}

- (IBAction)savePhotoButtonTapped:(id)sender {
    NSString *path = [[self documentsDirectory] stringByAppendingPathComponent:@"photos"];
    
    // Create photos directory
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:path
                                  withIntermediateDirectories:NO
                                                   attributes:@{}
                                                        error:&error];
        NSLog(@"creating %@ error %@", path, error);
    }
    
    // Generate image name
    NSString *filename = [NSString stringWithFormat:@"%@.png",[self uniqueString]];
    NSString *filePath = [path stringByAppendingPathComponent:filename];
    
    NSLog(@"write to %@", filePath);
    
    // Save to file
    [UIImagePNGRepresentation(self.image) writeToFile:filePath atomically:YES];
    
    // Save model
    NSManagedObjectContext *ctx = [[NSMOCManager sharedManager] managedObjectContext];
    Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry"
                                                 inManagedObjectContext:ctx];
    entry.caption = self.textField.text;
    entry.filename = filename;
    [ctx save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private

- (NSString *) uniqueString {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidString = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    NSString *uniqueFileName = [NSString stringWithFormat:@"%@", (__bridge NSString *)uuidString];
    CFRelease(uuidString);
    return uniqueFileName;
}

#pragma  mark - text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
