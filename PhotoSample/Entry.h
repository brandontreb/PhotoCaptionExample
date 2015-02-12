//
//  Entry.h
//  PhotoSample
//
//  Created by Brandon Trebitowski on 2/12/15.
//  Copyright (c) 2015 Pixegon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSString * filename;

@end
