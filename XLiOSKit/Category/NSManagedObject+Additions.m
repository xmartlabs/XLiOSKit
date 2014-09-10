//
//  NSManagedObject+Additions.m
//  XLiOSKit
//
// Copyright (c) 2013 Xmartlabs (http://xmartlabs.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSManagedObject+Additions.h"

@implementation NSManagedObject (Additions)


+(instancetype)findFirstByAttribute:(NSString *)attribute withValue:(id)value inContext:(NSManagedObjectContext *)context
{
    NSString * predicateStr = [NSString stringWithFormat:@"%@ = %%@", attribute];
    NSPredicate * searchByAttValue = [NSPredicate predicateWithFormat:predicateStr argumentArray:@[value]];
    NSFetchRequest * fetchRequest = [self fetchRequest];
    fetchRequest.predicate = searchByAttValue;
    fetchRequest.fetchLimit = 1;
    NSArray *result = [context executeFetchRequest:fetchRequest error:nil];
    return [result firstObject];
}

+(instancetype)findFirstWithFetchRequests:(NSFetchRequest *)fetchRequest inContext:(NSManagedObjectContext *)context
{
    fetchRequest.fetchLimit = 1;
    NSArray *result = [context executeFetchRequest:fetchRequest error:nil];
    return [result firstObject];
}

+(instancetype)findFirstByPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest * fetchRequest = [self fetchRequest];
    fetchRequest.fetchLimit = 1;
    fetchRequest.predicate = predicate;
    NSArray *result  = [context executeFetchRequest:fetchRequest error:nil];
    return [result firstObject];
}

+(NSArray *)findAllWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest * fetchRequest = [self fetchRequest];
    fetchRequest.predicate = predicate;
    return [context executeFetchRequest:fetchRequest error:nil];
}


+(NSArray *)findAllWithFetchRequests:(NSFetchRequest *)fetchRequest inContext:(NSManagedObjectContext *)context
{
    return [context executeFetchRequest:fetchRequest error:nil];
}

+(NSUInteger)countWithPredicate:(NSPredicate *)predicate inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest * fetchRequest = [self fetchRequest];
    fetchRequest.predicate = predicate;
    return [context countForFetchRequest:fetchRequest error:nil];
}


+(NSFetchRequest*)fetchRequest
{
    return [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(self)];
}

+(NSEntityDescription*)entityDescriptor:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:NSStringFromClass(self) inManagedObjectContext:context];
}

+(instancetype)insert:(NSManagedObjectContext *)context
{
    return [[NSManagedObject alloc] initWithEntity:[self entityDescriptor:context] insertIntoManagedObjectContext:context];
}

+(instancetype)objectWithID:(NSManagedObjectID *)managedObjectID inContext:(NSManagedObjectContext *)context
{
    NSError *error;
    return [context existingObjectWithID:managedObjectID error:&error];
}

+(NSArray *)allObjectsInContext:(NSManagedObjectContext *)context
{
    NSFetchRequest * fetchRequest = [self fetchRequest];
    return [context executeFetchRequest:fetchRequest error:nil];
}

+(instancetype)virtualInstanceInContext:(NSManagedObjectContext *)context
{
    return [[NSManagedObject alloc] initWithEntity:[self entityDescriptor:context] insertIntoManagedObjectContext:nil];
}

-(void)deleteFrom:(NSManagedObjectContext *)context
{
    [context deleteObject:self];
}


@end
