# Benchmarks And Settings

The short table below is the quick-reference view. The fuller benchmark story, including the Gmail Sorter real workload and older fit checks, lives in `docs/11-BENCHMARKS-AND-WORKLOADS.md`.

## Benchmark CSV

```csv
timestamp,profile,model,test,ctx,cache,batch,ubatch,api_ok,gen_tps,prompt_tps,draft_accept,notes
2026-07-05T07:00:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,code_python,131072,q8_0,512,128,yes,84.96,151.74,90.6%,live llama.cpp benchmark
2026-07-05T07:00:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,code_cpp,131072,q8_0,512,128,yes,92.69,165.49,94.7%,live llama.cpp benchmark
2026-07-05T07:00:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,explain_concept,131072,q8_0,512,128,yes,74.49,138.60,68.3%,live llama.cpp benchmark
2026-07-05T07:00:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,qa_factual,131072,q8_0,512,128,yes,70.10,144.42,64.6%,live llama.cpp benchmark
2026-07-05T07:00:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,json_classify,131072,q8_0,512,128,yes,73.48,178.35,100.0%,live llama.cpp benchmark
2026-07-05T08:35:00-04:00,qwen36,Qwen3.6-35B-A3B-MTP,gmail_sorter_local_review,131072,q8_0,auto,auto,yes,90.92,549.96,85.03%,real Gmail Sorter Trash rescue workload: 6531 rows and 846873 generated tokens
2026-07-05T11:00:00-04:00,deepseek,DeepSeek-R1-Distill-Qwen-32B,installed,8192,q4_0,256,64,not_run,,,,installed but not benchmarked to avoid interrupting active qwen36 service
```

## Current Settings

| Profile | Context | Cache | Batch | uBatch | Use |
| --- | ---: | --- | ---: | ---: | --- |
| `coder`, `qwen36` | 131072 | q8_0 | auto-fit | auto-fit | Default daily coding |
| `fast`, `qwen36-fast` | 32768 | q8_0 | auto-fit | auto-fit | Quick smaller-context work |
| `deepseek` | 8192 | q4_0 | 256 | 64 | DeepSeek reasoning fallback |
| `planner`, `gemma4-26b` | 8192 | q4_0 | 256 | 64 | Installed Gemma 4 26B MoE architecture/planning model; benchmark pending |
| `planner-safe`, `gemma4-12b` | 8192 | q4_0 | 256 | 64 | Installed Gemma 4 12B fallback; benchmark pending |

`coder` and `fast` are compatibility aliases for Qwen3.6 profiles. `deepseek` points to DeepSeek-R1-Distill-Qwen-32B Q2_K and should be benchmarked when the active Qwen service can be interrupted. The Gemma planner profiles are installed, but they still need a fair fit/speed test before being treated as proven.
