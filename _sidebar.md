* [快速指南](/)
* [文生图](text2image.md)
* [文生视频](text2video.md)
* [虚拟人素材](assert.md)
* [WorkBuddy接入文档](WorkBuddy.md)


curl https://tokengine.hanyoai.com/vi/chat/completions  -H  ""


 curl http://tokengine.hanyoai.com/v1/chat/completions   -H "Authorization: Bearer sk-LT3jPGtA5Mn0ynCxrLRcBH2yxjuT9mKyt2tdqcNIzjCUtFaU"   -H "Content-Type: application/json"   -d '{
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