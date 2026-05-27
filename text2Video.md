# 文生视频API 文档


## 官方地址

- **平台地址/Base URL**：`https://ciyuanshangcheng.com`
- **API 接口地址**：`https://ciyuanshangcheng.com/v1`

---

## 调用简介及示例


### 一、文生视频流程简介

视频生成任务接口是异步接口，视频生成任务流程：

1. 调用创建视频生成任务接口创建视频生成任务。
2. 创建任务时设置 `callback_url` 接任务的状态变化回调。
3. 定时使用查询接口查询视频生成任务状态（**可选，作为辅助**，建议任务创建10分钟后还未收到状态回调可以主动查询，每个任务每分钟查询一次，严禁频繁查询）
   - a. 任务 running，过段时间再查询任务状态
   - b. 任务完成，返回视频链接，在24小时内下载生成的视频文件

### 三、HTTP请求头

#### Header 参数

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| Authorization | string | 是 | 鉴权 API_KEY，格式为 Bearer `<API_KEY>` |
| Content-Type | string | 是 | 固定为 application/json |
| X-Trace-ID | string | 否 | 请求跟踪ID，建议填写，用于出现问题时，反馈TraceID快速排查定位。每次请求必须不同随机32位字符串，如 f3ab5c98d7e6f1a2b3c4d5e6f7a8b9c0 |

### 四、支持的模型列表


#### 文生视频模型

| 模型名称 | 说明 |
|---------|------|
| doubao-seedance-2-0-260128 | 豆包 Seedance 2.0 |
| doubao-seedance-2.0-fast | 豆包 Seedance 2.0 快速版 |
| doubao-seedance-2.0 | 豆包 Seedance 2.0 标准版 |

---

## 接口地址


### 文生视频接口

| 接口类型 | 方法 | 地址 |
|---------|------|------|
| 视频生成接口 | POST | `https://ciyuanshangcheng.com/v1/video/generations` |
| 查询视频任务状态接口 | GET | `https://ciyuanshangcheng.com/v1/video/generations/{task_id}` |
| OpenAI 兼容接口 | POST/GET | `https://ciyuanshangcheng.com/v1/videos` |
| 视频内容获取接口 | GET | `https://ciyuanshangcheng.com/v1/videos/{task_id}/content` |

---

## 请求参数


### 文生视频请求参数（`/v1/video/generations`）

### 统一接口请求参数（`/v1/video/generations`）

| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| model | string | 是 | 模型名称，如 `doubao-seedance-2.0` |
| prompt | string | 是 | 文本提示词，描述生成的视频内容 |
| size | string | 否 | 视频宽高比，如 `16:9`、`9:16`、`1:1`，默认为 `16:9` |
| duration | int | 否 | 视频时长（秒），默认为 5 |
| metadata | object | 否 | 厂商自定义参数，包含更详细的配置 |

#### metadata 字段说明

`metadata` 对象支持以下子字段：

| 参数 | 类型 | 说明 |
|------|------|------|
| content | array | 内容数组，支持文本、图片、视频、音频等多种输入 |
| watermark | bool | 是否添加水印，推荐设为 `false` |
| generate_audio | bool | 是否生成音频 |
| negative_prompt | string | 反向提示词，描述不想要的内容 |
| camera_control | object | 相机控制参数 |
| first_frame | string | 首帧图片 URL（图生视频） |
| last_frame | string | 尾帧图片 URL（尾帧图生视频） |
| reference_image | string | 参考图片 URL |
| reference_video | string | 参考视频 URL |
| reference_audio | string | 参考音频 URL |

#### content 数组项格式

**文本类型：**

```json
{
  "type": "text",
  "text": "提示词内容"
}
```

**图片类型：**

```json
{
  "type": "image_url",
  "image_url": {
    "url": "图片URL"
  },
  "role": "reference_image"
}
```

---

## 请求和响应示例

### 二、文生视频

#### 1、请求示例-文生视频（基础）

```bash
curl https://ciyuanshangcheng.com/v1/video/generations \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx' \
  -d '{
    "model": "doubao-seedance-2.0",
    "prompt": "一只橘色的猫坐在窗台上，温暖的阳光洒在它身上，它慢慢转头看向镜头，电影风格，高清画质",
    "duration": 5,
    "size": "16:9"
  }'
```

### 2、请求示例-图生视频（参考图片）

```bash
curl https://ciyuanshangcheng.com/v1/video/generations \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx' \
  -d '{
    "model": "doubao-seedance-2.0",
    "prompt": "一只橘色的猫坐在窗台上，温暖的阳光洒在它身上，它慢慢转头看向镜头，电影风格，高清画质",
    "duration": 5,
    "size": "16:9",
    "metadata": {
      "content": [
        {
          "type": "text",
          "text": "一只橘色的猫坐在窗台上，温暖的阳光洒在它身上，它慢慢转头看向镜头，电影风格，高清画质"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "https://example.com/cat.jpg"
          },
          "role": "reference_image"
        }
      ],
      "watermark": false,
      "generate_audio": true
    }
  }'
```

### 3、请求示例-首尾帧

```bash
curl https://ciyuanshangcheng.com/v1/video/generations \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx' \
  -d '{
    "model": "doubao-seedance-2.0",
    "prompt": "根据首帧和尾帧图片，生成流畅过渡的高清视频",
    "size": "16:9",
    "duration": 8,
    "metadata": {
      "content": [
        {
          "type": "text",
          "text": "根据首帧和尾帧图片，生成流畅过渡的高清视频"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "https://example.com/first_frame.jpg"
          },
          "role": "first_frame"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "https://example.com/last_frame.jpg"
          },
          "role": "last_frame"
        }
      ],
      "watermark": false,
      "generate_audio": true
    }
  }'
```

### 4、请求示例-多模态参考（图片+视频+音频）

```bash
curl https://ciyuanshangcheng.com/v1/video/generations \
  -X POST \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Bearer sk-xxxxx' \
  -d '{
    "model": "doubao-seedance-2.0",
    "prompt": "全程使用视频1的第一视角构图，全程使用音频1作为背景音乐",
    "size": "16:9",
    "duration": 11,
    "metadata": {
      "content": [
        {
          "type": "text",
          "text": "全程使用视频1的第一视角构图，全程使用音频1作为背景音乐"
        },
        {
          "type": "image_url",
          "image_url": {
            "url": "https://example.com/reference_image.jpg"
          },
          "role": "reference_image"
        },
        {
          "type": "video_url",
          "video_url": {
            "url": "https://example.com/reference_video.mp4"
          },
          "role": "reference_video"
        },
        {
          "type": "audio_url",
          "audio_url": {
            "url": "https://example.com/reference_audio.mp3"
          },
          "role": "reference_audio"
        }
      ],
      "watermark": false,
      "generate_audio": true
    }
  }'
```

### 5、视频生成响应示例

```json
{
  "id": "video-xxx",
  "object": "video",
  "model": "doubao-seedance-2.0",
  "status": "queued",
  "progress": 0,
  "created_at": 1234567890,
  "task_id": "task-xxx"
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| id | string | 任务ID |
| object | string | 对象类型，固定为 `video` |
| model | string | 使用的模型名称 |
| status | string | 任务状态：`queued`（排队中）、`in_progress`（生成中）、`completed`（已完成）、`failed`（失败） |
| progress | int | 进度百分比（0-100） |
| created_at | int64 | 创建时间戳 |
| task_id | string | 底层任务ID |

### 6、查询视频任务响应示例

#### 成功响应

```json
{
  "id": "video-xxx",
  "object": "video",
  "model": "doubao-seedance-2.0",
  "status": "completed",
  "progress": 100,
  "created_at": 1234567890,
  "completed_at": 1234567950,
  "metadata": {
    "url": "https://example.com/generated_video.mp4"
  }
}
```

#### 失败响应

```json
{
  "id": "video-xxx",
  "object": "video",
  "model": "doubao-seedance-2.0",
  "status": "failed",
  "progress": 100,
  "created_at": 1234567890,
  "completed_at": 1234567950,
  "error": {
    "message": "生成失败：内容不符合安全规范",
    "code": "generation_failed"
  }
}
```

| 字段 | 类型 | 说明 |
|------|------|------|
| id | string | 任务ID |
| object | string | 对象类型，固定为 `video` |
| model | string | 使用的模型名称 |
| status | string | 任务状态 |
| progress | int | 进度百分比 |
| created_at | int64 | 创建时间戳 |
| completed_at | int64 | 完成时间戳 |
| metadata | object | 结果元数据，包含视频URL等 |
| error | object | 错误信息（失败时） |

---

## 错误码说明

| 错误码 | HTTP 状态码 | 说明 |
|--------|-----------|------|
| invalid_request_error | 400 | 请求参数错误 |
| server_error | 500 | 服务器内部错误 |
| rate_limit_error | 429 | 请求频率超限 |
| authentication_error | 401 | 认证失败 |
| permission_error | 403 | 无权限访问 |

---

## 提示词技巧（图片引用方式）

提示词中必须使用"**素材类型+序号**"格式引用素材，序号为请求体中该素材在同类素材中的排序。例如「图片 n」指代content数组中第 n 个type="image_url"的参考图片（按数组顺序从1开始计数）。

### 多模态参考

- **图片参考**：参考/提取/结合 +「图片 n」中的「主体/被参考元素描述」，生成「画面描述」，保持「主体/被参考元素描述」特征一致。
- **视频参考**：参考「视频 n」的「动作描述/运镜描述/特效描述」，生成「画面描述」，保持动作细节/运镜/特效一致。
- **音频参考**：
  - 音色参考：「角色」说："「台词」，音色参考「音频 n」。
  - 音频内容参考：理想出现时机 +「音频 n」。

### 编辑视频

- **增加元素**：清晰描述「元素特征」+「出现时机」+「出现位置」
- **删除元素**：点明需要删除的元素，对于保持不变的元素，在提示词中加以强调，表现更佳
- **修改元素**：清晰描述更换元素即可

### 延长视频

- **延长视频**：向前/向后延长「视频n」+「需延长的视频描述」
- **轨道补全**：「视频1」+「过渡画面描述」+接「视频2」+「过渡画面描述」+接「视频3」

---

## 附录：Content 数组 role 类型说明

| role 值 | 类型 | 说明 |
|---------|------|------|
| reference_image | 图片 | 参考图片，用于风格或内容参考 |
| first_frame | 图片 | 首帧图片，用于图生视频 |
| last_frame | 图片 | 尾帧图片，用于首尾帧过渡生成 |
| reference_video | 视频 | 参考视频，用于动作或风格参考 |
| reference_audio | 音频 | 参考音频，用于背景音乐或音效 |

---

## 注意事项


### 文生视频注意事项

1. **异步处理**：视频生成为异步任务，提交后会返回任务ID，需要通过查询接口获取生成结果。
2. **生成时长**：视频生成时间取决于视频时长、分辨率和当前队列情况，通常需要几分钟到几十分钟不等。
3. **水印设置**：建议在 `metadata` 中设置 `"watermark": false` 以去除水印。
4. **音频生成**：设置 `"generate_audio": true` 可为视频生成配套音频。
5. **参考素材**：支持多种参考素材类型，包括参考图片（`reference_image`）、首帧（`first_frame`）、尾帧（`last_frame`）、参考视频（`reference_video`）和参考音频（`reference_audio`）。
6. **结果下载**：视频生成完成后，请在 24 小时内下载生成的视频文件。

---

## 相关资源

- **词链AI官方平台**：[https://ciyuanshangcheng.com](https://ciyuanshangcheng.com)
- **注册地址（含推荐码）**：[https://ciyuanshangcheng.com/register?aff=9FAN](https://ciyuanshangcheng.com/register?aff=9FAN)
- **OpenAI 视频 API 文档**：[https://platform.openai.com/docs/api-reference/videos/create](https://platform.openai.com/docs/api-reference/videos/create)
