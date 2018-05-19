//
//  ViewController.m
//  HeroApps-Test
//
//  Created by Asher Elgar on 18/05/2018.
//  Copyright © 2018 Asher Elgar. All rights reserved.
//

#import "HeroViewController.h"
#import "Hero.h"
#import "MoviedPlayedTableViewCell.h"
#import "HeroFullScreenViewController.h"
#import "HeroObject.h"
#import "AppDelegate.h"


@import CoreData;




@interface HeroViewController ()

@property (strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;
@property (strong, nonatomic) NSManagedObjectModel * managedObjectModel;


@property(strong, nonatomic) NSMutableArray<Hero *> *heroes;



@property (strong, nonatomic) NSArray * heroeData;

@end

@implementation HeroViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


@synthesize herodb;


NSString *cellIdentifier = @"heroCell";

NSDictionary *moviePlayedArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([self connectedToInternet] == NO)
    {
        [self loadLibrary];
    }
    else
    {
        [self getHeroData];
    }
    
    [self.heroImage.layer setCornerRadius:self.heroImage.frame.size.width/2];
    [self.heroImage.layer setMasksToBounds:YES];
  
   


  
    self.heroImage.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(imageTapped:)];
    
    [self.heroImage addGestureRecognizer:tapGesture];

}

-(void)imageTapped:(UITapGestureRecognizer *)tap{
    [self performSegueWithIdentifier:@"masterToImage" sender:self.heroImage];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if([self connectedToInternet] == NO)
    {
        [self loadLibrary];
    }
    else
    {
        [self getHeroData];
    }
    
}


//MARK: Get data
NSDictionary *dict;
Hero *hero1;
-(void)getHeroData {
    
    NSURL *url = [NSURL URLWithString:@"http://heroapps.co.il/employee-tests/ios/logan.json"];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSError *err;
        NSDictionary *actorJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:NSJSONReadingAllowFragments error:&err];
        //NSLog(@"Finished get data", actorJSON);
        
        if (err){
            NSLog(@"Failed to read from Json: %@", err);
            [self loadLibrary];
            return;
        }
        
        self.heroes = NSMutableArray.new;
        
        dict = [actorJSON valueForKey:@"data"];
       
        //NSLog(@"value = %@",[dict valueForKey:@"name"]);
        
        NSString *titleName = [dict valueForKey:@"name"];
        NSString *name = [dict valueForKey:@"nickname"];
        NSNumber *year = [dict valueForKey:@"dateOfBirth"];
        NSArray *powers = [dict valueForKey:@"powers"];
        NSString *originalName = [dict valueForKey:@"actorName"];
        NSString *imageURL = [dict valueForKey:@"image"];
        NSDictionary *moviePlayedArry1 = [dict valueForKey:@"movies"];
        
        moviePlayedArray = moviePlayedArry1;
        
        Hero *hero = Hero.new;
        hero.titleName = titleName;
        hero.nickName = name;
        hero.yearBorn = year.description;
        NSString * result = [[powers valueForKey:@"description"] componentsJoinedByString:@", "];
        hero.powers = result;
        hero.originalActor = originalName;
        hero.imageURL = imageURL;
        hero.moviesPlayed = moviePlayedArry1;
        
        //NSLog(@"moviePlayed: %@", moviePlayedArry1);
        
        
        [self.heroes addObject:hero];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getAndSetImageFromUrl];
            self.navigationItem.title = self.heroes[0].titleName;
            
            self.nickName.text = self.heroes[0].nickName;
            self.powers.text = self.heroes[0].powers;
            self.yearBorn.text = self.heroes[0].yearBorn;
            self.originalActor.text = self.heroes[0].originalActor;
            self.nickName.text = self.heroes[0].nickName;
            
            self.navigationItem.title = self.heroes[0].titleName;
            
            [self.tableView reloadData];
            
        });
    }] resume];
    //[self importLibrary];
}

//MARK: Tableview implement
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return moviePlayedArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoviedPlayedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (moviePlayedArray.count <= 0){
        cell.movieName.text = [_heroes valueForKey:@"name"][indexPath.row];
        
        cell.yearMovie.text = [_heroes valueForKey:@"year"][indexPath.row];
    }else{
    
    cell.movieName.text = [moviePlayedArray valueForKey:@"name"][indexPath.row];

    cell.yearMovie.text = [NSString stringWithFormat:@"%@", [moviePlayedArray valueForKey:@"year"][indexPath.row]];
    }
    return cell;
}

NSMutableArray *shownIndexes;


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    shownIndexes = [[NSMutableArray alloc]init];
    
    if (![shownIndexes containsObject:indexPath]) {
        [shownIndexes addObject:indexPath];
        
        cell.transform = CGAffineTransformMakeTranslation(0, 50);
        cell.layer.shadowColor = [[UIColor blackColor]CGColor];
        cell.layer.shadowOffset = CGSizeMake(10, 10);
        cell.alpha = 0;
        
        [UIView animateWithDuration:0.9 delay:0.1 options:UIViewAnimationOptionCurveLinear animations:^{
            
            cell.transform = CGAffineTransformMakeTranslation(0.f, 0);
            cell.alpha = 1;
            cell.layer.shadowOffset = CGSizeMake(0, 0);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView.frame.size.height/4 > 50){
        return self.tableView.frame.size.height/4;
    }
    return 50;
}

//    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//        // The header for the section is the region name -- get this from the region at the section index.
//
//        return @"Movies Played";
//    }



//MARK: Getting the Image

-(void) getAndSetImageFromUrl {
    //UIImage* memberPhoto = [UIImage imageNamed:@"theWolverine.png"];
    NSURL *url = [NSURL URLWithString:self.heroes[0].imageURL];
    [self loadImage:url];
}

- (void)loadImage:(NSURL *)imageURL
{
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                        initWithTarget:self
                                        selector:@selector(requestRemoteImage:)
                                        object:imageURL];
    [queue addOperation:operation];
}

- (void)requestRemoteImage:(NSURL *)imageURL
{
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    [self performSelectorOnMainThread:@selector(placeImageInUI:) withObject:image waitUntilDone:YES];
}

- (void)placeImageInUI:(UIImage *)image
{
    [self.heroImage setImage:image];
    [self importLibrary];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    HeroFullScreenViewController *destination =(HeroFullScreenViewController*)segue.destinationViewController;
    
    destination.image = self.heroImage.image;
}



//MARK:LocalData


-(void) loadLibrary
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HeroObj"];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        NSLog(@"Error fetching HeroObj objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    for (NSManagedObject *obj in results) {
        
        NSArray *keys = [[[obj entity] attributesByName] allKeys];
        NSDictionary *dictionary = [obj dictionaryWithValuesForKeys:keys];
        
    }
    if (results.count > 0) {
        HeroObject *hero = (HeroObject *)[results objectAtIndex:0];
        
        NSLog(@"HHH - %@", hero);
        

        self.nickName.text = [hero valueForKey:@"nickName"];
        self.yearBorn.text = [hero valueForKey:@"yearBorn"];
        self.powers.text = [hero valueForKey:@"powers"];
        self.originalActor.text = [hero valueForKey:@"originalActor"];
        self.navigationItem.title = [hero valueForKey:@"titleName"];
        NSString *ss = [hero valueForKey:@"moviesPlayed"];
        [moviePlayedArray setValue:ss forKeyPath:@"name"];
        
        //moviePlayedArray = hero.moviesPlayed;
        
        self.heroImage.image = [UIImage imageWithData:hero.image];
        //[self.heroes addObject:hero];
        
        //NSLog(@"BBB - %@", hero.moviesPlayed);
        [self.tableView reloadData];
    }
    if (error != nil) {
        
    }
    else {
        
    }
    
}



-(void) importLibrary
{
    HeroObject *newHero  = [NSEntityDescription insertNewObjectForEntityForName:@"HeroObj" inManagedObjectContext:self.managedObjectContext];
    //[newHero setValuesForKeysWithDictionary:dict];
    newHero.nickName = self.nickName.text;
    newHero.yearBorn = self.yearBorn.text;
    newHero.titleName =  self.navigationItem.title;
    newHero.originalActor = self.originalActor.text ;
    newHero.powers = self.powers.text ;
    newHero.moviesPlayedString = moviePlayedArray.description;
    NSData *imageData = UIImagePNGRepresentation(self.heroImage.image);
    newHero.image = imageData;
    [self.heroes addObject:newHero];
    NSLog(@"YYY: %@", newHero);
    
    NSError * error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Error: %@", error);
    }
}

-(NSManagedObjectContext *) managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    if (self.persistentStoreCoordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
    }
    return _managedObjectContext;
}

-(NSPersistentStoreCoordinator *) persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSURL * documentDirectory = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL * storeFile = [documentDirectory URLByAppendingPathComponent:@"hero.sqlite"];
    
    NSError * error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeFile options:nil error:&error])
    {
        NSLog(@"Error: %@", error);
    }
    return _persistentStoreCoordinator;
}


-(NSManagedObjectModel *) managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL * modelURL = [[NSBundle mainBundle] URLForResource:@"HeroApps_Test" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}



- (BOOL)connectedToInternet
{
    NSString *urlString = @"http://www.google.com/";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"HEAD"];
    NSHTTPURLResponse *response;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error: NULL];
    
    return ([response statusCode] == 200) ? YES : NO;
}

@end

