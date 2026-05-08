#!/usr/bin/env bash
set -Eeuo pipefail
[ -f "$HOME/.config/shadowmaker/load_shadowmaker_env.sh" ] && . "$HOME/.config/shadowmaker/load_shadowmaker_env.sh"
echo "============================================================"
echo "SHADOWMAKER AI PROVIDER SMOKE TEST"
echo "============================================================"
echo "Zeit=$(date -Is)"
echo
echo "== Maskierter Key-Status =="
for k in OPENAI_API_KEY PERPLEXITY_API_KEY MOONSHOT_API_KEY KIMI_API_KEY ANTHROPIC_API_KEY CLAUDE_API_KEY HF_TOKEN HUGGING_FACE_HUB_TOKEN; do
  v="${!k:-}"
  [ -n "$v" ] && echo "$k=SET len=${#v}" || echo "$k=MISSING"
done
echo
echo "== Autoload-Test =="
bash -lc "echo OPENAI=\$([ -n \"\$OPENAI_API_KEY\" ] && echo YES || echo NO); echo CLAUDE=\$([ -n \"\$ANTHROPIC_API_KEY\" ] && echo YES || echo NO); echo KIMI=\$([ -n \"\$KIMI_API_KEY\" ] && echo YES || echo NO); echo PPLX=\$([ -n \"\$PERPLEXITY_API_KEY\" ] && echo YES || echo NO)"
echo DONE
