# WorkBuddy 接入 Hy3 模型操作手册

## 一、概述
本文档介绍如何在 WorkBuddy中配置token平台自定义模型。配置完成后，WorkBuddy 可以直接调用平台上文本模型进行对话、代码、Agent 任务，也可以通过 Skill 方式使用图像和视频模型。

## 二、准备工作
开始配置前，请确保你已经具备以下条件：
- 已安装 WorkBuddy。
- 已获得token平台API Key。
- 当前网络环境可以正常访问平台地址。
- 已确认需要使用的模型名称。
- 本教程基于 WorkBuddy v4.24.5 版本。

## 三、获取 Hy3 API Key
访问token Platform：  http://ciyuanshangcheng.com/console/token
登录后进入**令牌管理**页面，创建并复制 API Key。

## 四、进入自定义模型配置
1. 打开 WorkBuddy。
2. 在页面中点击：  
   `Auto`  
   然后选择：  
   `配置自定义模型`

## 五、选择自定义提供商
在提供商列表中向下滑动到最后，选择：  
`其他`  
或：  
`Custom`  
该选项表示使用自定义 OpenAI-Compatible API 服务。

## 六、添加 Agnes 文本模型
点击添加模型，并填写以下参数：
```
Provider: Custom
API Base URL: http://ciyuanshangcheng.com/v1
API Key: YOUR_API_KEY
Model Name: Tencent-Hunyuan/Hy3
```


请将 `YOUR_API_KEY` 替换为你的实际 API Key。

## 七、保存配置
确认信息填写无误后，点击保存。  
保存成功后，在模型列表中应能看到：  
`Tencent-Hunyuan/Hy3`

## 八、选择模型
在 WorkBuddy 对话界面中选择：  
`Tencent-Hunyuan/Hy3`  
选择成功后，即表示文本模型配置完成。

## 九、验证文本模型
发起一次普通对话，例如：

> 你好，请介绍一下你自己。

如果配置正确，WorkBuddy 应能够正常返回Hy3大模型响应。

---

后面可以从WorkBuddy[专家] [技能] [项目模板]中倒腾各种姿势， 走上AI办公自动化巅峰赛。
