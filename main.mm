#import "gen/test-swift.h"
#import "cpp.h"
#import "main.h"
#include <stdio.h>

@implementation Foo
- (void)Bar {
  printf("bar\n");
}
@end

int main(int argc, const char** argv) {
  Test* instance = [Test new];
  CppClass instance2;
  [instance Wow];
  instance2.Lol();
  return 0;
}
