# 可视化脚本使用指南

## 1. 使用准备

### MATLAB：

- 使用压缩包内置的`Homer3-1.71.1`工具箱，如果使用原始的工具箱，需要进行如下更改：

  - 在路径`Homer3-1.71.1\FuncRegistry\UserFunctions`下，寻找脚本文件`hmrR_BandpassFilt.m`，在第`61`行前加入：

  ```matlab
  y(isinf(y))=0;
  ```

  - 在路径`Homer3-1.71.1\FuncRegistry\UserFunctions`下，寻找脚本文件`GetExtinctions.m`，将第`126`行改为：

  ```matlab
  WhichSpectrum=1;
  ```

- `Homer3`工具箱在使用时可能出现闪退，原因不明，重启MATLAB即可解决。

- 载入压缩包内置的`ribboncoloredZ`工具箱。

- 载入压缩包内置的`BrainNetViewer`工具箱。

- 本脚本所使用的MATLAB版本为**R2022b**。

### Python：

- 由于`MNE-Python`库所对应的实验流程和N4000仪器所得的数据略有不符，导致库中有若干可视化功能无法使用，故仍使用MATLAB为主体的脚本进行可视化，并在其中调用部分可使用的Python语句。
- 在cmd中使用指令：

```
pip install mne
```

安装`MNE-Python`库，同时，经测试，该库需要以下库的支持：`numpy`(version 1.23.3), `matplotlib`(version 3.7.0), `PyQt5`(version 5.15.9), `darkdetect`(version 0.8.0), `pyvistaqt`(version 0.9.1), `ipywidgets`(version 8.0.4), `h5py` (version 3.8.0), `QDarkStyle` (version 3.1)。

- 完成MNE-Python库的安装后，需对程序进行部分更改，在Python的`Lib`文件夹中寻找路径`~\site-packages\mne\io\snirf`，在其中打开Python源文件`_snirf.py`，从第275行起，将：

```python
length_unit = _get_metadata_str(dat, "LengthUnit")
length_scaling = _get_lengthunit_scaling(length_unit)
```

修正为：

```python
length_unit = _get_metadata_str(dat, "LengthUnit")
if length_unit in {'m','cm','mm'}:
    length_scaling = _get_lengthunit_scaling(length_unit)
else:
    length_unit='mm'
    length_scaling = _get_lengthunit_scaling(length_unit)
```

- 在`C:\Users\<Users name>\`路径下新建文件夹，并命名为`mne_data`，用于保存MNE的数据集文件。
- 本脚本所使用的Python版本为**3.10.5**。



## 2. 工作流程

### `N4000T.m`工作流程：

- **格式化原始数据：**将所有的原始数据（`.csv`）文件放置于**同一路径下**，并以`Dir_runxxy.csv`格式统一命名（该种命名格式可被`Homer3`工具箱识别，进行统一求解）。其中，`Dir_run`为**文件头**，`xx`为**实验者编号**，可取`00`~`99`，`y`为**实验次数**，可取`0`~`9`。
- **导入参数文件：**确保本地存有`N4000.pos`与`N4000.mlist`两个参数文件，其分别确定了N4000仪器的**光源/探测极坐标**与**测量序列**，在本压缩包内，这两个参数文件存储在`Format_File`文件夹下。
- **原始数据格式转换：**运行`N4000T.m`，分别载入原始数据文件（可无限制复选）、`N4000.pos`与`N4000.mlist`，脚本会将其转换为存储原始数据与测量信息的`.nirs`文件与存储刺激信息的`.tsv`文件。

### `Homer3`工作流程：

- 使用`Homer3`将`.nirs`文件转换为`.snirf`文件，并求解逆问题得到脑皮层中血氧浓度的相对变化曲线，`Homer3`工具箱的使用在PPT中已做过具体说明，此处不再赘述。

###`N4000V.m`工作流程：

- **载入数据文件并进行可视化：**运行`N4000V.m`，载入原始数据文件（此处的原始数据文件只是为定向对应的数据文件，并不用于可视化）。对每个`.csv`原始数据文件，会在其路径下存在**同名**的文件夹用于存储`.png`文件，每个`.csv`文件共包含**6个**可视化输出，分别对应**左/右额叶**与**左/右颞叶**的血氧浓度变化（还有一张拼接图，同时展示四区域的浓度变化），以及一张不同通道间的响应一致性分析图，对应命名规则可参考例程。

### `N4000D_Py.m`工作流程：

- **载入数据文件并进行可视化：**运行`N4000D_Py.m`，载入原始数据文件与`N4000.pos`。对每个`.csv`原始数据文件，会在其路径下存在**同名**的文件夹用于存储输出文件，每个`.csv`文件共包含**1个**可视化输出，为脑功能动态图像。
- **注意事项：**初次运行`N4000D_Py.m`时可能会进行MNE数据集的下载，会存在一定的延时，可在MATLAB的命令行窗口实时查看下载进度。

###`N4000Net.m`工作流程：

- **载入原始数据文件：**运行`N4000Net.m`，载入原始数据文件，为数据文件提供定向指引。
- **载入位置参数文件：**载入`N4000.pos`，确定脑功能连接图所绘制的脑区。
- **载入大脑结点文件：**在压缩包内的`Format_File\Brain_Node`路径下存储有若干标准脑区划分结点文件（`.node`），通过选择这些标准脑区结点文件，`N4000Net.m`会自动将其转换为与N4000仪器测量适配的脑区划分结点文件（即仅显示N4000仪器测量的脑区），并以`.node`文件存储于`Format_File`文件夹下，在下一次操作时，即可直接选取这些转换后的结点文件。需要注意，尽量选取结点数较多的标准结点文件进行转换（如`Node_Power264.node`，`Node_AAL116.node`等，否则转换后的结点文件误差可能较大）。
- **载入大脑模型文件：**在压缩包内的`Format_File\Brain_Model`路径下存储有若干标准大脑模型文件（`.nv`），例程中选取的大脑模型文件为`BrainMesh_ICBM152.nv`。
- **载入图像配置文件：**在压缩包内的`Format_File`文件夹下存储有`N4000_Net_Option.mat`，用于存储脑功能连接图的相关配置信息，当然，如果希望对图像进行不同的配置，也可通过手动更改`N4000_Net_Option.mat`来实现。
- **进行可视化：**`N4000Net.m`会在原始数据文件路径下的**同名**文件夹中生成一张脑功能连接图。

 ## 3. 测试例程

在压缩包的`sample`文件夹中，存在一组**2个实验者，3组平行实验**的例程及对应输出，可供测试使用。