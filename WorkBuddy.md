# WorkBuddy 接入 Agnes 模型操作手册

## 一、概述
本文档介绍如何在 WorkBuddy中配置token平台自定义模型。配置完成后，WorkBuddy 可以直接调用平台上文本模型进行对话、代码、Agent 任务，也可以通过 Skill 方式使用图像和视频模型。

## 二、准备工作
开始配置前，请确保你已经具备以下条件：
- 已安装 WorkBuddy。
- 已获得token平台API Key。
- 当前网络环境可以正常访问平台地址。
- 已确认需要使用的模型名称。
- 本教程基于 WorkBuddy v4.24.5 版本。

## 三、获取 Agnes API Key
访问token Platform：  http://ciyuanshangcheng.com/console/token
登录后进入 API Key 页面，创建并复制 API Key。

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
Model Name: agnes-2.0-flash
```


请将 `YOUR_API_KEY` 替换为你的实际 API Key。

## 七、保存配置
确认信息填写无误后，点击保存。  
保存成功后，在模型列表中应能看到：  
`agnes-2.0-flash`

## 八、选择模型
在 WorkBuddy 对话界面中选择：  
`agnes-2.0-flash`  
选择成功后，即表示文本模型配置完成。

## 九、验证文本模型
发起一次普通对话，例如：

> 你好，请介绍一下你自己。

如果配置正确，WorkBuddy 应能够正常返回 Agnes 模型响应。

## 十、配置图像和视频模型
Agnes 的图像和视频模型可以通过创建 Skill 的方式在 WorkBuddy 中使用。  
可以在 WorkBuddy 中输入以下提示词，让其自动创建 Skill：
```
我想要使用 Agnes Image 2.0 模型生图生视频，访问它的 API 平台 https://agnes-ai.com/doc/overview，并将它打包成一份 Skill。
```


WorkBuddy 会根据 Agnes API 文档自动生成图像和视频相关 Skill。

## 十一、使用图像 Skill
Skill 创建完成后，点击技能列表，选择图像生成 Skill。  
示例 Skill 名称：  
`agnes-image-gen`  

然后输入图片生成提示词，示例：

> 生成一张赛博朋克城市夜景，霓虹灯光，电影感，高细节。

如果配置正确，WorkBuddy 会调用 Agnes 图像模型并返回生成结果。

## 十二、使用视频 Skill
选择视频生成 Skill。  
示例 Skill 名称：  
`agnes-video-gen`  

然后输入视频生成提示词，示例：

> 生成一段亚洲女生模特穿着白色摄影棚中展示黑色连衣裙的视频，从全景缓慢切到半身特写，保持自然转身，5 秒。

如果配置正确，WorkBuddy 会提交视频任务，并返回任务状态或视频 URL。

## 十三、常见问题排查

### 1. 文本模型无法返回
请检查 API Base URL 是否正确：  
`http://ciyuanshangcheng.com/v1`  
同时确认 API Key 是否有效。

### 2. 模型列表中看不到 agnes-2.0-flash
请确认模型名称填写正确：  
`agnes-2.0-flash`  
模型 ID 通常区分大小写，建议直接复制平台提供的模型名称。

### 3. 图像或视频 Skill 创建失败
请确认 WorkBuddy 可以正常访问 Agnes 文档地址：  
<https://agnes-ai.com/doc/overview>  
同时确认当前模型具备读取文档和创建 Skill 的能力。

### 4. 视频任务长时间没有完成
视频生成通常需要一定时间。  
请等待任务完成后查看返回的视频 URL 或任务状态。

### 5. 鉴权失败
请检查 API Key 是否正确、账户余额或 credits 是否充足。