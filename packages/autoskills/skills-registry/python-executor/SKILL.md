---
name: python-executor
description: "Execute Python code in a safe sandboxed environment via [inference.sh](https://inference.sh). Pre-installed: NumPy, Pandas, Matplotlib, requests, BeautifulSoup, Selenium, Playwright, MoviePy, Pillow, OpenCV, trimesh, and 100+ more libraries. Use for: data processing, web scraping, image manipulation, video creation, 3D model processing, PDF generation, API calls, automation scripts. Triggers: python, execute code, run script, web scraping, data analysis, image processing, video editing, 3D models, automation, pandas, matplotlib"
allowed-tools: Bash(belt *)
---

# Python Code Executor

Execute Python code in a safe, sandboxed environment with 100+ pre-installed libraries.

![Python Code Executor](https://cloud.inference.sh/u/33sqbmzt3mrg2xxphnhw5g5ear/01k8d8b4mckh6z89dhtxh72dsz.png)

## Quick Start

> Requires inference.sh CLI (`belt`). [Install instructions](https://raw.githubusercontent.com/inference-sh/skills/refs/heads/main/cli-install.md)

```bash
belt login

# Run Python code
belt app run infsh/python-executor --input '{
  "code": "import pandas as pd\nprint(pd.__version__)"
}'
```


## App Details

| Property | Value |
|----------|-------|
| App ID | `infsh/python-executor` |
| Environment | Python 3.10, CPU-only |
| RAM | 8GB (default) / 16GB (high_memory) |
| Timeout | 1-300 seconds (default: 30) |

## Input Schema

```json
{
  "code": "print('Hello World!')",
  "timeout": 30,
  "capture_output": true,
  "working_dir": null
}
```

## Pre-installed Libraries

### Web Scraping & HTTP
- `requests`, `httpx`, `aiohttp` - HTTP clients
- `beautifulsoup4`, `lxml` - HTML/XML parsing
- `selenium`, `playwright` - Browser automation
- `scrapy` - Web scraping framework

### Data Processing
- `numpy`, `pandas`, `scipy` - Numerical computing
- `matplotlib`, `seaborn`, `plotly` - Visualization

### Image Processing
- `pillow`, `opencv-python-headless` - Image manipulation
- `scikit-image`, `imageio` - Image algorithms

### Video & Audio
- `moviepy` - Video editing
- `av` (PyAV), `ffmpeg-python` - Video processing
- `pydub` - Audio manipulation

### 3D Processing
- `trimesh`, `open3d` - 3D mesh processing
- `numpy-stl`, `meshio`, `pyvista` - 3D file formats

### Documents & Graphics
- `svgwrite`, `cairosvg` - SVG creation
- `reportlab`, `pypdf2` - PDF generation

## Examples

### Web Scraping

```bash
belt app run infsh/python-executor --input '{
  "code": "import requests\nfrom bs4 import BeautifulSoup\n\nresponse = requests.get(\"https://example.com\")\nsoup = BeautifulSoup(response.content, \"html.parser\")\nprint(soup.find(\"title\").text)"
}'
```

### Data Analysis with Visualization

```bash
belt app run infsh/python-executor --input '{
  "code": "import pandas as pd\nimport matplotlib.pyplot as plt\n\ndata = {\"name\": [\"Alice\", \"Bob\"], \"sales\": [100, 150]}\ndf = pd.DataFrame(data)\n\nplt.bar(df[\"name\"], df[\"sales\"])\nplt.savefig(\"outputs/chart.png\")\nprint(\"Chart saved!\")"
}'
```

### Image Processing

```bash
belt app run infsh/python-executor --input '{
  "code": "from PIL import Image\nimport numpy as np\n\n# Create gradient image\narr = np.linspace(0, 255, 256*256, dtype=np.uint8).reshape(256, 256)\nimg = Image.fromarray(arr, mode=\"L\")\nimg.save(\"outputs/gradient.png\")\nprint(\"Image created!\")"
}'
```

### Video Creation

```bash
belt app run infsh/python-executor --input '{
  "code": "from moviepy.editor import ColorClip, TextClip, CompositeVideoClip\n\nclip = ColorClip(size=(640, 480), color=(0, 100, 200), duration=3)\ntxt = TextClip(\"Hello!\", fontsize=70, color=\"white\").set_position(\"center\").set_duration(3)\nvideo = CompositeVideoClip([clip, txt])\nvideo.write_videofile(\"outputs/hello.mp4\", fps=24)\nprint(\"Video created!\")",
  "timeout": 120
}'
```

### 3D Model Processing

```bash
belt app run infsh/python-executor --input '{
  "code": "import trimesh\n\nsphere = trimesh.creation.icosphere(subdivisions=3, radius=1.0)\nsphere.export(\"outputs/sphere.stl\")\nprint(f\"Created sphere with {len(sphere.vertices)} vertices\")"
}'
```

### API Calls

```bash
belt app run infsh/python-executor --input '{
  "code": "import requests\nimport json\n\nresponse = requests.get(\"https://api.github.com/users/octocat\")\ndata = response.json()\nprint(json.dumps(data, indent=2))"
}'
```

## File Output

Files saved to `outputs/` are automatically returned:

```python
# These files will be in the response
plt.savefig('outputs/chart.png')
df.to_csv('outputs/data.csv')
video.write_videofile('outputs/video.mp4')
mesh.export('outputs/model.stl')
```

## Variants

```bash
# Default (8GB RAM)
belt app run infsh/python-executor --input input.json

# High memory (16GB RAM) for large datasets
belt app run infsh/python-executor@high_memory --input input.json
```

## Use Cases

- **Web scraping** - Extract data from websites
- **Data analysis** - Process and visualize datasets
- **Image manipulation** - Resize, crop, composite images
- **Video creation** - Generate videos with text overlays
- **3D processing** - Load, transform, export 3D models
- **API integration** - Call external APIs
- **PDF generation** - Create reports and documents
- **Automation** - Run any Python script

## Important Notes

- **CPU-only** - No GPU/ML libraries (use dedicated AI apps for that)
- **Safe execution** - Runs in isolated subprocess
- **Non-interactive** - Use `plt.savefig()` not `plt.show()`
- **File detection** - Output files are auto-detected and returned

## Related Skills

```bash
# AI image generation (for ML-based images)
npx skills add inference-sh/skills@ai-image-generation

# AI video generation (for ML-based videos)
npx skills add inference-sh/skills@ai-video-generation

# LLM models (for text generation)
npx skills add inference-sh/skills@llm-models
```

## Documentation

- [Running Apps](https://inference.sh/docs/apps/running) - How to run apps via CLI
- [App Code](https://inference.sh/docs/extend/app-code) - Understanding app execution
- [Sandboxed Code Execution](https://inference.sh/blog/tools/sandboxed-execution) - Safe code execution for agents

