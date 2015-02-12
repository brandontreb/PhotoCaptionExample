//
//  NSMOCManager.h
//
//  Created by Brandon Trebitowski
//  Copyright (c) 2013 Pixegon Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSMOCManager : NSObject
@property(nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property(nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (id) sharedManager;
- (void) save:(NSError **) error;
- (NSManagedObjectContext *) newChildContext;
- (NSString *)applicationDocumentsDirectory;
- (void) clearStores;
@end
