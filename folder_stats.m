#import <Foundation/Foundation.h>

@interface FolderStats : NSObject
@property (nonatomic, strong) NSString *largestFilePath;
@property (nonatomic, assign) unsigned long long largestFileSize;
@property (nonatomic, strong) NSString *largestFolderPath;
@property (nonatomic, assign) unsigned long long largestFolderSize;
@property (nonatomic, assign) NSUInteger mainFolderFileCount;
@property (nonatomic, assign) NSUInteger totalFileCount;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *folderSizes;
- (void)analyzeFolder:(NSString *)path isMain:(BOOL)isMain;
@end

@implementation FolderStats

- (instancetype)init {
    if (self = [super init]) {
        _largestFileSize = 0;
        _largestFolderSize = 0;
        _mainFolderFileCount = 0;
        _totalFileCount = 0;
        _folderSizes = [NSMutableDictionary dictionary];
    }
    return self;
}

- (unsigned long long)analyzeFolder:(NSString *)path isMain:(BOOL)isMain {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *contents = [fm contentsOfDirectoryAtPath:path error:nil];
    unsigned long long folderSize = 0;
    NSUInteger fileCount = 0;

    for (NSString *item in contents) {
        NSString *fullPath = [path stringByAppendingPathComponent:item];
        BOOL isDir = NO;
        [fm fileExistsAtPath:fullPath isDirectory:&isDir];
        if (isDir) {
            folderSize += [self analyzeFolder:fullPath isMain:NO];
        } else {
            NSDictionary *attrs = [fm attributesOfItemAtPath:fullPath error:nil];
            unsigned long long fileSize = [attrs fileSize];
            folderSize += fileSize;
            fileCount++;
            self.totalFileCount++;
            if (fileSize > self.largestFileSize) {
                self.largestFileSize = fileSize;
                self.largestFilePath = fullPath;
            }
        }
    }
    self.folderSizes[path] = @(folderSize);
    if (folderSize > self.largestFolderSize) {
        self.largestFolderSize = folderSize;
        self.largestFolderPath = path;
    }
    if (isMain) {
        self.mainFolderFileCount = fileCount;
    }
    return folderSize;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *targetPath = (argc > 1) ? [NSString stringWithUTF8String:argv[1]] : [[NSFileManager defaultManager] currentDirectoryPath];
        FolderStats *stats = [[FolderStats alloc] init];
        NSLog(@"Analyzing: %@", targetPath);
        [stats analyzeFolder:targetPath isMain:YES];

        NSLog(@"\nFolder sizes (recursive):");
        for (NSString *folder in stats.folderSizes) {
            NSLog(@"%@: %llu bytes", folder, [stats.folderSizes[folder] unsignedLongLongValue]);
        }

        NSLog(@"\nNumber of files in %@ (not recursive): %lu", targetPath, (unsigned long)stats.mainFolderFileCount);
        NSLog(@"Total number of files (recursive): %lu", (unsigned long)stats.totalFileCount);

        if (stats.largestFilePath) {
            NSLog(@"\nLargest file: %@ (%.2f MB)", stats.largestFilePath, stats.largestFileSize / (1024.0 * 1024.0));
        } else {
            NSLog(@"\nLargest file: None found");
        }

        if (stats.largestFolderPath) {
            NSLog(@"\nLargest folder: %@ (%.2f MB)", stats.largestFolderPath, stats.largestFolderSize / (1024.0 * 1024.0));
        } else {
            NSLog(@"\nLargest folder: None found");
        }
    }
    return 0;
}
