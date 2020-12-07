需要被换出的页的特征是什么？
extended clock算法可以看成一种改进的LRU算法，它避免了LRU中在访问页或找替换页时必须对所有页进行扫描。因此被换出的页基本满足最久未被访问的特征。
在ucore中如何判断具有这样特征的页？
指针扫描到的第一个dirty bit为0的页。
何时进行换入和换出操作？
当需要调入的页不在页表中，且页表已满时，进行换入换出操作。

