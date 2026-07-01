##  真人转换为虚拟人素材接口


如果传入的参考图片里面涉及真人/仿真人，必须先调用 虚拟人像创建接口进行创建后，得到Asset开头的资源链接，传入image_url.url参数。注意上传的图片不要侵害他人权益，否则产生法律后果自行承担。
调用该接口，大概10-12s会返回审核结果，接口返回成功表示素材可使用。

响应体中的`asset_url` 去替换原始真人图片


### 1. 域名 http://ciyuanshangcheng.com:8080

#### 2. 同步请求  POST /api/asset/upload/sync


参数

-  images ： []
- asset_type :"Image"
- callback_url : 可选

⚠️ 重要限制：
> - 同一批次所有 URL 必须为同一类型，Image / Video / Audio 不允许混合提交
> - 系统通过 URL 扩展名自动推断素材类型，URL 必须带有受支持的扩展名，否则整个请求将被拒绝


示例：

```
 curl -X POST http://ciyuanshangcheng.com:8080/api/asset/upload/sync   -H "Content-Type: application/json"   -d '{
    "images": ["https://ai-video-res.oss-cn-hangzhou.aliyuncs.com/images/5/2b87c705dd8c445a8dcb39b312e38b50.png"],
    "asset_type": "Image",
    "callback_url": "https://your-domain.com/api/callback"
  }'

```

响应体：

```
{
  "code": 200,
  "task_id": "task-20260411120100-e5f6g7h8",
  "status": "completed",
  "result": {
    "review_batch_id": "task-20260411120100-e5f6g7h8",
    "items": [
      {
        "asset_id": "local-20260411120101-1234abcd",
        "source_url": "https://example.com/a.jpg",
        "asset_url": "Asset://Asset-20260411120101-xxxxx",
        "downstream_asset_id": "Asset-20260411120101-xxxxx",
        "downstream_final_url": "https://ark-media-asset.tos-cn-beijing.volces.com/2109594849/xxxx.jpg?X-Tos-Algorithm=...",
        "downstream_url_expire_at": "2026-04-12T00:01:01Z",
        "submit_review_status": 1,
        "asset_type": "Image",
        "error_code": "",
        "error_message": "",
        "createtime": "2026-04-11T12:01:01Z"
      }
    ]
  }
}
```