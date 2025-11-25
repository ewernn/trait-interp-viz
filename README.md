# Trait Interpretation Visualization

Interactive visualization dashboard for monitoring LLM behavioral traits during generation.

**Live Demo**: [Coming soon - Railway deployment]

## What This Does

This is the **visualization-only** version of the trait-interp project. It displays:
- Token-by-token trait activations across all layers
- Multi-trait comparisons
- Layer deep-dives with attention/MLP analysis
- Trait correlation matrices

The full research codebase (extraction pipeline, training scripts) is in the private repo.

## Quick Start (Local)

```bash
# Install minimal dependencies
pip install -r requirements-viz.txt

# Run server (expects experiments/ directory to exist)
python visualization/serve.py

# Visit http://localhost:8000
```

## Deploy to Railway

See [RAILWAY_DEPLOY.md](RAILWAY_DEPLOY.md) for step-by-step instructions.

**TL;DR:**
1. Deploy this repo to Railway from GitHub
2. Create 5GB persistent volume mounted at `/app/experiments`
3. Run `railway run bash utils/railway_sync_r2.sh` to download data from R2
4. Done! (~$1-2/month hosting cost)

## Architecture

```
GitHub (public: viz code only)
    ↓
Railway (auto-deploy)
    ├─ Container: Python server
    └─ Volume: 3GB experiment data (from R2)
```

## Project Structure

```
trait-interp-viz/
├── visualization/          # Frontend + server
│   ├── serve.py           # Python HTTP server with API endpoints
│   ├── index.html         # Main UI
│   ├── styles.css         # Styling
│   ├── core/              # State management, path handling
│   └── views/             # Individual view components
├── config/
│   └── paths.yaml         # Single source of truth for paths
├── analysis/
│   └── check_available_data.py  # Data integrity checker
├── utils/
│   ├── railway_sync_r2.sh # Sync data from R2 to Railway volume
│   └── sync_push.sh       # Sync local → R2 (for updates)
├── experiments/           # Empty (filled via Railway volume)
├── requirements-viz.txt   # Minimal deps (no PyTorch)
├── railway.toml          # Railway config
└── RAILWAY_DEPLOY.md     # Deployment guide
```

## Updating

To update the visualization after changes to the private repo:

```bash
# In private repo
git push origin main   # Push to private
git push public main   # Push to public (triggers Railway redeploy)
```

To update experiment data:

```bash
# 1. Sync local → R2
bash utils/sync_push.sh

# 2. Sync R2 → Railway volume
railway run bash utils/railway_sync_r2.sh
```

## License

MIT

---

**Full research project**: [Private repo - contact author]
