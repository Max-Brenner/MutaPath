# MutaPath

AI bioinformatics platform: genomic variants → multi-layer biological interpretation → mechanistic hypotheses.

## Stack

- **Nextflow** — workflow orchestration
- **bcftools** — VCF normalization, filtering, indexing
- **VEP** (Ensembl) — variant consequence + protein + regulatory annotation
- **bedtools** — regulatory region intersection
- **Python** — protein parsing, pathway mapping, metabolic engine, evidence assembly, reporting
- **LLM API** — AI reasoning layer (Anthropic or OpenAI)

## Modules

| Layer | Module | Tool |
|-------|--------|------|
| Input | `input_parser` | bcftools norm + bgzip + tabix |
| Input | `variant_selector` | bcftools filter |
| Annotation | `consequence_annotator` | VEP (`--everything --canonical`, outputs JSON) |
| Annotation | `regulatory_effects` | bedtools intersect (requires `--regulatory_bed`) |
| Protein | `protein_effects` | Python — parses VEP JSON for domain/motif info |
| Context | `pathway_mapper` | Python |
| Context | `metabolic_impact_engine` | Python |
| Integration | `evidence_schema` | Python — merges all layers into JSON |
| AI | `ai_reasoner` | Python — LLM API call |
| Output | `report_generator` | Python — Markdown + HTML |

## Params

| Param | Required | Description |
|-------|----------|-------------|
| `--samplesheet` | yes | CSV: `sample_id,vcf,reference,gtf` |
| `--outdir` | no | Output dir (default: `results`) |
| `--bed` | no | BED for region filtering |
| `--regulatory_bed` | no | BED of regulatory regions |
| `--vep_cache` | yes | Path to local VEP cache |

## File Structure

```
bin/                    Python scripts (one per module)
nextflow/
├── main.nf
├── nextflow.config
├── conf/
│   ├── outputs.config  publishDir per process
│   └── resource.config process_low/medium/high labels
├── modules/
│   ├── input/
│   ├── annotation/
│   ├── protein/
│   ├── context/
│   ├── integration/
│   ├── ai/
│   └── output/
└── workflows/
    └── mutapath.nf
assets/
└── samplesheet.csv     example samplesheet
```

## Resource Labels

| Label | CPUs | Memory |
|-------|------|--------|
| `process_low` | 2 | 8 GB |
| `process_medium` | 8 | 32 GB |
| `process_high` | 16 | 64 GB |

## V1 Constraints

- No variant calling from raw reads
- No flux balance analysis
- No clinical pathogenicity classification
- No multiomics (RNA/proteomics/metabolomics) — planned post-V1
