# Benchmarks And Settings

## Benchmark CSV

```csv
timestamp,profile,model,ctx,cache,batch,ubatch,api_ok,reply_ok,gen_tps,llama_vram_mib,total_vram_mib,ram_used
2026-07-04T14:00:46-04:00,coder-fast,coder,4096,q8_0,512,128,yes,yes,40.50,9698MiB,10920,5.8Gi/30Gi
2026-07-04T14:01:07-04:00,coder-default,coder,8192,q8_0,512,128,yes,yes,41.87,9578MiB,10713,5.8Gi/30Gi
2026-07-04T14:01:31-04:00,coder-big,coder,16384,q4_0,256,64,yes,yes,33.86,9704MiB,10877,5.8Gi/30Gi
2026-07-04T14:02:16-04:00,deepseek-default,deepseek,8192,q8_0,512,128,yes,yes,18.81,9594MiB,10704,5.5Gi/30Gi
2026-07-04T14:03:00-04:00,qwen14-default,qwen14,8192,q8_0,512,128,yes,no,20.02,9530MiB,10625,5.6Gi/30Gi
```

## Final Settings

| Profile | Context | Cache | Batch | uBatch | Use |
| --- | ---: | --- | ---: | ---: | --- |
| `coder` | 8192 | q8_0 | 512 | 128 | Daily coding |
| `coder-big` | 16384 | q4_0 | 256 | 64 | Large context |
| `deepseek` | 8192 | q8_0 | 512 | 128 | Reasoning fallback |
| `qwen14` | 8192 | q8_0 | 512 | 128 | General fallback |

`coder` is default because it had the best measured throughput and successful reply behavior. `coder-big` is kept for larger context because it is slower and uses a smaller KV cache to fit. `deepseek` is the reasoning fallback. `qwen14` is retained as a third fallback because the benchmark response check did not pass.
