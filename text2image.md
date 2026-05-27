# 文生图API 文档

## 官方地址

- **平台地址/Base URL**：`https://ciyuanshangcheng.com`
- **API 接口地址**：`https://ciyuanshangcheng.com/v1`

---

## 调用简介及示例

### 一、文生图流程简介

文生图接口为同步接口，调用流程：

1. 调用文生图接口，传入模型名称和提示词。
2. 接口返回生成的图片 URL 或 Base64 数据。


### 二、HTTP请求头

#### Header 参数

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| Authorization | string | 是 | 鉴权 API_KEY，格式为 Bearer `<API_KEY>` |
| Content-Type | string | 是 | 固定为 application/json |
| X-Trace-ID | string | 否 | 请求跟踪ID，建议填写，用于出现问题时，反馈TraceID快速排查定位。每次请求必须不同随机32位字符串，如 f3ab5c98d7e6f1a2b3c4d5e6f7a8b9c0 |

### 三、支持的模型列表

#### 文生图模型

| 模型名称 | 说明 |
|---------|------|
| doubao-seedream-4-5-251128 | 豆包 Seedream 4.5 |
| Tongyi-MAI/Z-Image | 通义万相 Z-Image |


---

## 接口地址

### 文生图接口

| 接口类型 | 方法 | 地址 |
|---------|------|------|
| OpenAI 兼容接口 | POST | `https://ciyuanshangcheng.com/v1/images/generations` |
| 查询图片接口 | GET | `https://ciyuanshangcheng.com/v1/images/{image_id}` |


---

## 请求参数

### 文生图请求参数（`/v1/images/generations`）

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| model | string | 是 | 模型名称，如 `doubao-seedream-4-5-251128` |
| prompt | string | 是 | 文本提示词，描述生成的图片内容 |
| n | uint | 否 | 生成图片数量，默认为 1 |
| size | string | 否 | 图片尺寸，如 `1024x1024`、`1024x1536`、`1536x1024` |
| quality | string | 否 | 图片质量，如 `standard`、`hd` |
| response_format | string | 否 | 响应格式，`url` 或 `b64_json`（Base64） |
| style | string | 否 | 图片风格，如 `realistic`、`artistic` |
| watermark | bool | 否 | 是否添加水印，默认为 `true`，建议设为 `false` |
| user | string | 否 | 用户标识，用于日志和计费 |


---

## 请求和响应示例

### 一、文生图

#### 1、请求示例-基础文生图

```bash
curl https://ciyuanshangcheng.com/v1/images/generations \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx' \
  -d '{
    "model": "doubao-seedream-4-5-251128",
    "prompt": "一只可爱的橘猫坐在窗台上，阳光透过窗户洒在它身上，写实风格，高清画质",
    "n": 1,
    "size": "1024x1024",
    "quality": "standard",
    "response_format": "url",
    "watermark": false
  }'
```

#### 2、请求示例-文生图（通义万相 Z-Image）

```bash
curl https://ciyuanshangcheng.com/v1/images/generations \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx' \
  -d '{
    "model": "Tongyi-MAI/Z-Image",
    "prompt": "中国山水画风格，远山如黛，近水清澈，云雾缭绕，意境深远",
    "n": 1,
    "size": "1024x1536",
    "watermark": false
  }'
```

#### 3、请求示例-生成多张图片

```bash
curl https://ciyuanshangcheng.com/v1/images/generations \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx' \
  -d '{
    "model": "doubao-seedream-4-5-251128",
    "prompt": "一个未来科技感的城市，高楼林立，飞行汽车穿梭其中，夜景，霓虹灯",
    "n": 4,
    "size": "1024x1024",
    "response_format": "url"
  }'
```

#### 4、文生图响应示例

```json
{
  "created": 1234567890,
  "data": [
    {
      "url": "https://example.com/generated_image.png",
      "revised_prompt": "一只可爱的橘猫安静地坐在阳光照射的窗台上，毛发在光线下呈现金黄色，写实摄影风格，8K超高清画质"
    }
  ]
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| created | int64 | 创建时间戳 |
| data | array | 图片数据数组 |
| data[].url | string | 图片 URL 地址 |
| data[].b64_json | string | Base64 编码的图片数据（当 response_format 为 b64_json 时返回） |
| data[].revised_prompt | string | 优化后的提示词（模型自动扩展的提示词） |


### 文生图注意事项

1. **同步响应**：文生图为同步接口，调用后会直接返回图片 URL 或 Base64 数据。
2. **图片尺寸**：支持的尺寸包括 `1024x1024`、`1024x1536`、`1536x1024` 等，具体以模型支持为准。
3. **图片质量**：`quality` 参数支持 `standard`（标准）和 `hd`（高清），高清模式消耗更多配额。
4. **响应格式**：`response_format` 支持 `url`（返回图片 URL）和 `b64_json`（返回 Base64 数据）。
5. **水印设置**：建议设置 `"watermark": false` 以去除水印。
6. **批量生成**：通过 `n` 参数可一次生成多张图片，默认生成 1 张。


---

## 相关资源

- **词链AI官方平台**：[https://ciyuanshangcheng.com](https://ciyuanshangcheng.com)
- **注册地址（含推荐码）**：[https://ciyuanshangcheng.com/register?aff=9FAN](https://ciyuanshangcheng.com/register?aff=9FAN)
- **OpenAI 图片 API 文档**：[https://platform.openai.com/docs/api-reference/images/create](https://platform.openai.com/docs/api-reference/images/create)
