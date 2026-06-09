# 词链AI令牌接入 & 相关软件配置参考

> **平台定位**：词链AI稳筑接口开发，深耕长期合作，是安全第一、财务合规的企业级模型平台。致力于为开发者和企业提供高效、低成本且全面的API大模型服务，聚焦多模型统一接入、集中管理、灵活调用和场景化应用。

## 官方地址
- **平台官网/Base URL**：`http://ciyuanshangcheng.com`
- **API 接口地址**：`http://ciyuanshangcheng.com/v1`

---

## （一）令牌密钥生成

### 一、注册账户
1. 访问词链AI官方平台，点击注册。
2. 输入您的**用户名或邮箱** → 设置**密码** → **再次确认密码**进行注册。
3. 注册成功后，返回登录界面，使用刚注册的用户名和密码登录。

### 二、兑换码充值（若有余额可跳过此步骤）
1. 登录后，点击进入 **【控制台】**。
2. 在控制台中找到 **【钱包管理】**。
3. 输入客服提供的**兑换码**，为账户兑换额度。

### 三、创建令牌（获取 API Key）
1. 登录后进入控制台，找到 **「令牌管理」** 模块。
2. 点击 **「添加令牌」**。
3. 填写令牌名称（如“Cursor专属API Key”），选择过期时间（推荐“永不过期”），设置额度（按需选择），点击「确认创建」。
4. 创建成功后，**立即复制生成的 API Key**（仅显示一次，建议备份保存）。

---

本项目制作了 文生文，文生图、文生视频体验中心， 欢迎体验。



## （二）配置前准备

在开始配置各类软件之前，请准备好以下信息：
- **API Key**：在词链AI平台创建令牌后生成的密钥。
- **Base URL**：`http://ciyuanshangcheng.com/v1`（词链AI的API接口地址，遵循OpenAI兼容接口规范）。

验证示例脚本
```
 curl http://ciyuanshangcheng.com/v1/chat/completions   -H "Authorization: Bearer sk-mwNSsolIwq5KH24pmWVSaWdnjFFtqCEnW8b3uOqLmpBao7Ht"   -H "Content-Type: application/json"   -d '{
    "model": "agnes-2.0-flash",
    "messages": [
      {
        "role": "system",
        "content": "You are a helpful AI assistant."
      },
      {
        "role": "user",
        "content": "Explain how autonomous agents use tools to complete tasks."
      }
    ],
    "temperature": 0.7,
    "max_tokens": 1024
  }'


```

---

## （三）各类软件/插件配置指南

### 一、Cursor 编辑器接入词链API
**适用场景**：在Cursor中使用GPT-4o、Claude 3.5等模型进行AI编程。

**步骤**：
1. **确认Cursor版本**：确保Cursor版本在 **0.38.0及以上**，以支持自定义OpenAI兼容API配置。
2. **打开设置**：启动Cursor，点击左上角齿轮图标（设置），或使用快捷键 `Ctrl+,` (Windows) / `Cmd+,` (Mac)。
3. **找到AI配置**：在设置左侧导航栏，点击「AI」选项，进入AI配置页面。
4. **展开OpenAI兼容配置**：下拉页面，找到「OpenAI Compatible」（兼容OpenAI）配置项，点击展开。
5. **填写配置信息**：
   - **Base URL**：`http://ciyuanshangcheng.com/v1`
   - **API Key**：粘贴你复制的词链API Key
   - **Model**：根据需要填写模型名称（如 `gpt-4o`、`claude-3.5-sonnet` 等）
6. **验证配置**：配置完成后，Cursor会自动验证连接，验证通过后即可在对话和代码补全中使用词链API提供的模型。

---

### 二、VS Code Copilot 接入词链API
**适用场景**：在VS Code中使用GitHub Copilot插件，但调用词链API提供的模型。

**步骤**：
1. **安装插件**：在VS Code扩展商店搜索并安装 **「OAI Compatible Provider for Copilot」** 插件。
2. **配置Base URL**：打开VS Code设置，找到该插件的设置项，将 **Base URL** 设置为 `http://ciyuanshangcheng.com/v1`。
3. **获取并填写API Key**：在词链AI平台注册并登录后，进入「令牌管理」复制API Key。
4. **在Copilot中配置**：
   - 打开Copilot设置。
   - 点击「添加模型」并选择OAI插件。
   - 输入从词链平台获取的API Key并确认。
5. **验证配置**：Copilot会自动获取模型列表，看到模型列表即表示配置完成。之后在Agent界面即可选择词链平台提供的各种模型。

---

### 三、Sub2API 网关接入词链AI
**适用场景**：将词链AI作为上游API供应商，集成到Sub2API网关中，实现统一管理和分发。

**步骤**：
1. **部署Sub2API**：使用Docker Compose一键部署Sub2API网关平台。
2. **登录管理后台**：访问 `http://你的IP:8080`，完成数据库和管理员配置。
3. **添加上游渠道**：在管理后台中，添加一个新的上游渠道，类型选择「API Key」。
4. **填写词链API配置**：
   - **Base URL**：`http://ciyuanshangcheng.com`
   - **API Key**：你在词链AI创建的令牌密钥
   - **支持模型**：根据需要勾选（如GPT-4o、Claude等）
5. **生成分发Key**：在Sub2API中为用户/团队生成独立的API Key，这些Key将自动路由到词链AI的上游资源。
6. **配置额度与限流**：在Sub2API中设置用户级和账号级并发限制、请求频率和Token速率限制。

---

### 四、SillyTavern 接入词链API
**适用场景**：在SillyTavern（AI角色扮演前端）中使用词链API提供的模型进行对话。

**步骤**：
1. **环境准备**：确保已安装Node.js ≥18.16，并完成SillyTavern的源码安装。
2. **进入API配置**：在SillyTavern的设置页面中，找到API连接配置部分。
3. **填写词链API配置**：
   - **API类型**：选择「OpenAI兼容接口」或「自定义端点」。
   - **自定义端点/Base URL**：`http://ciyuanshangcheng.com/v1`。
   - **API密钥**：粘贴你的词链API Key。
   - **模型名**：填写你想要使用的模型名称（如 `gpt-4o`）。
4. **高级安全设置（可选）** ：词链平台令牌支持绑定IP白名单、QPS限频阈值、模型访问黑名单等功能，可在词链控制台进行配置以增强安全性。
5. **联通性测试**：保存配置后，使用SillyTavern的连接测试功能验证API是否可用。

---

## （四）其他软件配置思路（通用）

对于其他支持自定义OpenAI兼容API的软件（如NextChat、ChatBox、LobeChat等），配置思路基本一致：

1. **找到设置**：在软件的设置或配置页面中，找到「模型服务」或「API 配置」相关选项。
2. **选择接口类型**：选择「OpenAI兼容接口」或「自定义API」。
3. **填写以下信息**：
   - **API 地址/Base URL**：`http://ciyuanshangcheng.com/v1`
   - **API Key**：你在词链AI创建的令牌密钥
   - **模型名称**：根据需要填写（如 `gpt-4o`、`claude-3.5-sonnet`、`gemini-pro` 等）
4. **保存并测试**：保存配置后，发送一条测试消息，确认模型正常回复。

---

## （五）常见问题与注意事项

### 1. API Key 安全
- **私钥仅显示一次**：创建令牌后，API Key 仅显示一次，请务必立即复制并妥善保存。
- **禁止明文存储**：不要将 API Key 直接硬编码在代码中或上传至版本控制系统（如Git）。建议使用环境变量或密钥管理服务（如Vault）进行加密存储。
- **最小权限原则**：在词链AI平台创建令牌时，可根据需要设置IP白名单、QPS限制、模型访问范围等，遵循最小权限原则。

### 2. 调用限制与优化
- **速率限制**：注意词链AI平台的API调用速率限制（QPS）。可在控制台为令牌设置合理的QPS阈值，防止突发流量导致服务异常。
- **重试策略**：在网络不稳定时，建议在客户端配置自动重试机制。推荐设置最大重试次数为3次，退避因子为1.5。
- **超时设置**：调用API时，建议将请求超时时间设置为30-60秒，避免长时间等待。

### 3. 网络与访问
- **国内直连**：词链AI平台支持国内直连，延迟较低。若遇到访问问题，请检查网络环境或联系平台客服。
- **IP白名单**：如果启用了IP白名单功能，请确保调用API的服务器IP在白名单范围内，否则将被拒绝访问。

### 4. 模型名称
- 不同模型在API中对应不同的名称，具体支持列表请在词链AI控制台的「模型广场」中查看。
- 常见模型名称示例：`gpt-4o`、`claude-3.5-sonnet`、`gemini-pro`、`deepseek-chat` 等。

---

## （六）相关资源

- **词链AI官方平台**：[http://ciyuanshangcheng.com](http://ciyuanshangcheng.com)
- **注册地址（含推荐码）** ：[http://ciyuanshangcheng.com/register?aff=9FAN](http://ciyuanshangcheng.com/register?aff=9FAN)
- **Sub2API项目**：[GitHub - Wei-Shaw/sub2api](https://github.com/Wei-Shaw/sub2api)

---
