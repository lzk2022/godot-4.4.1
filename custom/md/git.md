# 完整示例流程：

```shell
git checkout main
git pull origin main
git merge h
# 如果有冲突，解决冲突后：
git add .
git commit
git push origin main

# 创建并立即切换到新分支
git checkout -b 分支名
```

1、需要排序的例子
#include "2.h"
#include "1.h"

排序
#include "1.h"
#include "2.h"

2、不需要排序的例子
#include <2.h>
#include <1.h>