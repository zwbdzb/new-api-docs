# 取消任务API 文档

---

## 调用简介及示例

### 一、取消任务流程简介

取消任务接口用于取消已提交的视频生成任务，调用流程：

1. 调用取消任务接口，传入任务ID。
2. 接口返回取消结果，任务状态更新为 `cancelled`。

### 二、HTTP请求头

#### Header 参数

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| Authorization | string | 是 | 鉴权 API_KEY，格式为 Bearer `<API_KEY>` |
| Content-Type | string | 是 | 固定为 application/json |
| X-Trace-ID | string | 否 | 请求跟踪ID，建议填写，用于出现问题时，反馈TraceID快速排查定位。每次请求必须不同随机32位字符串，如 f3ab5c98d7e6f1a2b3c4d5e6f7a8b9c0 |

### 三、支持的模型列表

取消任务接口支持所有视频生成模型，包括但不限于：

| 平台 | 模型 |
|------|------|
| ZLHub | doubao-seedance-2.0 |
| Doubao/Seedance | doubao-seedance-2.0 |
| Ali | qwen-video |
| Kling | kling-v1 |
| Jimeng | jimeng-v1 |
| Vidu | vidu-v1 |
| Hailuo | hailuo-v1 |
| Sora | sora-2 |
| Gemini | gemini-video |
| Vertex | vertex-video |

---

## 接口地址

### 取消任务接口

| 接口类型 | 方法 | 地址 |
|---------|------|------|
| OpenAI 兼容接口 | POST | `https://ciyuanshangcheng.com/v1/videos/cancel/{task_id}` |
| ZLHub 兼容接口 | POST | `https://ciyuanshangcheng.com/v1/task/cancel/{task_id}` |

---

## 请求参数

### 取消任务请求参数

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| task_id | string | 是 | 任务ID，从创建任务时返回的 `id` 或 `task_id` 字段 |

---

## 请求和响应示例

### 一、取消任务

#### 1、请求示例-基础取消任务

```bash
curl -X POST https://ciyuanshangcheng.com/v1/videos/cancel/cgt-20260416141540-t7n9r \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx'
```

#### 2、请求示例-ZLHub 兼容接口

```bash
curl -X POST https://ciyuanshangcheng.com/v1/task/cancel/cgt-20260416141540-t7n9r \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx'
```

#### 3、取消任务响应示例

```json
{
  "code": "success",
  "message": "task_cancelled",
  "data": {
    "id": "cgt-20260416141540-t7n9r",
    "status": "cancelled"
  }
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| code | string | 响应码，`success` 表示成功 |
| message | string | 响应消息，`task_cancelled` 表示任务已取消 |
| data.id | string | 任务ID |
| data.status | string | 任务状态，`cancelled` 表示已取消 |

### 二、错误响应示例

```json
{
  "code": "task_not_exist",
  "message": "task_not_exist",
  "statusCode": 400
}
```

| 错误码 | HTTP 状态码 | 说明 |
|--------|-----------|------|
| task_id_required | 400 | 任务ID为空 |
| task_not_exist | 400 | 任务不存在 |
| user_id_required | 401 | 用户未登录 |
| get_task_failed | 500 | 获取任务失败 |
| cancel_task_failed | 500 | 取消任务失败 |
| channel_no_available_key | 500 | 渠道无可用密钥 |

---

## 注意事项

### 取消任务注意事项

1. **任务状态**：取消成功后，任务状态将更新为 `cancelled`。
2. **费用扣除**：已提交的任务在取消前可能已经产生费用，具体以平台计费规则为准。
3. **任务不存在**：如果任务不存在或已被取消，接口将返回 `task_not_exist` 错误。
4. **权限验证**：用户只能取消自己创建的任务。
5. **ZLHub 兼容**：支持 ZLHub 格式的接口地址 `/v1/task/cancel/{task_id}`。
6. **OpenAI 兼容**：支持 OpenAI 格式的接口地址 `/v1/videos/cancel/{task_id}`。

---

## 相关资源

- **词链AI官方平台**：[https://ciyuanshangcheng.com](https://ciyuanshangcheng.com)
- **注册地址（含推荐码）**：[https://ciyuanshangcheng.com/register?aff=9FAN](https://ciyuanshangcheng.com/register?aff=9FAN)
