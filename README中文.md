# 反向传播网络matlab版

---

Matlab中的BP神经网络

---

## 教程
本程序利用Matlab创建和训练BP神经网络。

通过运行**example.m**这个文件里运行本程序。**example.m**里包含以下步骤：
1.训练数据的创建；
2.创建和训练BP网络；
3.创建新数据测试；
4.绘制结果；
5.保存模型参数；
6.加载模型参数。

可以在**example.m**中改变训练集，隐藏层的神经元数，训练epoches数量，batch_size。

**BPNetwork.m**文件里包含了网络结构、前向和反向传播，可以在这个文件里修改学习率。

---


## 工程案例
在**example2.m**这个文件里，增加了一个乡村居住环境适老性评价体系检验的工程案例。从

    '生活客厅'；
    '卧室空间'；
    '餐厨空间'；
    '卫浴空间'；
    '住宅交通空间'；
    '住宅结构安全'；
    '家用设备安全'；
    '路网布置情况'；
    '出行无障碍'；
    '生活基础设施'；
    '医养服务设施'；
    '商业购物设施'；
    '文娱活动设施'；
    '人际情感支撑'；
    '村中活动丰富度'；
    '老年人社会参与度'；
    '政策法律宣传情况'；
    '老年人可支配月收入'；

这18个指标中评估一个乡村居住环境是否适合老年人居住。BP神经网络作为评价检验模型。
