# Deep Security Check Read-Only

Stand: Sa 2. Mai 07:07:54 CEST 2026

## Regel

Read-only. Keine Reparatur. Keine Secrets im Inhalt.

## User Failed Services

```text
  UNIT                       LOAD   ACTIVE SUB    DESCRIPTION
● shadowops-log-push.service loaded failed failed ShadowOps encrypted log push

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

1 loaded units listed.
```

## System Failed Services

```text
  UNIT                    LOAD   ACTIVE SUB    DESCRIPTION
● casper-md5check.service loaded failed failed casper-md5check Verify Live ISO checksums

Legend: LOAD   → Reflects whether the unit definition was properly loaded.
        ACTIVE → The high-level unit activation state, i.e. generalization of SUB.
        SUB    → The low-level unit activation state, values depend on unit type.

1 loaded units listed.
```

## Relevante Ports

```text
tcp   LISTEN 0      4096       127.0.0.1:18789      0.0.0.0:*                                         
tcp   LISTEN 0      4096         0.0.0.0:3001       0.0.0.0:*                                         
tcp   LISTEN 0      4096         0.0.0.0:5678       0.0.0.0:*                                         
tcp   LISTEN 0      4096            [::]:3001          [::]:*                                         
tcp   LISTEN 0      4096            [::]:5678          [::]:*                                         
```

## Docker

```text
openclaw-openclaw-gateway-1 | openclaw:local | Up 7 hours | 127.0.0.1:18789->18789/tcp
shadowmaker-agents | flowiseai/flowise:latest | Up 8 hours | 0.0.0.0:3001->3000/tcp, [::]:3001->3000/tcp
shadow-command-hub | docker.n8n.io/n8nio/n8n:latest | Up 8 hours | 0.0.0.0:5678->5678/tcp, [::]:5678->5678/tcp
shadow-postgres | postgres:16-alpine | Up 8 hours (healthy) | 5432/tcp
shadow-redis | redis:7-alpine | Up 8 hours (healthy) | 6379/tcp
open-webui | ghcr.io/open-webui/open-webui:main | Up 8 hours (healthy) | 0.0.0.0:3000->8080/tcp, [::]:3000->8080/tcp
```

## Sensible Pfade erkannt, Inhalte nicht ausgegeben

```text
/home/schattenmacher/.local/lib/python3.12/site-packages/tiktoken-0.12.0.dist-info
/home/schattenmacher/.local/lib/python3.12/site-packages/tokenizers
/home/schattenmacher/.local/lib/python3.12/site-packages/tiktoken_ext
/home/schattenmacher/.local/lib/python3.12/site-packages/tiktoken
/home/schattenmacher/.local/lib/python3.12/site-packages/tokenizers-0.22.2.dist-info
/home/schattenmacher/ComfyUI/ComfyUI/comfy/text_encoders/t5_pile_tokenizer
/home/schattenmacher/ComfyUI/ComfyUI/comfy/text_encoders/llama_tokenizer
/home/schattenmacher/ComfyUI/ComfyUI/comfy/text_encoders/hydit_clip_tokenizer
/home/schattenmacher/ComfyUI/ComfyUI/comfy/text_encoders/byt5_tokenizer
/home/schattenmacher/ComfyUI/ComfyUI/comfy/text_encoders/spiece_tokenizer.py
/home/schattenmacher/ComfyUI/ComfyUI/comfy/text_encoders/ace_lyrics_tokenizer
/home/schattenmacher/ComfyUI/ComfyUI/comfy/text_encoders/qwen25_tokenizer
/home/schattenmacher/ComfyUI/ComfyUI/comfy/text_encoders/t5_tokenizer
/home/schattenmacher/ComfyUI/ComfyUI/comfy/sd1_tokenizer
/home/schattenmacher/ComfyUI/ComfyUI/comfy/sd1_tokenizer/tokenizer_config.json
/home/schattenmacher/ComfyUI/ComfyUI/comfy/sd1_tokenizer/special_tokens_map.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/t5_pile_tokenizer
/home/schattenmacher/ComfyUI/comfy/text_encoders/t5_pile_tokenizer/tokenizer.model
/home/schattenmacher/ComfyUI/comfy/text_encoders/llama_tokenizer
/home/schattenmacher/ComfyUI/comfy/text_encoders/llama_tokenizer/tokenizer_config.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/llama_tokenizer/tokenizer.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/hydit_clip_tokenizer
/home/schattenmacher/ComfyUI/comfy/text_encoders/hydit_clip_tokenizer/tokenizer_config.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/hydit_clip_tokenizer/special_tokens_map.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/__pycache__/spiece_tokenizer.cpython-312.pyc
/home/schattenmacher/ComfyUI/comfy/text_encoders/byt5_tokenizer
/home/schattenmacher/ComfyUI/comfy/text_encoders/byt5_tokenizer/tokenizer_config.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/byt5_tokenizer/special_tokens_map.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/byt5_tokenizer/added_tokens.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/spiece_tokenizer.py
/home/schattenmacher/ComfyUI/comfy/text_encoders/ace_lyrics_tokenizer
/home/schattenmacher/ComfyUI/comfy/text_encoders/qwen25_tokenizer
/home/schattenmacher/ComfyUI/comfy/text_encoders/qwen25_tokenizer/tokenizer_config.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/t5_tokenizer
/home/schattenmacher/ComfyUI/comfy/text_encoders/t5_tokenizer/tokenizer_config.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/t5_tokenizer/special_tokens_map.json
/home/schattenmacher/ComfyUI/comfy/text_encoders/t5_tokenizer/tokenizer.json
/home/schattenmacher/ComfyUI/comfy/ldm/cosmos/cosmos_tokenizer
/home/schattenmacher/ComfyUI/comfy/sd1_tokenizer
/home/schattenmacher/ComfyUI/comfy/sd1_tokenizer/tokenizer_config.json
/home/schattenmacher/ComfyUI/comfy/sd1_tokenizer/special_tokens_map.json
/home/schattenmacher/discord_token_guard_reset.sh
/home/schattenmacher/Videos/Video Aevo Unterweisung Aufnahmen/_tmp_aevo_poster_sim_full_2026-01-16_215647/auto_vbr.env
/home/schattenmacher/Videos/Video Aevo Unterweisung Aufnahmen/_tmp_aevo_poster_sim_full_2026-01-16_215711/auto_vbr.env
/home/schattenmacher/Videos/Video Aevo Unterweisung Aufnahmen/_tmp_aevo_fit_v2_2026-01-17_004752/fit.env
/home/schattenmacher/Videos/Video Aevo Unterweisung Aufnahmen/_tmp_aevo_poster_sim_full_2026-01-16_220037/auto_vbr.env
/home/schattenmacher/development/ShadowLearn/backend/.env
/home/schattenmacher/development/ShadowLearn/ShadowLearnAI_FULL/backend/.env
/home/schattenmacher/IBOGA-TOKEN-Projekt
/home/schattenmacher/IBOGA-TOKEN-Projekt/IBOGA-TOKEN-Projekt
/home/schattenmacher/.openclaw/.env
/home/schattenmacher/shadow-letta/.venv/bin/tokenize-rt
/home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean/merged_model_1_5b/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean/merged_model_1_5b/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean/checkpoints/checkpoint-476/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean/checkpoints/checkpoint-476/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean/checkpoints/checkpoint-238/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean/checkpoints/checkpoint-238/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean/adapter/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/qwen25-15b-lora-clean/adapter/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-clean-train/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-clean-train/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-psa_sa1_sa3/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-psa_sa1_sa3/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-ihk-cloud-migration/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-ihk-cloud-migration/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-psa-sa1-sa3/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-psa-sa1-sa3/tokenizer.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-psa-sa1-sa3-clean/tokenizer_config.json
/home/schattenmacher/usb-llm-data-pipeline/lora-output-psa-sa1-sa3-clean/tokenizer.json
/home/schattenmacher/.vscode/extensions/github.copilot-chat-0.36.1/dist/o200k_base.tiktoken
/home/schattenmacher/.vscode/extensions/github.copilot-chat-0.36.1/dist/cl100k_base.tiktoken
/home/schattenmacher/.vscode/extensions/github.copilot-chat-0.36.1/dist/tikTokenizerWorker.js
/home/schattenmacher/.vscode/extensions/donjayamanne.python-environment-manager-1.2.7/pythonFiles/.env
/home/schattenmacher/.vscode/extensions/github.copilot-chat-0.43.0/dist/o200k_base.tiktoken
/home/schattenmacher/.vscode/extensions/github.copilot-chat-0.43.0/dist/cl100k_base.tiktoken
/home/schattenmacher/.vscode/extensions/github.copilot-chat-0.43.0/dist/tikTokenizerWorker.js
/home/schattenmacher/telegram-chatgpt-bot/.env
/home/schattenmacher/eva-agent-template/secret.key
/home/schattenmacher/AEVO_App/node_modules/builder-util-runtime/out/CancellationToken.js.map
/home/schattenmacher/AEVO_App/node_modules/builder-util-runtime/out/CancellationToken.d.ts
/home/schattenmacher/AEVO_App/node_modules/builder-util-runtime/out/CancellationToken.js
/home/schattenmacher/next_step_telegram_tokens.sh
/home/schattenmacher/setup_shadowmaker_discord_channels_wizard.sh.bak.token_guard_20260502_055129
/home/schattenmacher/bots/telegrambot/.env
/home/schattenmacher/shadowmaker-ai-stack/.env
/home/schattenmacher/Downloads/freies-radio-stuttgart-web/node_modules/js-tokens
/home/schattenmacher/secrets
/home/schattenmacher/secrets/telegram_bots.env
/home/schattenmacher/Android/Sdk/emulator/lib/ca-bundle.pem
/home/schattenmacher/.cache/openclaw-upstream/docs/reference/token-use.md
/home/schattenmacher/.cache/openclaw-upstream/.detect-secrets.cfg
/home/schattenmacher/.cache/openclaw-upstream/src/infra/pairing-token.ts
/home/schattenmacher/.cache/openclaw-upstream/src/commands/auth-token.ts
/home/schattenmacher/.cache/openclaw-upstream/src/agents/anthropic.setup-token.live.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/agents/models-config.auto-injects-github-copilot-provider-token-is.e2e.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/agents/models-config.skips-writing-models-json-no-env-token.e2e.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/agents/models-config.uses-first-github-copilot-profile-env-tokens.e2e.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/agents/models-config.falls-back-default-baseurl-token-exchange-fails.e2e.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/discord/token.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/discord/token.ts
/home/schattenmacher/.cache/openclaw-upstream/src/utils/normalize-secret-input.ts
/home/schattenmacher/.cache/openclaw-upstream/src/providers/github-copilot-token.ts
/home/schattenmacher/.cache/openclaw-upstream/src/providers/github-copilot-token.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/browser/server.auth-token-gates-http.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/browser/control-auth.auto-token.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/config/telegram-webhook-secret.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/config/slack-token-validation.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/slack/token.ts
/home/schattenmacher/.cache/openclaw-upstream/src/line/channel-access-token.ts
/home/schattenmacher/.cache/openclaw-upstream/src/telegram/token.test.ts
/home/schattenmacher/.cache/openclaw-upstream/src/telegram/token.ts
/home/schattenmacher/.cache/openclaw-upstream/src/security/secret-equal.ts
/home/schattenmacher/.cache/openclaw-upstream/src/auto-reply/tokens.ts
/home/schattenmacher/.cache/openclaw-upstream/openclaw.podman.env
/home/schattenmacher/.cache/openclaw-upstream/.secrets.baseline
/home/schattenmacher/.docker/.token_seed.lock
/home/schattenmacher/.docker/.token_seed
```

## Git Status

```text
 M mission_control/memory_wiki/projects.md
 M src/pruefungssimulator.py
?? build_final_training.py
?? local_exam_ai_test.sh
?? mission_control/career_it/
?? mission_control/finance_housing_readonly/
?? mission_control/ihk_mfp/
?? mission_control/projects/phase3_operating_rules.md
?? mission_control/prompt_to_code/
?? mission_control/security/deep_security_check_20260502_070606.md
?? mission_control/security/latest_deep_security_check.md
?? pipeline/
?? prepare_final_dataset_split.sh
?? run_final_scorer_test.sh
?? scripts/career_agent_template.sh
?? scripts/deep_security_check_readonly.sh
?? scripts/finance_housing_readonly_report.sh
?? scripts/ihk_mfp_drill.sh
?? scripts/prompt_to_code_review.sh
?? src/autonomous_mfp_training_workflow.py
?? src/autonomous_silver_workflow.py
?? src/autonomous_silver_workflow_v2.py
?? src/autonomous_silver_workflow_v2.py.bak.heading_detection.20260425_032418
?? src/final_scorer_test.py
?? src/generate_silver_from_bronze.py
?? src/generate_silver_ollama.py
?? src/generate_silver_ollama.py.bak.input_gate.20260425_011911
?? src/generate_silver_ollama.py.bak.quality_gate.20260425_005800
?? src/hermes_agent.py
?? src/hermes_agent.py.bak.20260424_223602
?? src/hermes_agent.py.bak.intent_batch.20260424_224300
?? src/hermes_agent.py.bak.scorer_menu.20260424_223722
?? src/hermes_agent.py.bak.timeout_modes.20260424_224122
?? src/local_exam_ai_test.py
?? src/local_exam_ai_test.py.bak.auto_mfp.20260425_045643
?? src/local_exam_ai_test.py.bak.local_exam_v2.20260425_044223
?? src/local_exam_ai_test.py.bak.local_exam_v2_1.20260425_044455
?? src/local_exam_ai_test.py.bak.muster_scorer_v2.20260425_045241
?? src/local_exam_ai_test.py.bak.musterloesung_mode.20260425_045111
?? src/pruefungssimulator.py.bak.20260415_182548
?? src/pruefungssimulator.py.bak.20260415_184011
?? src/pruefungssimulator.py.bak.20260415_193434
?? src/pruefungssimulator.py.bak.avg_norm.20260424_225354
?? src/pruefungssimulator.py.bak.batch_full_output.20260424_230327
?? src/pruefungssimulator.py.bak.broken_full_output.20260424_230400
?? src/pruefungssimulator.py.bak.fstring_final.20260424_230522
?? src/pruefungssimulator.py.bak.full_output.20260424_225727
?? src/pruefungssimulator.py.bak.indent_repair.20260424_224920
?? src/pruefungssimulator.py.bak.regex_full_final.20260424_230445
?? src/pruefungssimulator.py.bak.score_norm.20260424_224744
?? src/pruefungssimulator.py.bak.timer_indent.20260424_224953
?? src/test_mfp_lora_adapter.py
?? src/test_mfp_lora_adapter.py.bak.inference_v2.20260425_052910
?? src/train_mfp_lora.py
?? src/train_mfp_lora.py.bak.compat.20260425_050108
?? test_hermes_agent.sh
?? triage_task_types.py
```

## User Timer

```text
NEXT                             LEFT LAST                              PASSED UNIT                                     ACTIVATES
Sat 2026-05-02 09:00:00 CEST 1h 52min -                                      - openclaw-security-health.timer           openclaw-security-health.service
Sat 2026-05-02 09:01:39 CEST 1h 53min -                                      - shadowmaker-security-audit-discord.timer shadowmaker-security-audit-discord.service
```

## Bewertung

- Secrets werden nur als Pfade erkannt, nicht gelesen.
- OpenClaw Binding nicht verändern.
- ShadowOps failed services separat entscheiden: reparieren oder deaktivieren.
- casper-md5check ist typischerweise unkritisch.
